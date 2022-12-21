#define AFK_MINUTES_WARN	30 MINUTES // NOT IMPLEMENTED
#define AFK_MINUTES_CRYO	40 MINUTES
#define AFK_MINUTES_TEXT	AFK_MINUTES_WARN/600
#define AFK_CRYO_ENABLED	TRUE

SUBSYSTEM_DEF(afk)
	name = "AFK Watcher"
	wait = 30
	flags = SS_BACKGROUND

/datum/controller/subsystem/afk/Initialize()
	// Check if this should run
	if(!AFK_CRYO_ENABLED)
		flags |= SS_NO_FIRE
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

		// Define ckey
		var/client/cryo_client = cryo_mob.ckey
		
		// Log this occurrence
		log_admin("[key_name(cryo_client)] has been sent to cryo by the AFK Watcher subsystem after being AFK for [AFK_MINUTES_TEXT] minutes.")

		// Alert user
		to_chat(cryo_client, "<span class='danger'>You have been sent to cryo for exceeding the [AFK_MINUTES_TEXT] minute AFK time limit.</span>")

		// Send to cryo
		cryoMob(cryo_mob, effects = TRUE)
		
		// Remove from SSD list
		GLOB.ssd_mob_list -= cryo_mob

#undef AFK_MINUTES_WARN
#undef AFK_MINUTES_CRYO
#undef AFK_MINUTES_TEXT
#undef AFK_CRYO_ENABLED
