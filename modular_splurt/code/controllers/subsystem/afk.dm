SUBSYSTEM_DEF(auto_cryo)
	name = "Automated Cryogenics"
	flags = SS_BACKGROUND
	
	// Placeholder value in case of config failure (40 minutes)
	var/autocryo_time_trigger = 24000

/datum/controller/subsystem/auto_cryo/Initialize()
	// Check config before running
	if(CONFIG_GET(flag/autocryo_disabled))
		can_fire = FALSE

	// Set time for trigger
	autocryo_time_trigger = CONFIG_GET(number/autocryo_time_trigger)

	return ..()

/datum/controller/subsystem/auto_cryo/fire()
	// Check possible targets
	for(var/mob/living/cryo_mob in GLOB.ssd_mob_list)
		// Get SSD time
		// This is set when disconnecting
		var/afk_time = world.time - cryo_mob.lastclienttime
		
		// Check if client meets the time requirement
		if(!(afk_time > autocryo_time_trigger))
			continue
		
		// Send to cryo
		cryoMob(cryo_mob, effects = TRUE)
		
		// Remove from SSD list
		GLOB.ssd_mob_list -= cryo_mob
