GLOBAL_LIST_INIT(jobban_panel_data, list(
	list(
		"name" = "Command",
		"color" = "yellow",
		"roles" = GLOB.command_positions
	),
	list(
		"name" = "Security",
		"color" = "red",
		"roles" = GLOB.security_positions
	),
	list(
		"name" = "Engineering",
		"color" = "orange",
		"roles" = GLOB.engineering_positions
	),
	list(
		"name" = "Medical",
		"color" = "blue",
		"roles" = GLOB.medical_positions
	),
	list(
		"name" = "Science",
		"color" = "violet",
		"roles" = GLOB.science_positions
	),
	list(
		"name" = "Supply",
		"color" = "brown",
		"roles" = GLOB.supply_positions
	),
	list(
		"name" = "Service",
		"color" = "green",
		"roles" = GLOB.civilian_positions
	),
	list(
		"name" = "Silicon",
		"color" = "purple",
		"roles" = GLOB.nonhuman_positions
	),
	list(
		"name" = "Ghost Roles",
		"color" = "teal",
		"roles" = list(
			ROLE_PAI,
			ROLE_POSIBRAIN,
			ROLE_DRONE,
			ROLE_DEATHSQUAD,
			ROLE_LAVALAND,
			ROLE_GHOSTCAFE,
			ROLE_SENTIENCE,
			ROLE_MIND_TRANSFER
			)
	),
	list(
		"name" = "Other",
		"color" = "grey",
		"roles" = list(
			ROLE_RESPAWN
			)
	),
	list(
		"name" = "Antagonists",
		"color" = "red",
		"roles" = list(
			ROLE_TRAITOR,
			ROLE_CHANGELING,
			ROLE_HERETIC,
			ROLE_OPERATIVE,
			ROLE_REV,
			ROLE_CULTIST,
			ROLE_SERVANT_OF_RATVAR,
			ROLE_WIZARD,
			ROLE_ABDUCTOR,
			ROLE_ALIEN,
			ROLE_FAMILIES,
			ROLE_BLOODSUCKER,
			ROLE_SLAVER
			)
	)
))

/datum/admins/proc/show_jobban_panel(client/C)
	if(!istype(C, /client))
		to_chat(owner, "This client is no longer in the game.")
		return

	// this is stupid, thanks byond
	if(istype(src, /client))
		var/client/Cl = src
		src = Cl.holder

	if(!check_rights())
		to_chat(owner, "Error: you are not an admin!")
		return

	if(!C.jobban_panel)
		C.create_jobban_panel()

	C.jobban_panel.ui_interact(owner.mob)

/datum/jobban_panel
	var/client/targetClient
	var/list/role_status // A list of each role and whether they are banned or not for this player.

/datum/jobban_panel/New(client/target)
	. = ..()
	targetClient = target

/datum/jobban_panel/Destroy(force, ...)
	targetClient = null

	SStgui.close_uis(src)
	return ..()

/datum/jobban_panel/ui_interact(mob/user, datum/tgui/ui)
	if(!targetClient)
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "JobbanPanel", "[targetClient.ckey] Jobban Panel")
		ui.open()

/datum/jobban_panel/ui_state(mob/user)
	return GLOB.admin_state

/datum/jobban_panel/ui_data(mob/user)
	. = list()
	.["client_ckey"] = targetClient.ckey
	.["is_antag_banned"] = jobban_isbanned(targetClient.mob, ROLE_SYNDICATE)

	if (!role_status)
		updateJobbanStatus()
	.["roles"] = role_status

// /datum/jobban_panel/ui_static_data()
// 	. = list()

/datum/jobban_panel/ui_act(action, params, datum/tgui/ui)
	if(..())
		return

	if (!check_rights(R_BAN))
		to_chat(usr, "Error: You do not have sufficient admin rights to ban players.")
		return

	if(!SSjob)
		to_chat(usr, "Jobs subsystem not initialized yet!")
		return

	var/mob/M = targetClient.mob
	var/list/jobs_to_set = list() // All the roles relating to the clicked button

	if (params["is_category"])
		for(var/list/role_category in role_status) // For every department / antag category
			if (role_category["category_name"] == params["selected_role"]) // If this is the selected category

				for(var/list/role in role_category["category_roles"])
					jobs_to_set += role["name"]
				break

	else
		jobs_to_set += params["selected_role"]

	var/mode = params["want_to_ban"]

	var/list/jobs_to_set_trimmed = list() // The roles from jobs_to_set that aren't already banned / unbanned
	for(var/role in jobs_to_set)

		// If we are in ban mode and this role is unbanned OR if we are in unban mode and this role is banned
		// (We don't want to ban / unban roles that are already banned / unbanned)
		if ((mode && !jobban_isbanned(M, role)) || (!mode && jobban_isbanned(M, role)))
			jobs_to_set_trimmed += role

	for(var/role in jobs_to_set_trimmed)

	if (jobs_to_set_trimmed.len) // At least one role to get banned / unbanned
		if (mode)
			usr.client.holder.Jobban(targetClient.mob, jobs_to_set_trimmed)
		else
			usr.client.holder.UnJobban(targetClient.mob, jobs_to_set_trimmed)

		updateJobbanStatus() // Update TGUI data to reflect new ban statuses

