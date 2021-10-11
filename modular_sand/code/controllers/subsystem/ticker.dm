/datum/controller/subsystem/ticker/proc/force_gamemode(gamemode)
	if(gamemode)
		if(!modevoted)
			modevoted = TRUE
		if(gamemode in config.modes)
			GLOB.master_mode = gamemode
			SSticker.save_mode(gamemode)
			message_admins("The gamemode has been set to [gamemode].")
		else
			GLOB.master_mode = "extended"
			SSticker.save_mode("extended")
			message_admins("force_gamemode proc received an invalid gamemode, defaulting to extended.")
