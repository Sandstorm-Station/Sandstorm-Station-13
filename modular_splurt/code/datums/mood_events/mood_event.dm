/datum/mood_event/proc/owner_mob()
	var/mob/living/carbon/human/actual_owner
	var/datum/component/mood/wrong_declaration = owner
	if(istype(wrong_declaration))
		actual_owner = wrong_declaration.parent
	else
		actual_owner = owner
	return actual_owner
