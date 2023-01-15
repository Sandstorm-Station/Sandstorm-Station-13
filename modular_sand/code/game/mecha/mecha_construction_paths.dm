//Power armor: now actually built!
/datum/component/construction/unordered/mecha_chassis/powerarmor
	result = /datum/component/construction/mecha/powerarmor
	steps = list(
		/obj/item/mecha_parts/part/powerarmor_torso,
		/obj/item/mecha_parts/part/powerarmor_helmet,
		/obj/item/mecha_parts/part/powerarmor_left_arm,
		/obj/item/mecha_parts/part/powerarmor_right_arm,
		/obj/item/mecha_parts/part/powerarmor_left_leg,
		/obj/item/mecha_parts/part/powerarmor_right_leg
	)

/datum/component/construction/mecha/powerarmor/update_parent(step_index)
	..()
	var/atom/parent_atom = parent
	parent_atom.icon = 'modular_sand/icons/mecha/mech_construction.dmi'

/datum/component/construction/mecha/powerarmor/spawn_result()
	if(!result)
		return
	new result(drop_location())
	SSblackbox.record_feedback("tally", "mechas_created", 1, "Power Armor")
	QDEL_NULL(parent)

/datum/component/construction/mecha/powerarmor
	result = /obj/item/clothing/suit/space/hardsuit/powerarmor
	base_icon = "powerarmor"
	steps = list(
		//1
		list(
			"key" = TOOL_WRENCH,
			"desc" = "The parts are disconnected."
		),

		//2
		list(
			"key" = TOOL_WELDER,
			"back_key" = TOOL_WRENCH,
			"desc" = "The parts are wrenched."
		),

		//3
		list(
			"key" = /obj/item/stack/sheet/bluespace_crystal,
			"amount" = 5,
			"back_key" = TOOL_WELDER,
			"desc" = "The parts are welded onto the chassis."
		),

		//4
		list(
			"key" = TOOL_WRENCH,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The bluespace crystals are slotted."
		),

		//5
		list(
			"key" = /obj/item/stock_parts/capacitor/quadratic,
			"action" = ITEM_MOVE_INSIDE,
			"back_key" = TOOL_WRENCH,
			"desc" = "The bluespace crystals are secured."
		),

		//6
		list(
			"key" = TOOL_WRENCH,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The capacitor is slotted."
		),

		//7
		list(
			"key" = /obj/item/stack/cable_coil,
			"amount" = 10,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The capacitor is secured."
		),

		//8
		list(
			"key" = TOOL_SCREWDRIVER,
			"back_key" = TOOL_WIRECUTTER,
			"desc" = "The chassis is wired."
		),

		//9
		list(
			"key" = TOOL_WELDER,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The wiring is linked to the limbs."
		),
	)

/// Better than writing all of that new crap for something that's not even a mech.
/datum/component/construction/mecha/powerarmor/get_steps()
	return steps

/datum/component/construction/mecha/powerarmor/custom_action(obj/item/I, mob/living/user, diff)
	if(!..())
		return FALSE

	switch(index)
		if(1)
			user.visible_message("[user] wrenches [parent]'s parts.", span_notice("You wrench [parent]'s parts."))
		if(2)
			if(diff==FORWARD)
				user.visible_message("[user] welds [parent]'s parts.", span_notice("You weld [parent]'s parts"))
			else
				user.visible_message("[user] unwrenches [parent]'s parts.", span_notice("You unwrench [parent]'s parts."))
		if(3)
			if(diff==FORWARD)
				user.visible_message("[user] slots bluespace crystals onto [parent].", span_notice("You slot the bluespace crystals onto [parent]."))
			else
				user.visible_message("[user] unwelds [parent]'s parts.", span_notice("You unweld [parent]'s parts."))
		if(4)
			if(diff==FORWARD)
				user.visible_message("[user] secures the [parent]'s bluespace crystal slots.", span_notice("You secure the [parent]'s bluespace crystal slots"))
			else
				user.visible_message("[user] removes the bluespace crystals from [parent].", span_notice("You remove [parent]'s bluespace crystals."))
		if(5)
			if(diff==FORWARD)
				user.visible_message("[user] slots the capacitor onto [parent].", span_notice("You slot the capacitor onto [parent]."))
			else
				user.visible_message("[user] unsecures the bluespace crystal slots from [parent].", span_notice("You unsecure [parent]'s bluespace crystal slots."))
		if(6)
			if(diff==FORWARD)
				user.visible_message("[user] secures [parent]'s capacitor.", span_notice("You secure [parent]'s capacitor."))
			else
				user.visible_message("[user] removes the [parent]'s capacitor.", span_notice("You remove the [parent]'s capacitor."))
		if(7)
			if(diff==FORWARD)
				user.visible_message("[user] wires the [parent].", span_notice("You wire the [parent]."))
			else
				user.visible_message("[user] unsecures [parent]'s capacitor.", span_notice("You unsecure [parent]'s capacitor."))
		if(8)
			if(diff==FORWARD)
				user.visible_message("[user] links [parent]'s wires to the limbs.", span_notice("You link [parent]'s wires to the limbs."))
			else
				user.visible_message("[user] snips off [parent]'s wires.", span_notice("You snip off [parent]'s wires."))
		if(9)
			if(diff==FORWARD)
				user.visible_message("[user] welds [parent]'s external armor layer.", span_notice("You weld [parent]'s external armor layer."))
			else
				user.visible_message("[user] unlinks [parent]'s wires from the limbs.", span_notice("You unlink [parent]'s wires from the limbs."))
	return TRUE
