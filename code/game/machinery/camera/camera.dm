#define CAMERA_UPGRADE_XRAY 1
#define CAMERA_UPGRADE_EMP_PROOF 2
#define CAMERA_UPGRADE_MOTION 4

/obj/machinery/camera
	name = "security camera"
	desc = "It's used to monitor rooms."
	icon = 'icons/obj/machines/camera.dmi'
	icon_state = "camera"
	light_color = "#CDDDFF"
	use_power = ACTIVE_POWER_USE
	idle_power_usage = 5
	active_power_usage = 10
	layer = WALL_OBJ_LAYER

	resistance_flags = FIRE_PROOF

	armor = list(MELEE = 50, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 0, BIO = 0, RAD = 0, FIRE = 90, ACID = 50)
	max_integrity = 100
	integrity_failure = 0.5
	var/list/network = list("ss13")
	var/c_tag = null
	var/status = TRUE
	var/start_active = FALSE //If it ignores the random chance to start broken on round start
	var/invuln = null
	var/obj/item/camera_bug/bug = null
	var/obj/structure/camera_assembly/assembly = null
	var/area/myarea = null

	//OTHER

	var/view_range = 7
	var/short_range = 2

	var/alarm_on = FALSE
	var/busy = FALSE
	var/emped = FALSE  //Number of consecutive EMP's on this camera
	var/in_use_lights = 0

	// Upgrades bitflag
	var/upgrades = 0

	var/internal_light = TRUE //Whether it can light up when an AI views it
	///Represents a signel source of camera alarms about movement or camera tampering
	var/datum/alarm_handler/alarm_manager

	/// A copy of the last paper object that was shown to this camera.
	var/obj/item/paper/last_shown_paper

/obj/machinery/camera/preset/toxins //Bomb test site in space
	name = "Hardened Bomb-Test Camera"
	desc = "A specially-reinforced camera with a long lasting battery, used to monitor the bomb testing site. An external light is attached to the top."
	c_tag = "Bomb Testing Site"
	network = list("rd","toxins")
	use_power = NO_POWER_USE //Test site is an unpowered area
	invuln = TRUE
	light_range = 10
	start_active = TRUE

/obj/machinery/camera/Initialize(mapload, obj/structure/camera_assembly/CA)
	. = ..()
	for(var/i in network)
		network -= i
		network += lowertext(i)
	if(CA)
		assembly = CA
	else
		assembly = new(src)
		assembly.state = 4
	GLOB.cameranet.cameras += src
	GLOB.cameranet.addCamera(src)
	if (isturf(loc))
		myarea = get_area(src)
		LAZYADD(myarea.cameras, src)
	proximity_monitor = new(src, 1)

	if(mapload && is_station_level(z) && prob(3) && !start_active)
		toggle_cam()

	alarm_manager = new(src)

/obj/machinery/camera/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock, idnum, override=FALSE)
	for(var/i in network)
		network -= i
		network += "[idnum][i]"

/obj/machinery/camera/Destroy()
	if(can_use())
		toggle_cam(null, 0) //kick anyone viewing out and remove from the camera chunks
	GLOB.cameranet.cameras -= src
	cancelCameraAlarm()
	if(isarea(myarea))
		LAZYREMOVE(myarea.cameras, src)
	QDEL_NULL(alarm_manager)
	QDEL_NULL(assembly)
	if(bug)
		bug.bugged_cameras -= c_tag
		if(bug.current == src)
			bug.current = null
		bug = null

	QDEL_NULL(last_shown_paper)
	return ..()

/obj/machinery/camera/emp_act(severity)
	. = ..()
	if(!status)
		return
	if(!(. & EMP_PROTECT_SELF))
		if(prob(severity/0.7))
			update_icon()
			var/list/previous_network = network
			network = list()
			GLOB.cameranet.removeCamera(src)
			machine_stat |= EMPED
			set_light(0)
			emped = emped+1  //Increase the number of consecutive EMP's
			update_icon()
			var/thisemp = emped //Take note of which EMP this proc is for
			spawn(900)
				if(loc) //qdel limbo
					triggerCameraAlarm() //camera alarm triggers even if multiple EMPs are in effect.
					if(emped == thisemp) //Only fix it if the camera hasn't been EMP'd again
						network = previous_network
						machine_stat &= ~EMPED
						update_icon()
						if(can_use())
							GLOB.cameranet.addCamera(src)
						emped = 0 //Resets the consecutive EMP count
						addtimer(CALLBACK(src, PROC_REF(cancelCameraAlarm)), 100)
			for(var/i in GLOB.player_list)
				var/mob/M = i
				if (M.client.eye == src)
					M.unset_machine()
					M.reset_perspective(null)
					to_chat(M, "The screen bursts into static.")

