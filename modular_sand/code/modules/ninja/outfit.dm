/datum/outfit/ninja/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE, client/preference_source)
	. = ..()
	H.grant_language(/datum/language/modular_sand/neokanji, TRUE, TRUE, LANGUAGE_NINJA)
