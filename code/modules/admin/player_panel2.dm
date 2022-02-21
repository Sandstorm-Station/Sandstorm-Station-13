GLOBAL_LIST_INIT(mute_bits, list(
	list(name = "IC", bitflag = MUTE_IC),
	list(name = "OOC", bitflag = MUTE_OOC),
	list(name = "Pray", bitflag = MUTE_PRAY),
	list(name = "Adminhelp", bitflag = MUTE_ADMINHELP),
	list(name = "Deadchat", bitflag = MUTE_DEADCHAT)
))

/datum/admins/proc/show_player_panel2(mob/M)
	if(!M)
		to_chat(owner, "You seem to be selecting a mob that doesn't exist anymore.")
		return

	// this is stupid, thanks byond
	if(istype(src, /client))
		var/client/C = src
		src = C.holder

	if(!check_rights())
		to_chat(owner, "Error: you are not an admin!")
		return

	if(!M.mob_panel)
		M.create_player_panel()

	M.mob_panel.ui_interact(owner.mob)

/datum/player_panel
	var/mob/targetMob
	var/client/targetClient
	var/list/roleStatus // A list of each role and whether they are banned or not for this player.
	var/isAntagBanned

/datum/player_panel/New(mob/target)
	. = ..()
	targetMob = target

/datum/player_panel/Destroy(force, ...)
	targetMob = null
	targetClient = null
	roleStatus = null
	isAntagBanned = null

	SStgui.close_uis(src)
	return ..()

/datum/player_panel/ui_interact(mob/user, datum/tgui/ui)
	if(!targetMob)
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "PlayerPanel2", "[targetMob.name] Player Panel")
		ui.open()

/datum/player_panel/ui_state(mob/user)
	return GLOB.admin_state

/datum/player_panel/ui_data(mob/user)
	. = list()
	.["mob_name"] = targetMob.name
	.["current_permissions"] = user.client?.holder?.rank.rights

	.["mob_type"] = targetMob.type

	.["glob_mute_bits"] = GLOB.mute_bits

	var/mob/living/L = targetMob
	if (istype(L))
		.["is_type_mob_living"] = TRUE
		.["is_frozen"] = L.admin_frozen
		.["is_slept"] = L.admin_sleeping

	if(targetMob.client)
		targetClient = targetMob.client
		.["client_ckey"] = targetClient.ckey
		.["client_muted"] = targetClient.prefs.muted
		.["client_rank"] = targetClient.holder ? targetClient.holder.rank : "Player"


		if (!roleStatus)
			updateJobbanStatus()
		.["roles"] = roleStatus
		.["is_antag_banned"] = isAntagBanned

	else
		targetClient = null
		roleStatus = null
		isAntagBanned = null
		.["client_ckey"] = null

/datum/player_panel/ui_static_data()
	. = list()

	if(targetMob.client)
		if(CONFIG_GET(flag/use_exp_tracking))
			.["playtimes_enabled"] = TRUE
			.["playtime"] = targetMob.client.get_exp_living()