/obj/machinery/camera/ex_act(severity, target, origin)
	if(invuln)
		return
	..()

/obj/machinery/camera/proc/setViewRange(num = 7)
	src.view_range = num
	GLOB.cameranet.updateVisibility(src, 0)

/obj/machinery/camera/proc/shock(mob/living/user)
	if(!istype(user))
		return
	user.electrocute_act(10, src)

/obj/machinery/camera/singularity_pull(S, current_size)
	if (status && current_size >= STAGE_FIVE) // If the singulo is strong enough to pull anchored objects and the camera is still active, turn off the camera as it gets ripped off the wall.
		toggle_cam(null, 0)
	..()

// Construction/Deconstruction
/obj/machinery/camera/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	panel_open = !panel_open
	to_chat(user, "<span class='notice'>You screw the camera's panel [panel_open ? "open" : "closed"].</span>")
	I.play_tool_sound(src)
	return TRUE

/obj/machinery/camera/wirecutter_act(mob/living/user, obj/item/I)
	if(!panel_open)
		return FALSE
	toggle_cam(user, 1)
	obj_integrity = max_integrity //this is a pretty simplistic way to heal the camera, but there's no reason for this to be complex.
	I.play_tool_sound(src)
	return TRUE

/obj/machinery/camera/multitool_act(mob/living/user, obj/item/I)
	if(!panel_open)
		return FALSE

	setViewRange((view_range == initial(view_range)) ? short_range : initial(view_range))
	to_chat(user, "<span class='notice'>You [(view_range == initial(view_range)) ? "restore" : "mess up"] the camera's focus.</span>")
	return

/obj/machinery/camera/welder_act(mob/living/user, obj/item/I)
	if(!panel_open)
		return FALSE

	if(!I.tool_start_check(user, amount=0))
		return TRUE

	to_chat(user, "<span class='notice'>You start to weld [src]...</span>")
	if(I.use_tool(src, user, 100, volume=50))
		user.visible_message("<span class='warning'>[user] unwelds [src], leaving it as just a frame bolted to the wall.</span>",
			"<span class='warning'>You unweld [src], leaving it as just a frame bolted to the wall</span>")
		deconstruct(TRUE)

	return TRUE

