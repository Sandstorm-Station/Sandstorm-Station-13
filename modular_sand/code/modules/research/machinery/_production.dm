/obj/machinery/rnd/production/Initialize(mapload)
	. = ..()

	// Generate access lists
	gen_access()

/obj/machinery/rnd/production/ui_interact(mob/user)
	// Check if access is required
	if(!req_access)
		return ..()

	// Define machine user
	var/mob/living/carbon/human/machine_user = user

	// Check if user exists
	if(!istype(machine_user))
		return ..()

	// Define user ID card
	var/obj/item/card/id/user_id = machine_user.get_idcard()

	// Check if ID card was found
	if(!istype(user_id))
		// Warn in local chat, then return
		say("Access denied: Unable to scan user ID card.")
		return

	// Check for Captain
	if(ACCESS_CAPTAIN in user_id.access)
		// Allow usage
		return ..()

	// Check if access requirements are met
	if(check_access(user_id))
		// Allow use
		return ..()

	// User does not have access
	// Warn in local chat, then return
	say("Access denied: No valid departmental credentials detected.")
	return
