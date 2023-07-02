/mob/living/handle_micro_bump_other(mob/living/target)
	// If the target has the preference off, stop the interaction.
	if(target.client.prefs.unholypref == "No")
		return FALSE

	// Do the rest of the function normally.
	. = ..()
