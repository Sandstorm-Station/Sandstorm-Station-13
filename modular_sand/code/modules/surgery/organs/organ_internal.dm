/obj/item/organ/Insert(mob/living/carbon/M, special = 0, drop_if_replaced = TRUE)
	. = ..()

	// Check parent return
	if(!.)
		return

	// Send signal to mob
	SEND_SIGNAL(M, COMSIG_MOB_ORGAN_ADD, src)

/obj/item/organ/Remove(special = FALSE)
	. = ..()

	// Define organ mob
	var/mob/living/carbon/organ_mob = . || null

	// Check if organ mob exists
	if(!istype(organ_mob))
		return

	// Send signal to mob
	SEND_SIGNAL(organ_mob, COMSIG_MOB_ORGAN_REMOVE, src)
