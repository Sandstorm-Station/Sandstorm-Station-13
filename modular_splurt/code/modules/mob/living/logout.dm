/mob/living/Logout()
	. = ..()
	// Add to SSD list
	GLOB.ssd_mob_list |= src
