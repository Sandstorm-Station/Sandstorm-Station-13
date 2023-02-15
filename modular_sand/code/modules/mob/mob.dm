// Configuration defines
#define JOB_MINIMAL_ACCESS CONFIG_GET(flag/jobs_have_minimal_access)
#define PROTOLOCK_DURING_NONMIN CONFIG_GET(flag/protolock_during_nonmin)
#define PROTOLOCK_CHECK_ALL_IDS CONFIG_GET(flag/protolock_check_all_ids)

// Only Clients should have a panel for them, okay?
/mob/Login()
	. = ..()
	AddComponent(/datum/component/interaction_menu_granter)

/mob/Logout()
	qdel(GetComponent(/datum/component/interaction_menu_granter))
	. = ..()

///Adjust the thirst of a mob
/mob/proc/adjust_thirst(change, max = THIRST_LEVEL_THRESHOLD)
	thirst = clamp(thirst + change, 0, max)

/mob/proc/set_thirst(change)
	thirst = max(0, change)

/mob/proc/can_use_production(obj/machinery/rnd/production/machine_target)
	// Check if server is NOT using minimal access
	// This is intended for low populations
	if((!JOB_MINIMAL_ACCESS) && (!PROTOLOCK_DURING_NONMIN))
		// Allow unrestricted use
		return TRUE

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

	// Check if the machine should iterate over all possible IDs
	if(PROTOLOCK_CHECK_ALL_IDS)
		// Define variable for if finding a valid ID
		var/found_valid_crew = FALSE

		// Iterate over alive crew
		for(var/mob/living/carbon/human/iter_user in GLOB.alive_mob_list)
			// Ignore mobs with no mind
			if(!iter_user.mind)
				continue

			// Define user ID card
			var/obj/item/card/id/iter_id = iter_user.get_idcard()

			// Check if ID card was found
			// If not: Ignore user
			if(!istype(iter_id))
				continue

			// Check if ID has access
			if(machine_target.check_access(iter_id))
				// Set found ID variable
				found_valid_crew = TRUE

				// End loop
				break

		// Check if valid crew was found
		if(!found_valid_crew)
			// No valid crew was found
			// Allow access
			return TRUE

	// User does not have access
	// Warn in local chat, then return
	machine_target.say("Access denied: No valid departmental credentials detected.")
	return FALSE

#undef JOB_MINIMAL_ACCESS
#undef PROTOLOCK_DURING_NONMIN
#undef PROTOLOCK_CHECK_ALL_IDS
