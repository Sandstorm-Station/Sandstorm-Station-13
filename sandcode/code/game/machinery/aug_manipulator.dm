/obj/machinery/aug_manipulator
	circuit = /obj/item/circuitboard/machine/aug_manipulator

/obj/machinery/aug_manipulator/examine(mob/user)
	. += ..()
	. += "<span class='info'>Its maintenance panel is currently [panel_open ? "open" : "closed"].</span>"

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
