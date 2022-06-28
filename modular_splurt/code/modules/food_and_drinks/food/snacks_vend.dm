/obj/item/reagent_containers/food/snacks/jellybean
	name = "jelly bean"
	desc = "A rather large sized, colorful bean full of sugar."
	icon_state = "bean_template"
	icon = 'modular_splurt/icons/obj/food/food.dmi'
	bitesize = 4
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3)
	junkiness = 25
	filling_color = "#D2691E"
	tastes = list("candy" = 1)
	foodtype = JUNKFOOD | SUGAR
	var/list/possible_colors = list("orange" = COLOR_TAN_ORANGE, "black" = COLOR_BLACK, "white" = COLOR_WHITE, "yellow" = COLOR_YELLOW, "purple" = COLOR_AMETHYST, "green" = COLOR_LIME, "red" = COLOR_RED, "blue" = COLOR_BLUE)

/obj/item/reagent_containers/food/snacks/jellybean/Initialize(mapload)
	. = ..()
	var/chosen_color = pick(possible_colors)
	icon_state = replacetext(icon_state, "template", chosen_color)
	filling_color = possible_colors[chosen_color]

/obj/item/storage/fancy/jellybean_bowl
	name = "jelly bean bowl"
	desc = "It says \"take three\""
	icon = 'modular_splurt/icons/obj/food/food.dmi'
	icon_state = "bowl_beans"
	icon_type = "jelly bean"
	spawn_type = /obj/item/reagent_containers/food/snacks/jellybean
	fancy_open = TRUE

/obj/item/storage/fancy/jellybean_bowl/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 10
	STR.can_hold = typecacheof(list(/obj/item/reagent_containers/food/snacks/jellybean))
	STR.rustle_sound = FALSE

/obj/item/storage/fancy/jellybean_bowl/update_icon_state()
	if(fancy_open)
		var/stage
		switch(contents.len)
			if(8 to 9)
				stage = 3
			if(4 to 7)
				stage = 2
			if(1 to 3)
				stage = 1
			if(0)
				stage = 0
			else
				stage = 4
		icon_state = "bowl_beans_[stage]"
	else
		icon_state = "bowl_beans"

/obj/item/storage/fancy/jellybean_bowl/Exited()
	. = ..()
	switch(contents.len)
		if(4 to 6)
			to_chat(usr, span_notice("You take another jelly bean. How disgusting..."))
		if(1 to 3)
			to_chat(usr, span_notice("You take another jelly bean. You feel like the scum of the earth."))
		if(0)
			to_chat(usr, span_notice("You took too much too fast. The jelly beans spill onto the floor."))
		else
			to_chat(usr, span_notice("You take a jelly bean from the bowl."))

/obj/item/storage/fancy/jellybean_bowl/examine(mob/user)
	. = ..()
	if(contents.len <= 0)
		. += "Look at what you've done."
