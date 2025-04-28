// we ball
/obj/machinery/griddle
	name = "griddle"
	desc = "Because using pans is for pansies."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "griddle1_off"
	density = TRUE
	pass_flags_self = PASSMACHINE | PASSTABLE | LETPASSTHROW // It's roughly the height of a table.
	idle_power_usage = 5
	active_power_usage = 100
	circuit = /obj/item/circuitboard/machine/griddle
	resistance_flags = FIRE_PROOF

	///Things that are being griddled right now
	var/list/griddled_objects = list()
	///Looping sound for the grill
	var/datum/looping_sound/grill/grill_loop
	///Whether or not the machine is turned on right now
	var/on = FALSE
	///Time to finish cooking
	var/seconds_to_finish = 30 SECONDS

/obj/machinery/griddle/Initialize(mapload)
	. = ..()
	grill_loop = new(src, FALSE)
	var/static/list/content_handlers = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
		COMSIG_ATOM_EXITED = PROC_REF(on_exited),
		COMSIG_ATOM_CREATED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, content_handlers)

/obj/machinery/griddle/Destroy()
	QDEL_NULL(grill_loop)
	return ..()

/obj/machinery/griddle/RefreshParts()
	. = ..()
	for(var/obj/item/stock_parts/micro_laser in component_parts)
		seconds_to_finish = initial(seconds_to_finish) / micro_laser.rating

/obj/machinery/griddle/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	if(default_deconstruction_crowbar(I, ignore_panel = TRUE))
		return STOP_ATTACK_PROC_CHAIN

/obj/machinery/griddle/attackby(obj/item/I, mob/user, params)
	var/list/modifiers = params2list(params)
	//Center the icon where the user clicked.
	if(!LAZYACCESS(modifiers, "icon-x") || !LAZYACCESS(modifiers, "icon-y"))
		return
	if(user.transferItemToLoc(I, get_turf(src), silent = FALSE))
		//Clamp it so that the icon never moves more than 16 pixels in either direction (thus leaving the table turf)
		I.pixel_x = clamp(text2num(LAZYACCESS(modifiers, ICON_X)) - 16, -(world.icon_size/2), world.icon_size/2)
		I.pixel_y = clamp(text2num(LAZYACCESS(modifiers, ICON_Y)) - 16, -(world.icon_size/2), world.icon_size/2)
		to_chat(user, span_notice("You place [I] on [src]."))
	else
		return ..()

/obj/machinery/griddle/interact(mob/user, special_state)
	. = ..()
	toggle_mode()

/obj/machinery/griddle/proc/toggle_mode()
	on = !on
	if(on)
		begin_processing()
	else
		end_processing()
	update_appearance()
	update_grill_audio()

/obj/machinery/griddle/proc/begin_processing()
	START_PROCESSING(SSmachines, src)
	for(var/obj/item/thing in griddled_objects)
		start_cooking(thing)

/obj/machinery/griddle/proc/end_processing()
	STOP_PROCESSING(SSmachines, src)
	for(var/obj/item/thing in griddled_objects)
		stop_cooking(thing)

/obj/machinery/griddle/proc/update_grill_audio()
	if(on && griddled_objects.len)
		grill_loop.start()
	else
		grill_loop.stop()

/obj/machinery/griddle/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool, time = 2 SECONDS)
	return STOP_ATTACK_PROC_CHAIN

/obj/machinery/griddle/process(seconds_per_tick)
	use_power(active_power_usage * length(griddled_objects))

	var/turf/griddle_loc = loc
	if(isturf(griddle_loc))
		griddle_loc.hotspot_expose(800, 100)

/obj/machinery/griddle/update_icon_state()
	icon_state = "griddle1_[on ? "on" : "off"]"
	return ..()

/obj/machinery/griddle/proc/on_entered(atom/movable/source, atom/movable/enterer, atom/old_loc)
	if(enterer in griddled_objects)
		return
	griddled_objects += enterer
	update_grill_audio()
	if(on)
		start_cooking(enterer)

/obj/machinery/griddle/proc/on_exited(atom/movable/source, atom/movable/leaver, atom/new_loc)
	if(!(leaver in griddled_objects))
		return
	stop_cooking(leaver)
	griddled_objects -= leaver
	update_grill_audio()

/obj/machinery/griddle/Move(atom/newloc, direct, glide_size_override)
	. = ..()
	for(var/atom/movable/thing as anything in griddled_objects)
		thing.forceMove(loc)

/obj/machinery/griddle/proc/start_cooking(obj/item/thing)
	if(griddled_objects[thing])
		return
	griddled_objects[thing] = addtimer(CALLBACK(src, PROC_REF(handle_cooked), thing), seconds_to_finish, TIMER_STOPPABLE | TIMER_DELETE_ME)

/obj/machinery/griddle/proc/stop_cooking(obj/item/thing)
	if(!(thing in griddled_objects))
		return
	deltimer(griddled_objects[thing])
	griddled_objects[thing] = null

/obj/machinery/griddle/proc/handle_cooked(obj/item/source)
	if(!(source in griddled_objects))
		return
	on_exited(src, source) // might get deleted past this point!!
	if(istype(source))
		source.microwave_act()
		if(QDELETED(source))
			return
	source.fire_act(1000) //Hot hot hot!
	if(prob(10))
		visible_message(span_danger("[source] doesn't seem to be doing too great on the [src]!"))

	on_entered(src, source)