/datum/player_panel/ui_act(action, params, datum/tgui/ui)
	if(..())
		return

	var/client/admin = ui.user.client

	if (!check_rights(R_ADMIN))
		message_admins("<span class='adminhelp'>WARNING: NON-ADMIN [ADMIN_LOOKUPFLW(admin)] ACCESSING ADMIN PANEL. WARN Casper#3044.</span>")
		to_chat(admin, "Error: you are not an admin!")
		return

	switch(action)
		if ("edit_rank")
			if (!targetMob.client?.ckey)
				priority_announce("failed client ckey check")
				return

			var/list/context = list()

			context["key"] = targetMob.client.ckey

			if (GLOB.admin_datums[targetMob.client.ckey] || GLOB.deadmins[targetMob.client.ckey])
				context["editrights"] = "rank"
			else
				context["editrights"] = "add"

			priority_announce("sending...")
			admin.holder.edit_rights_topic(context)

		if ("access_variables")
			admin.debug_variables(targetMob)

		if ("access_playtimes")
			if (targetMob.client)
				admin.holder.cmd_show_exp_panel(targetMob.client)

		if ("private_message")
			admin.cmd_admin_pm_context(targetMob)

		if ("subtle_message")
			admin.cmd_admin_subtle_message(targetMob)

		if ("set_name")
			targetMob.vv_auto_rename(params["name"])

		if ("heal")
			admin.cmd_admin_rejuvenate(targetMob)

		if ("ghost")
			if(targetMob.client)
				log_admin("[key_name(admin)] ejected [key_name(targetMob)] from their body.")
				message_admins("[key_name_admin(admin)] ejected [key_name_admin(targetMob)] from their body.")
				to_chat(targetMob, "<span class='danger'>An admin has ejected you from your body.</span>")
				targetMob.ghostize(FALSE)

		if ("smite")
			admin.smite(targetMob)

		if ("bring")
			admin.Getmob(targetMob)

		if ("orbit")
			if(!isobserver(admin.mob))
				admin.admin_ghost()
			var/mob/dead/observer/O = admin.mob
			O.ManualFollow(targetMob)

		if ("jump_to")
			admin.jumptomob(targetMob)

		if ("freeze")
			var/mob/living/L = targetMob
			if (istype(L))
				L.toggle_admin_freeze(admin)

		if ("sleep")
			var/mob/living/L = targetMob
			if (istype(L))
				L.toggle_admin_sleep(admin)

		if ("lobby")
			if(!isobserver(targetMob))
				to_chat(usr, "<span class='notice'>You can only send ghost players back to the Lobby.</span>")
				return

			if(!targetMob.client)
				to_chat(usr, "<span class='warning'>[targetMob] doesn't seem to have an active client.</span>")
				return

			log_admin("[key_name(usr)] has sent [key_name(targetMob)] back to the Lobby.")
			message_admins("[key_name(usr)] has sent [key_name(targetMob)] back to the Lobby.")

			var/mob/dead/new_player/NP = new()
			NP.ckey = targetMob.ckey
			qdel(targetMob)
			if(GLOB.preferences_datums[NP.ckey])
				var/datum/preferences/P = GLOB.preferences_datums[NP.ckey]
				P.respawn_restrictions_active = FALSE

		if ("force_say")
			targetMob.say(params["to_say"], forced="admin")

		if ("force_emote")
			targetMob.emote("me", EMOTE_VISIBLE, params["to_emote"])

		if ("prison")
			if(isAI(targetMob))
				to_chat(usr, "This cannot be used on instances of type /mob/living/silicon/ai.")
				return

			targetMob.forceMove(pick(GLOB.prisonwarp))
			to_chat(targetMob, "<span class='userdanger'>You have been sent to Prison!</span>")

			log_admin("[key_name(admin)] has sent [key_name(targetMob)] to Prison!")
			message_admins("[key_name_admin(admin)] has sent [key_name_admin(targetMob)] to Prison!")

		if ("kick")
			// Kick(targetMob)

		if ("ban")
			// NewBan(targetMob)

		if ("job_ban")
			if(targetMob.client)
				process_banlist(params["selected_role"], params["is_category"], params["want_to_ban"])

		if ("mute")
			if(!targetMob.client)
				return

			targetMob.client.prefs.muted = text2num(params["mute_flag"])
			log_admin("[key_name(admin)] set the mute flags for [key_name(targetMob)] to [targetMob.client.prefs.muted].")

// process_banlist: Gets all jobs in a job category
// Input:
// 	query (string): The name of the role / department you want to jobban.
//	is_category (boolean): Is the query a department / role category? e.g. query "Engineering" needs TRUE
//	want_to_ban (boolean): Should we ban or should we unban the job we just supplied.
//
// Output:A list of strings with the names of each role the INPUT covers.
/datum/player_panel/proc/process_banlist(query, is_category, want_to_ban)
	if(!SSjob)
		to_chat(usr, "Jobs subsystem not initialized yet!")
		return

	var/mob/M = targetClient.mob
	var/list/jobs_to_set = list() // All the roles relating to the clicked button

	if (is_category)
		for(var/list/role_category in roleStatus) // For every department / antag category
			if (role_category["category_name"] == query) // If this is the selected category

				for(var/list/role in role_category["category_roles"])
					jobs_to_set += role["name"]
				break

	else
		jobs_to_set += query

	var/list/jobs_to_set_trimmed = list() // The roles from jobs_to_set that aren't already banned / unbanned
	for(var/role in jobs_to_set)

		// If we are in ban mode and this role is unbanned OR if we are in unban mode and this role is banned
		// (We don't want to ban / unban roles that are already banned / unbanned)
		if ((want_to_ban && !jobban_isbanned(M, role)) || (!want_to_ban && jobban_isbanned(M, role)))
			jobs_to_set_trimmed += role

	for(var/role in jobs_to_set_trimmed)

	if (jobs_to_set_trimmed.len) // At least one role to get banned / unbanned
		if (want_to_ban)
			usr.client.holder.Jobban(targetClient.mob, jobs_to_set_trimmed)
		else
			usr.client.holder.UnJobban(targetClient.mob, jobs_to_set_trimmed)

		updateJobbanStatus() // Update TGUI data to reflect new ban statuses

// Updates the jobban status of this client's jobban panel.
/datum/player_panel/proc/updateJobbanStatus()
	var/list/roles = list()

	for(var/list/role_category in GLOB.jobban_panel_data) // For every department / antag category
		var/list/category_roles = list()
		category_roles["category_name"] = role_category["name"]
		category_roles["category_color"] = role_category["color"]
		category_roles["category_roles"] = list()

		for(var/role in role_category["roles"]) // For every job / antag
			var/list/roles_instance = list()
			roles_instance["name"] = role
			var/reason = jobban_isbanned(targetMob, role)
			if(reason)
				roles_instance["ban_reason"] = reason

			category_roles["category_roles"] += list(roles_instance)

		roles += list(category_roles)

	roleStatus = roles

	isAntagBanned = jobban_isbanned(targetMob, ROLE_SYNDICATE)
