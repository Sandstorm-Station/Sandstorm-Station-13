/datum/species/proc/handle_thirst(mob/living/carbon/human/H)
	if(HAS_TRAIT(src, TRAIT_NOTHIRST))
		return

	//Put more things here if you plan on adding more things. I know this proc is a bit empty at the moment
	H.adjust_thirst(-THIRST_FACTOR)

/*	switch(H.thirst)
		if(THIRST_LEVEL_THIRSTY to INFINITY)
			H.clear_alert("thirst")
		if(THIRST_LEVEL_PARCHED to THIRST_LEVEL_THIRSTY)
			H.throw_alert("thirst", /obj/screen/alert/thirsty)
		if(0 to THIRST_LEVEL_PARCHED)
			H.throw_alert("thirst", /obj/screen/alert/dehydrated)
*/
