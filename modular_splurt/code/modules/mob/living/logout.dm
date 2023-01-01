/mob/living/Logout()
	. = ..()
	
	// Check for BORIS AI borgs
	if(src in GLOB.available_ai_shells)
		return

	// Check for the AI
	if(isAI(src))
		return

	// Add to SSD list
	GLOB.ssd_mob_list |= src