/obj/machinery/camera/attackby(obj/item/attacking_item, mob/living/user, params)
	// UPGRADES
	if(panel_open)
		if(attacking_item.tool_behaviour == TOOL_ANALYZER)
			if(!isXRay())
				if(!user.temporarilyRemoveItemFromInventory(attacking_item))
					return
				qdel(attacking_item)
				upgradeXRay()
				to_chat(user, span_notice("You attach [attacking_item] into the assembly's inner circuits."))
			else
				to_chat(user, span_notice("[src] already has that upgrade!"))
			return

		else if(istype(attacking_item, /obj/item/stack/sheet/mineral/plasma))
			if(!isEmpProof())
				if(attacking_item.use_tool(src, user, 0, amount=1))
					upgradeEmpProof()
					to_chat(user, span_notice("You attach [attacking_item] into the assembly's inner circuits."))
			else
				to_chat(user, span_notice("[src] already has that upgrade!"))
			return

		else if(istype(attacking_item, /obj/item/assembly/prox_sensor))
			if(!isMotion())
				if(!user.temporarilyRemoveItemFromInventory(attacking_item))
					return
				upgradeMotion()
				to_chat(user, span_notice("You attach [attacking_item] into the assembly's inner circuits."))
				qdel(attacking_item)
			else
				to_chat(user, span_notice("[src] already has that upgrade!"))
			return

	// OTHER
	if(istype(attacking_item, /obj/item/pda) && isliving(user))
		var/itemname = ""
		var/info = ""

		var/obj/item/pda/pda = attacking_item
		itemname = pda.name
		info = pda.note

		itemname = sanitize(itemname)
		info = sanitize(info)
		to_chat(user, span_notice("You hold \the [itemname] up to the camera..."))
		user.log_talk(itemname, LOG_GAME, log_globally=TRUE, tag="Pressed to camera")
		user.DelayNextAction(CLICK_CD_MELEE)

		for(var/mob/potential_viewer in GLOB.player_list)
			if(isAI(potential_viewer))
				var/mob/living/silicon/ai/ai = potential_viewer
				if(ai.control_disabled || (ai.stat == DEAD))
					return

				ai.log_talk(itemname, LOG_VICTIM, tag="Pressed to camera from [key_name(user)]", log_globally=FALSE)
				ai.last_pda_note_seen = "<HTML><HEAD><TITLE>[itemname]</TITLE></HEAD><BODY><TT>[info]</TT></BODY></HTML>"

				if(user.name == "Unknown")
					to_chat(ai, "[span_name(user)] holds <a href='?_src_=usr;show_pda=1;'>\a [itemname]</a> up to one of your cameras ...")
				else
					to_chat(ai, "<b><a href='?src=[REF(ai)];track=[html_encode(user.name)]'>[user]</a></b> holds <a href='?_src_=usr;show_pda=1;'>\a [itemname]</a> up to one of your cameras ...")
				continue

			if (potential_viewer.client?.eye == src)
				to_chat(potential_viewer, "[span_name("[user]")] holds \a [itemname] up to one of the cameras ...")
				potential_viewer.log_talk(itemname, LOG_VICTIM, tag="Pressed to camera from [key_name(user)]", log_globally=FALSE)
				potential_viewer << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", itemname, info), text("window=[]", itemname))
		return

	if(istype(attacking_item, /obj/item/paper))
		// Grab the paper, sanitise the name as we're about to just throw it into chat wrapped in HTML tags.
		var/obj/item/paper/paper = attacking_item

		// Make a complete copy of the paper, store a ref to it locally on the camera.
		last_shown_paper = paper.copy(paper.type, null);

		// Then sanitise the name because we're putting it directly in chat later.
		var/item_name = sanitize(last_shown_paper.name)

		// Start the process of holding it up to the camera.
		to_chat(user, span_notice("You hold \the [item_name] up to the camera..."))
		user.log_talk(item_name, LOG_GAME, log_globally=TRUE, tag="Pressed to camera")
		user.DelayNextAction(CLICK_CD_MELEE)

		// And make a weakref we can throw around to all potential viewers.
		last_shown_paper.camera_holder = WEAKREF(src)

		// Iterate over all living mobs and check if anyone is elibile to view the paper.
		// This is backwards, but cameras don't store a list of people that are looking through them,
		// and we'll have to iterate this list anyway so we can use it to pull out AIs too.
		for(var/mob/potential_viewer in GLOB.player_list)
			// All AIs view through cameras, so we need to check them regardless.
			if(isAI(potential_viewer))
				var/mob/living/silicon/ai/ai = potential_viewer
				if(ai.control_disabled || (ai.stat == DEAD))
					continue

				ai.log_talk(item_name, LOG_VICTIM, tag="Pressed to camera from [key_name(user)]", log_globally=FALSE)
				log_paper("[key_name(user)] held [last_shown_paper] up to [src], requesting [key_name(ai)] read it.")

				if(user.name == "Unknown")
					to_chat(ai, "[span_name(user)] holds <a href='?_src_=usr;show_paper_note=[REF(last_shown_paper)];'>\a [item_name]</a> up to one of your cameras ...")
				else
					to_chat(ai, "<b><a href='?src=[REF(ai)];track=[html_encode(user.name)]'>[user]</a></b> holds <a href='?_src_=usr;show_paper_note=[REF(last_shown_paper)];'>\a [item_name]</a> up to one of your cameras ...")
				continue

			// If it's not an AI, eye if the client's eye is set to the camera. I wonder if this even works anymore with tgui camera apps and stuff?
			if (potential_viewer.client?.eye == src)
				log_paper("[key_name(user)] held [last_shown_paper] up to [src], and [key_name(potential_viewer)] may read it.")
				potential_viewer.log_talk(item_name, LOG_VICTIM, tag="Pressed to camera from [key_name(user)]", log_globally=FALSE)
				to_chat(potential_viewer, "[span_name(user)] holds <a href='?_src_=usr;show_paper_note=[REF(last_shown_paper)];'>\a [item_name]</a> up to your camera...")
		return

	else if(istype(attacking_item, /obj/item/camera_bug))
		if(!can_use())
			to_chat(user, span_notice("Camera non-functional."))
			return
		if(bug)
			to_chat(user, span_notice("Camera bug removed."))
			bug.bugged_cameras -= src.c_tag
			bug = null
		else
			to_chat(user, span_notice("Camera bugged."))
			bug = attacking_item
			bug.bugged_cameras[src.c_tag] = src
		return

	else if(istype(attacking_item, /obj/item/pai_cable))
		var/obj/item/pai_cable/cable = attacking_item
		cable.plugin(src, user)
		return

	return ..()

/obj/machinery/camera/run_obj_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	if(damage_flag == MELEE && damage_amount < 12 && !(machine_stat & BROKEN))
		return FALSE
	. = ..()

/obj/machinery/camera/obj_break(damage_flag)
	if(status && !(flags_1 & NODECONSTRUCT_1))
		triggerCameraAlarm()
		toggle_cam(null, 0)

