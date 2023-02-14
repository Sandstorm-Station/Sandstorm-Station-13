///Adjust the thirst of a mob
/mob/proc/adjust_thirst(change, max = THIRST_LEVEL_THRESHOLD)
	thirst = clamp(thirst + change, 0, max)

/mob/proc/set_thirst(change)
	thirst = max(0, change)

/mob/proc/can_use_production(obj/machinery/rnd/production/machine_target)
	// Define machine user
	var/mob/living/carbon/human/machine_user = src

	// Check if user exists
	if(!istype(machine_user))
		return TRUE

	// Define user ID card
	var/obj/item/card/id/user_id = machine_user.get_idcard()

	// Check if ID card was found
	if(!istype(user_id))
		// Warn in local chat, then return
		machine_target.say("Access denied: Unable to scan user ID card.")
		return FALSE

	// Check for Captain
	if(ACCESS_CAPTAIN in user_id.access)
		// Allow usage
		return TRUE

	// Check if access requirements are met
	if(machine_target.check_access(user_id))
		// Allow use
		return TRUE

	// User does not have access
	// Warn in local chat, then return
	machine_target.say("Access denied: No valid departmental credentials detected.")
	return FALSE
