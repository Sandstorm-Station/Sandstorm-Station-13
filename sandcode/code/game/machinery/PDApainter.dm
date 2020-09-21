/obj/machinery/pdapainter
	circuit = /obj/item/circuitboard/machine/pdapainter

/obj/machinery/pdapainter/New() //aug_manipulator code is so stupid that i sincerely can't make out why it doesn't just work normally 
	. = ..()								//in any case if you figure out how to make it just work normally, have a go at it.
	if(!component_parts)
		circuit = null
		circuit = new /obj/item/circuitboard/machine/pdapainter
		component_parts = list()
		component_parts += circuit

/obj/machinery/pdapainter/examine(mob/user)
	. += ..()
	if(panel_open)
		. += "<span class='info'>Its maintenance panel is currently open.</span>"

/obj/machinery/pdapainter/screwdriver_act(mob/living/user, obj/item/W)
	. = TRUE
	if(..())
		return
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, W))
		return TRUE
	return FALSE

/obj/machinery/pdapainter/crowbar_act(mob/living/user, obj/item/W)
	. = ..()
	if(default_deconstruction_crowbar(W, FALSE))
		return TRUE
