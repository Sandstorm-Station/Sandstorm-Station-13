/obj/item/organ/Insert(mob/living/carbon/organ_mob)
	. = ..()

	// Check parent return
	if(!.)
		return

	// Send signal to mob
	SEND_SIGNAL(organ_mob, COMSIG_MOB_ORGAN_ADD, src)

/obj/item/organ/Remove()
	. = ..()

	// Define organ mob
	var/mob/living/carbon/organ_mob = . || null

	// Check if organ mob exists
	if(!istype(organ_mob))
		return

	// Send signal to mob
	SEND_SIGNAL(organ_mob, COMSIG_MOB_ORGAN_REMOVE, src)
