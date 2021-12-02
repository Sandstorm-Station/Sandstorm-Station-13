/datum/antagonist/slaver
	name = "Slave Trader"
	roundend_category = "slaver"
	antagpanel_category = "Slaver"
	job_rank = ROLE_SLAVER
	antag_moodlet = /datum/mood_event/focused
	threat = 7
	show_to_ghosts = TRUE
	var/datum/team/slavers/slaver_team = new /datum/team/slavers
	var/send_to_spawnpoint = TRUE //Should the user be moved to default spawnpoint.
	var/slaver_outfit = /datum/outfit/slaver

/datum/antagonist/slaver/proc/update_slaver_icons_added(mob/living/M)
	var/datum/atom_hud/antag/slaverhud = GLOB.huds[ANTAG_HUD_SLAVER]
	slaverhud.join_hud(M)
	set_antag_hud(M, "slaver")

/datum/antagonist/slaver/proc/update_slaver_icons_removed(mob/living/M)
	var/datum/atom_hud/antag/slaverhud = GLOB.huds[ANTAG_HUD_SLAVER]
	slaverhud.leave_hud(M)
	set_antag_hud(M, null)

/datum/antagonist/slaver/apply_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	update_slaver_icons_added(M)

/datum/antagonist/slaver/remove_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	update_slaver_icons_removed(M)

/datum/antagonist/slaver/proc/equip_slaver()
	if(!ishuman(owner.current))
		return
	var/mob/living/carbon/human/H = owner.current

	//H.set_species(/datum/species/human) //Plasamen burn up otherwise, and lizards are vulnerable to asimov AIs

	H.equipOutfit(slaver_outfit)
	return TRUE

/datum/antagonist/slaver/greet()
	owner.current.playsound_local(get_turf(owner.current), 'sound/ambience/antag/ops.ogg',100,0)
	to_chat(owner, "<span class='notice'>You are a slave trader!</span>")
	owner.announce_objectives()

/datum/antagonist/slaver/on_gain()
	forge_objectives()
	. = ..()
	equip_slaver()
	if(send_to_spawnpoint)
		move_to_spawnpoint()

/datum/antagonist/slaver/get_team()
	return slaver_team

/datum/antagonist/slaver/proc/forge_objectives()
	objectives |= slaver_team.objectives

/datum/antagonist/slaver/proc/move_to_spawnpoint()
	owner.current.forceMove(GLOB.slaver_start[(0 % GLOB.slaver_start.len) + 1])

/datum/antagonist/slaver/leader/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.slaver_leader_start))

/datum/antagonist/slaver/admin_add(datum/mind/new_owner,mob/admin)
	new_owner.assigned_role = ROLE_SLAVER
	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] has slaver'd [new_owner.current].")
	log_admin("[key_name(admin)] has slaver'd [new_owner.current].")

/datum/antagonist/slaver/get_admin_commands()
	. = ..()
	.["Send to base"] = CALLBACK(src,.proc/admin_send_to_base)

/datum/antagonist/slaver/proc/admin_send_to_base(mob/admin)
	owner.current.forceMove(pick(GLOB.slaver_start))

/datum/antagonist/slaver/leader
	name = "Slave Master"
	slaver_outfit = /datum/outfit/slaver/leader

/datum/antagonist/slaver/leader/greet()
	owner.current.playsound_local(get_turf(owner.current), 'sound/ambience/antag/ops.ogg',100,0)
	to_chat(owner, "<B>You are the Slave Master for this collection job. You are responsible for organising your team and your ID is the only one who can open the launch bay doors.</B>")
	to_chat(owner, "<B>If you feel you are not up to this task, give your ID to another slaver.</B>")
	owner.announce_objectives()
	addtimer(CALLBACK(src, .proc/slavers_name_assign), 1)


/datum/antagonist/slaver/leader/proc/slavers_name_assign()
	slaver_team.slaver_crew_name = ask_name()
	// priority_announce("Message test 123 123 Message test 123 123 Message test 123 123 Message test 123 123 Message test 123 123.", sender_override = "Hail from the [slaver_team.slaver_crew_name]")

/datum/antagonist/slaver/leader/proc/ask_name()
	var/defaultname = slaver_team.slaver_crew_name
	var/newname = stripped_input(owner.current, "You are the slave master. Please choose a name for your crew.", "Crew name", defaultname)
	if (!newname)
		newname = defaultname
	else
		newname = reject_bad_name(newname)
		if(!newname)
			newname = defaultname

	return capitalize(newname)

/datum/team/slavers
	var/slaver_crew_name = "Slave Traders"
	var/core_objective = /datum/objective/slaver

/datum/team/slavers/proc/update_objectives()
	if(core_objective)
		var/datum/objective/O = new core_objective
		O.team = src
		objectives += O

/datum/team/pirate/roundend_report()
	var/list/parts = list()

	parts += "<span class='header'>Space Pirates were:</span>"

	var/all_dead = TRUE
	for(var/datum/mind/M in members)
		if(considered_alive(M))
			all_dead = FALSE
	parts += printplayerlist(members)

	parts += "Loot stolen: "
	var/datum/objective/loot/L = locate() in objectives
	parts += L.loot_listing()
	parts += "Total loot value : [L.get_loot_value()]/[L.target_value] credits"

	if(L.check_completion() && !all_dead)
		parts += "<span class='greentext big'>The pirate crew was successful!</span>"
	else
		parts += "<span class='redtext big'>The pirate crew has failed.</span>"

	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"

/datum/team/slavers/roundend_report()
	var/list/parts = list()
	parts += "<span class='header'>[slaver_crew_name] Crew:</span>"

	var/text = "<br><span class='header'>The syndicate operatives were:</span>"
	var/purchases = ""
	var/TC_uses = 0
	LAZYINITLIST(GLOB.uplink_purchase_logs_by_key)
	for(var/I in members)
		var/datum/mind/syndicate = I
		var/datum/uplink_purchase_log/H = GLOB.uplink_purchase_logs_by_key[syndicate.key]
		if(H)
			TC_uses += H.total_spent
			purchases += H.generate_render(show_key = FALSE)
	text += printplayerlist(members)
	text += "<br>"
	text += "(Syndicates used [TC_uses] TC) [purchases]"

	parts += text

	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"

/datum/team/slavers/antag_listing_name()
	if(slaver_crew_name)
		return "[slaver_crew_name] Syndico"
	else
		return "Syndicaa"

/datum/team/slavers/is_gamemode_hero()
	return SSticker.mode.name == "slave hunters"

/proc/is_slaver(mob/M)
	return M && istype(M) && M.mind && M.mind.has_antag_datum(/datum/antagonist/slaver)

// /datum/round_event_control/operative
// 	name = "Slave Traders"
// 	typepath = /datum/round_event/ghost_role/slavers
// 	weight = 0 //Admin only
// 	max_occurrences = 1