// Updates the jobban status of this client's jobban panel.
/datum/jobban_panel/proc/updateJobbanStatus()
	var/list/roles = list()
	var/mob/M = targetClient.mob

	for(var/list/role_category in GLOB.jobban_panel_data) // For every department / antag category
		var/list/category_roles = list()
		category_roles["category_name"] = role_category["name"]
		category_roles["category_color"] = role_category["color"]
		category_roles["category_roles"] = list()

		for(var/role in role_category["roles"]) // For every job / antag
			var/list/roles_instance = list()
			roles_instance["name"] = role
			var/reason = jobban_isbanned(M, role)
			if(reason)
				roles_instance["is_banned"] = TRUE
				roles_instance["ban_reason"] = reason

			category_roles["category_roles"] += list(roles_instance)

		roles += list(category_roles)

	role_status = roles

// notbannedlist is just a list of strings of the job titles you want to ban.
/datum/admins/proc/Jobban(mob/M, list/notbannedlist)
	var/severity = null
	var/reason = null

	switch(tgui_alert(usr, "Job ban type", buttons = list("Temporary", "Permanent", "Cancel")))
		if("Temporary")
			var/mins = input(usr,"How long (in minutes)?","Ban time",1440) as num|null
			if(mins <= 0)
				to_chat(usr, "<span class='danger'>[mins] is not a valid duration.</span>")
				return
			reason = input(usr,"Please State Reason For Banning [M.key].","Reason") as message|null
			if(!reason)
				return
			severity = tgui_alert(usr, "Set the severity of the note/ban", buttons = list("High", "Medium", "Minor", "None"))
			if(!severity)
				return
			var/msg
			for(var/job in notbannedlist)
				if(!DB_ban_record(BANTYPE_JOB_TEMP, M, mins, reason, job))
					to_chat(usr, "<span class='danger'>Failed to apply ban.</span>")
					return
				if(M.client)
					jobban_buildcache(M.client)
				ban_unban_log_save("[key_name(usr)] temp-jobbanned [key_name(M)] from [job] for [mins] minutes. reason: [reason]")
				log_admin_private("[key_name(usr)] temp-jobbanned [key_name(M)] from [job] for [mins] minutes.")
				if(!msg)
					msg = job
				else
					msg += ", [job]"
			create_message("note", M.key, null, "Banned  from [msg] - [reason]", null, null, 0, 0, null, 0, severity)
			message_admins("<span class='adminnotice'>[key_name_admin(usr)] banned [key_name_admin(M)] from [msg] for [mins] minutes.</span>")
			to_chat(M, "<span class='boldannounce'><BIG>You have been [((msg == "ooc") || (msg == "appearance") || (msg == "pacifist")) ? "banned" : "jobbanned"] by [usr.client.key] from: [msg == "pacifist" ? "using violence" : msg].</BIG></span>")
			to_chat(M, "<span class='boldannounce'>The reason is: [reason]</span>")
			to_chat(M, "<span class='danger'>This jobban will be lifted in [mins] minutes.</span>")

		if("Permanent")
			reason = input(usr,"Please State Reason For Banning [M.key].","Reason") as message|null
			if (!reason)
				return
			severity = tgui_alert(usr, "Please State Reason For Banning", buttons = list("High", "Medium", "Minor", "None"))
			if (!severity)
				return

			var/msg
			for(var/job in notbannedlist)
				if(!DB_ban_record(BANTYPE_JOB_PERMA, M, -1, reason, job))
					to_chat(usr, "<span class='danger'>Failed to apply ban.</span>")
					return
				if(M.client)
					jobban_buildcache(M.client)
				ban_unban_log_save("[key_name(usr)] perma-jobbanned [key_name(M)] from [job]. reason: [reason]")
				log_admin_private("[key_name(usr)] perma-banned [key_name(M)] from [job]")
				if(!msg)
					msg = job
				else
					msg += ", [job]"
			create_message("note", M.key, null, "Banned  from [msg] - [reason]", null, null, 0, 0, null, 0, severity)
			message_admins("<span class='adminnotice'>[key_name_admin(usr)] banned [key_name_admin(M)] from [msg].</span>")
			to_chat(M, "<span class='boldannounce'><BIG>You have been [((msg == "ooc") || (msg == "appearance") || (msg == "pacifist")) ? "banned" : "jobbanned"] by [usr.client.key] from: [msg == "pacifist" ? "using violence" : msg].</BIG></span>")
			to_chat(M, "<span class='boldannounce'>The reason is: [reason]</span>")
			to_chat(M, "<span class='danger'>This jobban can be lifted only upon request.</span>")

// notbannedlist is just a list of strings of the job titles you want to unban.
/datum/admins/proc/UnJobban(mob/M, list/bannedlist)
	var/msg
	for(var/job in bannedlist)
		var/reason = jobban_isbanned(M, job)
		if (tgui_alert(usr, "Job: '[job]' Reason: '[reason]'", "Un-Jobban This Player?", list("Yes", "No")) == "Yes")
			ban_unban_log_save("[key_name(usr)] unjobbanned [key_name(M)] from [job]")
			log_admin_private("[key_name(usr)] unbanned [key_name(M)] from [job]")
			DB_ban_unban(M.ckey, BANTYPE_ANY_JOB, job)
			if(M.client)
				jobban_buildcache(M.client)
			if(!msg)
				msg = job
			else
				msg += ", [job]"
	if(msg)
		message_admins("<span class='adminnotice'>[key_name_admin(usr)] unbanned [key_name_admin(M)] from [msg].</span>")
		to_chat(M, "<span class='boldannounce'><BIG>You have been un-jobbanned by [usr.client.key] from [msg].</BIG></span>")