/obj/machinery/camera/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(disassembled)
			if(!assembly)
				assembly = new()
			assembly.forceMove(drop_location())
			assembly.state = 1
			assembly.setDir(dir)
			assembly = null
		else
			var/obj/item/I = new /obj/item/wallframe/camera (loc)
			I.obj_integrity = I.max_integrity * 0.5
			new /obj/item/stack/cable_coil(loc, 2)
	qdel(src)

/obj/machinery/camera/update_icon_state()
	if(!status)
		icon_state = "[initial(icon_state)]1"
	else if (machine_stat & EMPED)
		icon_state = "[initial(icon_state)]emp"
	else
		icon_state = "[initial(icon_state)][in_use_lights ? "_in_use" : ""]"

/obj/machinery/camera/proc/toggle_cam(mob/user, displaymessage = 1)
	status = !status
	if(can_use())
		GLOB.cameranet.addCamera(src)
		if (isturf(loc))
			myarea = get_area(src)
			LAZYADD(myarea.cameras, src)
		else
			myarea = null
	else
		set_light(0)
		GLOB.cameranet.removeCamera(src)
		if (isarea(myarea))
			LAZYREMOVE(myarea.cameras, src)
	GLOB.cameranet.updateChunk(x, y, z)
	var/change_msg = "deactivates"
	if(status)
		change_msg = "reactivates"
		triggerCameraAlarm()
		if(!QDELETED(src)) //We'll be doing it anyway in destroy
			addtimer(CALLBACK(src, PROC_REF(cancelCameraAlarm)), 100)
	if(displaymessage)
		if(user)
			visible_message("<span class='danger'>[user] [change_msg] [src]!</span>")
			add_hiddenprint(user)
		else
			visible_message("<span class='danger'>\The [src] [change_msg]!</span>")

		playsound(src.loc, 'sound/items/wirecutter.ogg', 100, 1)
	update_icon()

	// now disconnect anyone using the camera
	//Apparently, this will disconnect anyone even if the camera was re-activated.
	//I guess that doesn't matter since they can't use it anyway?
	for(var/mob/O in GLOB.player_list)
		if (O.client && O.client.eye == src)
			O.unset_machine()
			O.reset_perspective(null)
			to_chat(O, "The screen bursts into static.")

/obj/machinery/camera/proc/triggerCameraAlarm()
	alarm_on = TRUE
	alarm_manager.send_alarm(ALARM_CAMERA, src, src)

/obj/machinery/camera/proc/cancelCameraAlarm()
	alarm_on = FALSE
	alarm_manager.clear_alarm(ALARM_CAMERA)

/obj/machinery/camera/proc/can_use()
	if(!status)
		return FALSE
	if(machine_stat & EMPED)
		return FALSE
	return TRUE

/obj/machinery/camera/proc/can_see()
	var/list/see = null
	var/turf/pos = get_turf(src)
	if(isXRay())
		see = range(view_range, pos)
	else
		see = get_hear(view_range, pos)
	return see

/atom/proc/auto_turn()
	//Automatically turns based on nearby walls.
	var/turf/closed/wall/T = null
	for(var/i in GLOB.cardinals)
		T = get_ranged_target_turf(src, i, 1)
		if(istype(T))
			setDir(turn(i, 180))
			break

//Return a working camera that can see a given mob
//or null if none
/proc/seen_by_camera(var/mob/M)
	for(var/obj/machinery/camera/C in oview(4, M))
		if(C.can_use())	// check if camera disabled
			return C
	return null

/proc/near_range_camera(var/mob/M)
	for(var/obj/machinery/camera/C in range(4, M))
		if(C.can_use())	// check if camera disabled
			return C

	return null

/obj/machinery/camera/proc/Togglelight(on=0)
	for(var/mob/living/silicon/ai/A in GLOB.ai_list)
		for(var/obj/machinery/camera/cam in A.lit_cameras)
			if(cam == src)
				return
	if(on)
		set_light(AI_CAMERA_LUMINOSITY, 0.8)
	else
		set_light(0)

/obj/machinery/camera/get_remote_view_fullscreens(mob/user)
	if(view_range == short_range) //unfocused
		user.overlay_fullscreen("remote_view", /atom/movable/screen/fullscreen/scaled/impaired, 2)

/obj/machinery/camera/update_remote_sight(mob/living/user)
	user.see_invisible = SEE_INVISIBLE_LIVING //can't see ghosts through cameras
	if(isXRay())
		user.sight |= (SEE_TURFS|SEE_MOBS|SEE_OBJS)
		user.see_in_dark = max(user.see_in_dark, 8)
	else
		user.sight = 0
		user.see_in_dark = 2
	return TRUE
