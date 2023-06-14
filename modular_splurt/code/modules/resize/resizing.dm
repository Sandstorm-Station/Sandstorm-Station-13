/mob/living/handle_micro_bump_other(mob/living/target)
	// If the target is not a pushover, stop the interaction.
	if(!HAS_TRAIT(target, TRAIT_PUSHOVER))
		return FALSE

	// Do the rest of the function normally.
	. = ..()
