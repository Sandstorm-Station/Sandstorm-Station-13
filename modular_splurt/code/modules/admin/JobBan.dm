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

	if (role_status)
		.["roles"] = role_status

/datum/jobban_panel/ui_static_data()
	. = list()
	updateJobbanStatus()
	.["roles"] = role_status

/datum/jobban_panel/ui_act(action, params, datum/tgui/ui)
	if(..())
		return

	if (!check_rights(R_BAN))
		to_chat(usr, "Error: You do not have sufficient admin rights to ban players.")
		return

	if(!SSjob)
		to_chat(usr, "Jobs subsystem not initialized yet!")
		return

	var/query = params["selected_role"] // Which role was clicked on the UI, .e.g. "Assistant" or "engineeringdept"
	var/is_category = params["is_category"]
	var/list/jobs_to_set = list() // All the roles relating to the selected role above

	to_chat(usr, "Query: " + query)

	if (is_category)
		for(var/list/role_category in role_status) // For every department / antag category
			if (role_category["category_name"] == query) // If this is the selected category
				to_chat(usr, "Category found: " + role_category["category_name"])

				for(var/list/role in role_category["category_roles"])
					jobs_to_set += role["name"]

				break
			else
				to_chat(usr, "NOT IT")

	else
		jobs_to_set += query

	to_chat(usr, "Total jobs to process:")
	for(var/role in jobs_to_set)
		to_chat(usr, role)






// Updates the jobban status of this client's jobban panel.
/datum/jobban_panel/proc/updateJobbanStatus()
	var/list/roles_to_check = list()
	var/list/roles = list()
	var/mob/M = targetClient.mob

	roles_to_check += list(list(
		"name" = "Command",
		"color" = "yellow",
		"roles" = GLOB.command_positions
	))
	roles_to_check += list(list(
		"name" = "Security",
		"color" = "red",
		"roles" = GLOB.security_positions
	))
	roles_to_check += list(list(
		"name" = "Engineering",
		"color" = "orange",
		"roles" = GLOB.engineering_positions
	))
	roles_to_check += list(list(
		"name" = "Medical",
		"color" = "blue",
		"roles" = GLOB.medical_positions
	))
	roles_to_check += list(list(
		"name" = "Science",
		"color" = "violet",
		"roles" = GLOB.science_positions
	))
	roles_to_check += list(list(
		"name" = "Supply",
		"color" = "brown",
		"roles" = GLOB.supply_positions
	))
	roles_to_check += list(list(
		"name" = "Service",
		"color" = "green",
		"roles" = GLOB.civilian_positions
	))
	roles_to_check += list(list(
		"name" = "Silicon",
		"color" = "purple",
		"roles" = GLOB.nonhuman_positions
	))

	for(var/list/role_category in roles_to_check) // For every department / antag category
		var/list/category_roles = list()
		category_roles["category_name"] = role_category["name"]
		category_roles["category_roles"] = list()

		for(var/role in role_category["roles"]) // For every job / antag
			var/list/roles_instance = list()
			roles_instance["name"] = role
			if(jobban_isbanned(M, role))
				roles_instance["is_banned"] = TRUE

			category_roles["category_roles"] += list(roles_instance)

		roles += list(category_roles)

	role_status = roles
