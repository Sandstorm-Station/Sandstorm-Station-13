/mob/living/set_resting(new_resting, silent, updating)
	if(new_resting && HAS_TRAIT(src, TRAIT_FLOORED))
		return
	. = ..()

