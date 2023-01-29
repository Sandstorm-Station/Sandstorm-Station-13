//SAVANNAH-IVANOV
/datum/component/construction/unordered/mecha_chassis/savannah_ivanov
	result = /datum/component/construction/mecha/savannah_ivanov
	steps = list(
		/obj/item/mecha_parts/part/savannah_ivanov_torso,
		/obj/item/mecha_parts/part/savannah_ivanov_head,
		/obj/item/mecha_parts/part/savannah_ivanov_left_arm,
		/obj/item/mecha_parts/part/savannah_ivanov_right_arm,
		/obj/item/mecha_parts/part/savannah_ivanov_left_leg,
		/obj/item/mecha_parts/part/savannah_ivanov_right_leg
	)

/datum/component/construction/mecha/savannah_ivanov
	result = /obj/vehicle/sealed/mecha/combat/savannah_ivanov
	base_icon = "savannah_ivanov"

	//has_weapons_module = TRUE

	circuit_control = /obj/item/circuitboard/mecha/savannah_ivanov/main
	circuit_periph = /obj/item/circuitboard/mecha/savannah_ivanov/peripherals
	circuit_weapon = /obj/item/circuitboard/mecha/savannah_ivanov/targeting

	inner_plating = /obj/item/stack/sheet/plasteel
	inner_plating_amount = 10

	outer_plating = /obj/item/mecha_parts/part/savannah_ivanov_armor
	outer_plating_amount = 1

/datum/component/construction/mecha/savannah_ivanov/custom_action(obj/item/I, mob/living/user, diff)
	if(!..())
		return FALSE

	//TODO: better messages.
	switch(index)
		if(1)
			user.visible_message(span_notice("[user] connects [parent] hydraulic systems."), span_notice("You connect [parent] hydraulic systems."))
		if(2)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] activates [parent] hydraulic systems."), span_notice("You activate [parent] hydraulic systems."))
			else
				user.visible_message(span_notice("[user] disconnects [parent] hydraulic systems."), span_notice("You disconnect [parent] hydraulic systems."))
		if(3)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] adds the wiring to [parent]."), span_notice("You add the wiring to [parent]."))
			else
				user.visible_message(span_notice("[user] deactivates [parent] hydraulic systems."), span_notice("You deactivate [parent] hydraulic systems."))
		if(4)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] adjusts the wiring of [parent]."), span_notice("You adjust the wiring of [parent]."))
			else
				user.visible_message(span_notice("[user] removes the wiring from [parent]."), span_notice("You remove the wiring from [parent]."))
		if(5)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] installs [I] into [parent]."), span_notice("You install [I] into [parent]."))
			else
				user.visible_message(span_notice("[user] disconnects the wiring of [parent]."), span_notice("You disconnect the wiring of [parent]."))
		if(6)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] secures the mainboard."), span_notice("You secure the mainboard."))
			else
				user.visible_message(span_notice("[user] removes the central control module from [parent]."), span_notice("You remove the central computer mainboard from [parent]."))
		if(7)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] installs [I] into [parent]."), span_notice("You install [I] into [parent]."))
			else
				user.visible_message(span_notice("[user] unfastens the mainboard."), span_notice("You unfasten the mainboard."))
		if(8)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] secures the peripherals control module."), span_notice("You secure the peripherals control module."))
			else
				user.visible_message(span_notice("[user] removes the peripherals control module from [parent]."), span_notice("You remove the peripherals control module from [parent]."))
		if(9)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] installs [I] into [parent]."), span_notice("You install [I] into [parent]."))
			else
				user.visible_message(span_notice("[user] unfastens the peripherals control module."), span_notice("You unfasten the peripherals control module."))
		if(10)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] secures the scanner module."), span_notice("You secure the scanner module."))
			else
				user.visible_message(span_notice("[user] removes the scanner module from [parent]."), span_notice("You remove the scanner module from [parent]."))
		if(11)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] installs [I] to [parent]."), span_notice("You install [I] to [parent]."))
			else
				user.visible_message(span_notice("[user] unfastens the scanner module."), span_notice("You unfasten the scanner module."))
		if(12)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] secures the capacitor."), span_notice("You secure the capacitor."))
			else
				user.visible_message(span_notice("[user] removes the capacitor from [parent]."), span_notice("You remove the capacitor from [parent]."))
		if(13)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] installs [I] into [parent]."), span_notice("You install [I] into [parent]."))
			else
				user.visible_message(span_notice("[user] unfastens the capacitor."), span_notice("You unfasten the capacitor."))
		if(14)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] secures the power cell."), span_notice("You secure the power cell."))
			else
				user.visible_message(span_notice("[user] pries the power cell from [parent]."), span_notice("You pry the power cell from [parent]."))
		if(15)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] installs the internal armor layer to [parent]."), span_notice("You install the internal armor layer to [parent]."))
			else
				user.visible_message(span_notice("[user] unfastens the power cell."), span_notice("You unfasten the power cell."))
		if(16)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] secures the internal armor layer."), span_notice("You secure the internal armor layer."))
			else
				user.visible_message(span_notice("[user] pries internal armor layer from [parent]."), span_notice("You pry internal armor layer from [parent]."))
		if(17)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] welds the internal armor layer to [parent]."), span_notice("You weld the internal armor layer to [parent]."))
			else
				user.visible_message(span_notice("[user] unfastens the internal armor layer."), span_notice("You unfasten the internal armor layer."))
		if(18)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] installs the external armor layer to [parent]."), span_notice("You install the external reinforced armor layer to [parent]."))
			else
				user.visible_message(span_notice("[user] cuts the internal armor layer from [parent]."), span_notice("You cut the internal armor layer from [parent]."))
		if(19)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] secures the external armor layer."), span_notice("You secure the external reinforced armor layer."))
			else
				user.visible_message(span_notice("[user] pries the external armor layer from [parent]."), span_notice("You pry the external armor layer from [parent]."))
		if(20)
			if(diff==FORWARD)
				user.visible_message(span_notice("[user] welds the external armor layer to [parent]."), span_notice("You weld the external armor layer to [parent]."))
			else
				user.visible_message(span_notice("[user] unfastens the external armor layer."), span_notice("You unfasten the external armor layer."))
	return TRUE
