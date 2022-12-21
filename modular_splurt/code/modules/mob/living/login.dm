/mob/living/Login()
	. = ..()
	// Remove from SSD list
	GLOB.ssd_mob_list -= src
