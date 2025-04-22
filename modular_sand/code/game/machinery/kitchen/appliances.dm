// we ball
/obj/machinery/griddle
	name = "griddle"
	desc = "Because using pans is for pansies."
	density = TRUE
	anchored = TRUE
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "griddle1_off"
	var/activated = 0

/obj/machinery/griddle/attackby(obj/item/W, mob/user, params)
	if(user.a_intent != INTENT_HARM && !(W.item_flags & ABSTRACT))
		if(user.temporarilyRemoveItemFromInventory(W))
			W.forceMove(get_turf(src))
			var/list/click_params = params2list(params)
			//Center the icon where the user clicked.
			if(!click_params || !click_params["icon-x"] || !click_params["icon-y"])
				return
			//Clamp it so that the icon never moves more than 16 pixels in either direction (thus leaving the table turf)
			W.pixel_x = clamp(text2num(click_params["icon-x"]) - 16, -(world.icon_size/2), world.icon_size/2)
			W.pixel_y = clamp(text2num(click_params["icon-y"]) - 16, -(world.icon_size/2), world.icon_size/2)

/obj/machinery/griddle/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	if (activated)
		to_chat(user, "<span class='notice'>You turn off the griddle.</span>")
		icon_state = "griddle1_off"
		activated = FALSE
	else
		to_chat(user, "<span class='notice'>You turn on the griddle.</span>")
		icon_state = "griddle1_on"
		activated = TRUE

/obj/machinery/griddle/proc/Cook()
	var/turf/current_location = get_turf(src)
	for(var/A in current_location)
		if(A == src)
			continue
		else if(istype(A, /obj/item) && prob(20))
			var/obj/item/O = A
			O.microwave_act()

/obj/machinery/griddle/process()
	if (activated)
		Cook()