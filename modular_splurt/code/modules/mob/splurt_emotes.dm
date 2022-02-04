/datum/emote/living/bruh
	key = "bruh"
	key_third_person = "thinks this is a bruh moment"
	message = "thinks this is a bruh moment"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE

/datum/emote/living/bruh/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_splurt/sound/voice/bruh.ogg', 50, 1, -1)
