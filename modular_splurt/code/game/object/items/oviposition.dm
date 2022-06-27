/obj/item/oviposition_egg
	name = "egg"
	desc = "An egg, this one looks suspiciously large though."
	icon_state = "egg"
	icon = 'icons/obj/food/food.dmi'
	integrity_failure = 0.9
	obj_flags = UNIQUE_RENAME

/obj/item/oviposition_egg/obj_break(damage_flag)
	. = ..()
	//implement later
