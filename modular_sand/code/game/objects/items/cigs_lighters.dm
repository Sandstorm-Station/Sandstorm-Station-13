/obj/item/lighter/set_lit(new_lit)
	. = ..()
	if(lit)
		playsound(src, 'modular_sand/sound/items/lighter/open.ogg', 50, 0)
	else
		playsound(src, 'modular_sand/sound/items/lighter/close.ogg', 50, 0)

/obj/item/clothing/mask/vape
	anthro_mob_worn_overlay = 'modular_sand/icons/mob/clothing/mask.dmi'
	mutantrace_variation = STYLE_MUZZLE & ~STYLE_NO_ANTHRO_ICON
