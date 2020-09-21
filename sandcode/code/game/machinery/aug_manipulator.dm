/obj/machinery/aug_manipulator
	circuit = /obj/item/circuitboard/machine/aug_manipulator

/obj/machinery/aug_manipulator/Initialize() //aug_manipulator code is so stupid that i sincerely can't make out why it doesn't just work normally 
	. = ..()								//in any case if you figure out how to make it just work normally, have a go at it.
	if(!component_parts)
		circuit = null
		circuit = new /obj/item/circuitboard/machine/aug_manipulator
		component_parts = list()
		component_parts += circuit

/obj/machinery/aug_manipulator/examine(mob/user)
	. += ..()
	if(panel_open)
		. += "<span class='info'>Its maintenance panel is currently open.</span>"

/obj/machinery/aug_manipulator/screwdriver_act(mob/living/user, obj/item/W)
	. = TRUE
	if(..())
		return
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, W))
		return TRUE
	return FALSE

/obj/machinery/aug_manipulator/crowbar_act(mob/living/user, obj/item/W)
	. = ..()
	if(default_deconstruction_crowbar(W, FALSE))
		return TRUE
