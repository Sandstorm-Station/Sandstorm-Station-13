/obj/machinery/computer/slavery
	name = "\improper slave management console"
	desc = "Used to track and manage collared slaves. The limited range reaches only as far as the hideout perimeter."
	icon_screen = "explosive"
	icon_keyboard = "security_key"
	clockwork = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	req_access = list(ACCESS_SLAVER)
	light_color = LIGHT_COLOR_RED

// /obj/machinery/computer/slavery/ui_interact(mob/user)
// 	. = ..()
// 	var/dat = ""
// 	dat += "<a href='byond://?src=[REF(src)];scan=1'>Refresh.</a><BR>"
// 	dat += "[storedcrystals] telecrystals are available for distribution. <BR>"
// 	dat += "<BR><BR>"

// 	dat += "<HR>Slaves<BR>"
// 	for(var/obj/item/electropack/shockcollar/slave/S in GLOB.tracked_slaves)
// 		if(!isliving(loc))
// 			continue
// 		Tr = get_turf(T.imp_in)
// 		if((Tr) && (Tr.z != src.z))
// 			continue//Out of range

// 		var/loc_display = "Unknown"
// 		var/mob/living/M = T.imp_in
// 		if(is_station_level(Tr.z) && !isspaceturf(M.loc))
// 			var/turf/mob_loc = get_turf(M)
// 			loc_display = mob_loc.loc

// 		dat += "ID: [T.imp_in.name] | Location: [loc_display]<BR>"
// 		dat += "<A href='?src=[REF(src)];warn=[REF(T)]'>(<font class='bad'><i>Message Holder</i></font>)</A> |<BR>"
// 		dat += "********************************<BR>"
// 	dat += "<HR><A href='?src=[REF(src)];lock=1'>{Log Out}</A>"

/obj/machinery/computer/slavery/ui_interact(mob/user, datum/tgui/ui)
	// priority_announce("Message test 123 123 Message test 123 123 Message test 123 123 Message test 123 123 Message test 123 123.", sender_override = "Hail from the [slaver_team.slaver_crew_name]")
	// if(!GLOB.bounties_list.len)
	// 	setup_bounties()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SlaveConsole", name)
		ui.open()

/obj/machinery/computer/slavery/ui_data(mob/user)
	var/list/data = list()

	var/turf/curr = get_turf(src)
	data["currentCoords"] = "[curr.x], [curr.y], [curr.z]"

	var/list/slaves = list()
	data["slaves"] = list()

	for(var/tracked_slave in GLOB.tracked_slaves)
		var/obj/item/electropack/shockcollar/slave/C = tracked_slave
		if (!isliving(C.loc))
			continue;

		var/mob/living/L = C.loc
		var/turf/pos = get_turf(L)
		if(!pos || pos.z != curr.z || C == L.get_item_by_slot(SLOT_NECK))
			continue

		var/list/slave = list()
		slave["id"] = C.collarID
		priority_announce("Getting collar ID first: [C.GetID()] end.", sender_override = "toggleBought")
		slave["name"] = L.real_name
		slave["bought"] = C.bought

		slave["coords"] = "[pos.x], [pos.y], [pos.z]"
		slave["dist"] = max(get_dist(curr, pos), 0) //Distance between the machine and slave turfs
		slave["degrees"] = round(Get_Angle(curr, pos)) //0-360 degree directional bearing, for more precision.
		slaves += list(slave) //Add this slave to the list of slaves
	data["slaves"] = slaves
	return data

/obj/machinery/computer/slavery/ui_act(action, params)
	if(..())
		return

	switch(action)
		if ("makePriorityAnnouncement")
			priority_announce("Announcement.", sender_override = "Beep Beep upgate")
			// var/is_ai = issilicon(user)
			// if(!SScommunications.can_announce(user, is_ai))
			// 	to_chat(user, "<span class='alert'>Intercomms recharging. Please stand by.</span>")
			// 	return
			// var/input = stripped_input(user, "Please choose a message to announce to the station crew.", "What?")
			// if(!input || !user.canUseTopic(src, !issilicon(usr)))
			// 	return
			// if(!(user.can_speak())) //No more cheating, mime/random mute guy!
			// 	input = "..."
			// 	to_chat(user, "<span class='warning'>You find yourself unable to speak.</span>")
			// else
			// 	input = user.treat_message(input) //Adds slurs and so on. Someone should make this use languages too.
			// SScommunications.make_announcement(user, is_ai, input)
			// deadchat_broadcast(" made a priority announcement from <span class='name'>[get_area_name(usr, TRUE)]</span>.", "<span class='name'>[user.real_name]</span>", user)

		if("purchaseSupplies")
			priority_announce("Purchase Supplies.", sender_override = "Beep Beep upgate")

		if("toggleBought")
			var/boughtID = text2num(params["id"])
			priority_announce("Collar ID is: [boughtID] end.", sender_override = "toggleBought")

			for(var/tracked_slave in GLOB.tracked_slaves)
				var/obj/item/electropack/shockcollar/slave/C = tracked_slave
				if (C.collarID == boughtID)
					if (!isliving(C.loc))
						priority_announce("Not living location", sender_override = "toggleBought")
						continue;

					var/mob/living/L = C.loc
					priority_announce("Slave ckey is: [L.ckey] end.", sender_override = "toggleBought")


