#define AFK_MINUTES_CRYO	40 MINUTES
#define AFK_MINUTES_TEXT	AFK_MINUTES_WARN/600

SUBSYSTEM_DEF(afk)
	name = "AFK Watcher"
	// Don't run until minimum time has passed
	wait = AFK_MINUTES_CRYO
	flags = SS_BACKGROUND

/datum/controller/subsystem/afk/Initialize()
	// Currently, this always runs by default
	return ..()

/datum/controller/subsystem/afk/fire()
	// Check possible targets
	for(var/mob/living/cryo_mob in GLOB.ssd_mob_list)
		// Get SSD time
		// This is set when disconnecting
		var/afk_time = world.time - cryo_mob.lastclienttime
		
		// Check if client meets the time requirement
		if(!(afk_time > AFK_MINUTES_CRYO))
			continue
		
		// Send to cryo
		cryoMob(cryo_mob, effects = TRUE)
		
		// Remove from SSD list
		GLOB.ssd_mob_list -= cryo_mob

#undef AFK_MINUTES_CRYO
#undef AFK_MINUTES_TEXT
