/mob/living/handle_micro_bump_helping(mob/living/target)
	// If the target is not a pushover, stop the interaction.
	if(!HAS_TRAIT(target, TRAIT_PUSHOVER))
		return FALSE

	// Do the rest of the function normally.
	. = ..()

/mob/living/handle_micro_bump_other(mob/living/target) // I am not sure why this is a different function.
	// If the target is not a pushover, stop the interaction.
	if(!HAS_TRAIT(target, TRAIT_PUSHOVER))
		return FALSE

	// Do the rest of the function normally.
	. = ..()
