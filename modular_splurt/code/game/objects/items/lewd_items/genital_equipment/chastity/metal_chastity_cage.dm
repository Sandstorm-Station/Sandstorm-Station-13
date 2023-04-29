/obj/item/genital_equipment/chastity_cage/metal
	name = "metal chastity cage"
	icon_state = "metal_cage"

	break_time = 40 SECONDS
	break_require = TOOL_WELDER
	
	var/jingle_chance = 1.25//in percentage

/obj/item/genital_equipment/chastity_cage/metal/equip()
	. = ..()
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, .proc/on_move)

/obj/item/genital_equipment/chastity_cage/metal/proc/on_move(atom/old_loc, dir)
	if(owner.stat == CONSCIOUS && prob(jingle_chance))
		owner.visible_message("<span class='warning'>[owner.name] jingles slightly as they move.</span>",
							"<span class='warning'>You jingle slightly as you move.")

/obj/item/genital_equipment/chastity_cage/metal/unequip_process(obj/item/organ/genital/G)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	. = ..()
