/datum/species/althelp(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	if(user == target && istype(user))
		if(HAS_TRAIT(user, TRAIT_FLOORED))
			to_chat(user, "<span class='warning'>You can't seem to force yourself up right now!</span>")
			return
	. = ..()
