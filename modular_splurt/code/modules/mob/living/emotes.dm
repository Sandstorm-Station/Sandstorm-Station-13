//Main code edits
/datum/emote/living/audio_emote/laugh/run_emote(mob/user, params)
	. = ..()

	// Check parent return
	if(!.)
		return

	// Define carbon user
	var/mob/living/carbon/carbon_user = user

	// Check if carbon user exists
	if(!istype(carbon_user))
		return

	// Check for subraces
	if(ishumanbasic(carbon_user) || iscatperson(carbon_user) || isinsect(carbon_user) || isjellyperson(carbon_user))
		return

	// Define default laugh type
	// Defaults to male
	var/laugh_sound = 'sound/voice/human/manlaugh1.ogg'

	// Check gender
	switch(user.gender)
		// Female
		if(FEMALE)
			// Set laugh sound
			laugh_sound = 'sound/voice/human/womanlaugh.ogg'

		/*
		 * Please add more gendered laughs
		 *
		// Male
		if(MALE)
			// Set laugh sound
			laugh_sound = 'sound/voice/human/laugh_male.ogg'

		// Non-binary
		if(PLURAL)
			// Set laugh sound
			laugh_sound = 'sound/voice/human/laugh_nonbinary.ogg'

		// Object
		if(NEUTER)
			// Set laugh sound
			laugh_sound = 'sound/voice/human/laugh_object.ogg'
		*/

		// Other
		else
			// Set laugh sound
			laugh_sound = pick('sound/voice/human/manlaugh1.ogg', 'sound/voice/human/manlaugh2.ogg')

	// Play laugh sound
	playsound(carbon_user, laugh_sound, 50, 1)

// Living variant
/datum/emote/sound/living
	// List of mob types that can run emote
	mob_type_allowed_typecache = list(/mob/living)

	// Time before using the emote again
	var/emote_cooldown = 1 SECONDS

// Check if audio emote can run
/datum/emote/sound/living/can_run_emote(mob/living/user, status_check)
	. = ..()

	// Check parent return
	if(!.)
		return FALSE

	// Check cooldown
	if(user?.nextsoundemote >= world.time)
		return FALSE

	// Allow use
	return TRUE

// Run audio emote
/datum/emote/sound/living/run_emote(mob/user, params)
	// Check if user is miming
	if(user?.mind?.miming)
		// Do not play sound
		sound = null

	// Define parent return
	. = ..()

 	// Set coodown
	user.nextsoundemote = world.time + emote_cooldown

/datum/emote/living/surrender/run_emote(mob/user, params, type_override, intentional)
	// Set message with pronouns
	message = "puts [user.p_their()] hands on [user.p_their()] head and falls to the ground, [user.p_they()] surrender[user.p_s()]!"

	// Return normally
	. = ..()

// SPLURT emotes
/datum/emote/living/tilt
	key = "tilt"
	key_third_person = "tilts"
	message = "tilts their head."
	emote_type = EMOTE_VISIBLE

/datum/emote/living/squint
	key = "squint"
	key_third_person = "squints"
	message = "squints their eyes." // i dumb
	emote_type = EMOTE_VISIBLE

/datum/emote/living/fart
	key = "fart"
	key_third_person = "farts"
	message = "farts out shitcode."

/datum/emote/living/fart/run_emote(mob/living/user, params, type_override, intentional)
	if(TIMER_COOLDOWN_CHECK(user, COOLDOWN_EMOTE_FART))
		to_chat(user, span_warning("You try your hardest, but no shart comes out."))
		return
	var/list/fart_emotes = list( //cope goonies
		"lets out a girly little 'toot' from [user.p_their()] butt.",
		"farts loudly!",
		"lets one rip!",
		"farts! It sounds wet and smells like rotten eggs.",
		"farts robustly!",
		"farted! It smells like something died.",
		"farts like a muppet!",
		"defiles the station's air supply.",
		"farts for a whole ten seconds.",
		"groans and moans, farting like the world depended on it.",
		"breaks wind!",
		"expels intestinal gas through [user.p_their()] anus.",
		"releases an audible discharge of intestinal gas.",
		"is a farting motherfucker!!!",
		"suffers from flatulence!",
		"releases flatus.",
		"releases methane.",
		"farts up a storm.",
		"farts. It smells like Soylent Surprise!",
		"farts. It smells like pizza!",
		"farts. It smells like George Melons' perfume!",
		"farts. It smells like the kitchen!",
		"farts. It smells like medbay in here now!",
		"farts. It smells like the bridge in here now!",
		"farts like a pubby!",
		"farts like a goone!",
		"sharts! That's just nasty.",
		"farts delicately.",
		"farts timidly.",
		"farts very, very quietly. The stench is OVERPOWERING.",
		"farts egregiously.",
		"farts voraciously.",
		"farts cantankerously.",
		"farts in [user.p_their()] own mouth. A shameful \the <b>[user]</b>.",
		"breaks wind noisily!",
		"releases gas with the power of the gods! The very station trembles!!",
		"<B><span style='color:red'>f</span><span style='color:blue'>a</span>r<span style='color:red'>t</span><span style='color:blue'>s</span>!</B>",
		"laughs! [user.p_their(TRUE)] breath smells like a fart.",
		"farts, and as such, blob cannot evoulate.",
		"farts. It might have been the Citizen Kane of farts."
	)
	var/new_message = pick(fart_emotes)
	//new_message = replacetext(new_message, "%OWNER", "\the [user]")
	message = new_message
	. = ..()
	if(.)
		playsound(user, pick(GLOB.brap_noises), 50, 1, -1)
		TIMER_COOLDOWN_START(user, COOLDOWN_EMOTE_FART, 3 SECONDS)

/datum/emote/sound/living/cackle
	key = "cackle"
	key_third_person = "cackles"
	message = "cackles hysterically!"
	message_mime = "cackles silently!"
	sound = 'modular_splurt/sound/voice/cackle_yeen.ogg'

/datum/emote/sound/living/speen
	key = "speen"
	key_third_person = "speens"
	message = "speeeeens!"
	restraint_check = TRUE
	mob_type_allowed_typecache = list(/mob/living, /mob/dead/observer)
	mob_type_ignore_stat_typecache = list(/mob/dead/observer)
	sound = 'modular_splurt/sound/voice/speen.ogg'

/datum/emote/sound/living/speen/run_emote(mob/user, params)
	. = ..()

	// Check parent return
	if(!.)
		return

	// Spin user
	user.spin(20, 1)

	// Check for cyborg
	// Check for buckled mobs
	if(iscyborg(user) && user.has_buckled_mobs())
		// Define cyborg user
		var/mob/living/silicon/robot/user_cyborg = user

		// Define riding datum
		var/datum/component/riding/riding_datum = user_cyborg.GetComponent(/datum/component/riding)

		// Check if riding datum exists
		if(riding_datum)
			// Iterate over buckled mobs
			for(var/mob/buckled_mob in user_cyborg.buckled_mobs)
				// Unbuckle iterated mob
				riding_datum.force_dismount(buckled_mob)

		// Riding datum does not exist
		else
			// Unbuckle all mobs
			user_cyborg.unbuckle_all_mobs()

/datum/emote/sound/living/chirp
	key = "chirp"
	key_third_person = "chirps"
	message = "chirps!"
	message_mime = "chirps silently!"
	sound = 'modular_splurt/sound/voice/chirp.ogg'

/datum/emote/sound/living/caw
	key = "caw"
	key_third_person = "caws"
	message = "caws!"
	message_mime = "caws silently!"
	sound = 'modular_splurt/sound/voice/caw.ogg'

/datum/emote/living/burp/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/list/burp_noises = list(
		'modular_splurt/sound/voice/burps/belch1.ogg','modular_splurt/sound/voice/burps/belch2.ogg','modular_splurt/sound/voice/burps/belch3.ogg','modular_splurt/sound/voice/burps/belch4.ogg',
		'modular_splurt/sound/voice/burps/belch5.ogg','modular_splurt/sound/voice/burps/belch6.ogg','modular_splurt/sound/voice/burps/belch7.ogg','modular_splurt/sound/voice/burps/belch8.ogg',
		'modular_splurt/sound/voice/burps/belch9.ogg','modular_splurt/sound/voice/burps/belch10.ogg','modular_splurt/sound/voice/burps/belch11.ogg','modular_splurt/sound/voice/burps/belch12.ogg',
		'modular_splurt/sound/voice/burps/belch13.ogg','modular_splurt/sound/voice/burps/belch14.ogg','modular_splurt/sound/voice/burps/belch15.ogg'
	)
	if(.)
		playsound(user, pick(burp_noises), 50, 1)

/datum/emote/sound/living/bleat
	key = "bleat"
	key_third_person = "bleats"
	message = "bleats loudly!"
	message_mime = "bleats silently!"
	sound = 'modular_splurt/sound/voice/bleat.ogg'

/datum/emote/living/carbon/moan/run_emote(mob/user, params, type_override, intentional) //I can't not port this shit, come on.
	if(user.nextsoundemote >= world.time || user.stat != CONSCIOUS)
		return
	var/sound
	var/miming = user.mind ? user.mind.miming : 0
	if(!user.is_muzzled() && !miming)
		user.nextsoundemote = world.time + 7
		sound = pick('modular_splurt/sound/voice/moan_m1.ogg', 'modular_splurt/sound/voice/moan_m2.ogg', 'modular_splurt/sound/voice/moan_m3.ogg')
		if(user.gender == FEMALE)
			sound = pick('modular_splurt/sound/voice/moan_f1.ogg', 'modular_splurt/sound/voice/moan_f2.ogg', 'modular_splurt/sound/voice/moan_f3.ogg', 'modular_splurt/sound/voice/moan_f4.ogg', 'modular_splurt/sound/voice/moan_f5.ogg', 'modular_splurt/sound/voice/moan_f6.ogg', 'modular_splurt/sound/voice/moan_f7.ogg')
		if(isalien(user))
			sound = 'sound/voice/hiss6.ogg'
		playsound(user.loc, sound, 50, 1, 4, 1.2)
		message = "moans!"
	else if(miming)
		message = "acts out a moan."
	else
		message = "makes a very loud noise."
	. = ..()

/datum/emote/sound/living/chitter2
	key = "chitter2"
	key_third_person = "chitters2"
	message = "chitters."
	message_mime = "chitters silently!"
	sound = 'modular_splurt/sound/voice/moth/mothchitter2.ogg'

/datum/emote/sound/living/monkeytwerk
	key = "twerk"
	key_third_person = "twerks"
	message = "shakes it harder than James Russle himself!"
	muzzle_ignore = TRUE
	sound = 'modular_splurt/sound/misc/monkey_twerk.ogg'

/datum/emote/sound/living/bruh
	key = "bruh"
	key_third_person = "bruhs"
	message = "thinks this is a bruh moment."
	sound = 'modular_splurt/sound/voice/bruh.ogg'

/datum/emote/sound/living/bababooey
	key = "bababooey"
	key_third_person = "bababooeys"
	message = "spews bababooey."
	message_mime = "spews something silently."
	sound = 'modular_splurt/sound/voice/bababooey/bababooey.ogg'

/datum/emote/sound/living/bababooey/run_emote(mob/user, params)
	// Check if user is muzzled
	if(user.is_muzzled())
		// Set muzzled sound
		sound = 'modular_splurt/sound/voice/bababooey/ffff.ogg'

	// User is not muzzled
	else
		// Set random emote sound
		sound = pick('modular_splurt/sound/voice/bababooey/bababooey.ogg', 'modular_splurt/sound/voice/bababooey/bababooey2.ogg')

	// Return normally
	. = ..()

/datum/emote/sound/living/babafooey
	key = "babafooey"
	key_third_person = "babafooeys"
	message = "spews babafooey."
	message_mime = "spews something silently."
	sound = 'modular_splurt/sound/voice/bababooey/babafooey.ogg'

/datum/emote/sound/living/fafafooey
	key = "fafafooey"
	key_third_person = "fafafooeys"
	message = "spews fafafooey."
	message_mime = "spews something silently."
	sound = 'modular_splurt/sound/voice/bababooey/fafafooey.ogg'

/datum/emote/sound/living/fafafooey/run_emote(mob/user, params)
	// Check if user is muzzled
	if(user.is_muzzled())
		// Set muzzled sound
		sound = 'modular_splurt/sound/voice/bababooey/ffff.ogg'

	// User is not muzzled
	else
		// Set random emote sound
		sound = pick('modular_splurt/sound/voice/bababooey/fafafooey.ogg', 'modular_splurt/sound/voice/bababooey/fafafooey2.ogg', 'modular_splurt/sound/voice/bababooey/fafafooey3.ogg')

	// Return normally
	. = ..()

/datum/emote/sound/living/fafafoggy
	key = "fafafoggy"
	key_third_person = "fafafoggys"
	message = "spews fafafoggy."
	message_mime = "spews something silently."
	sound = 'modular_splurt/sound/voice/bababooey/fafafoggy.ogg'

/datum/emote/sound/living/fafafoggy/run_emote(mob/user, params)
	// Check if user is muzzled
	if(user.is_muzzled())
		// Set muzzled sound
		sound = 'modular_splurt/sound/voice/bababooey/ffff.ogg'

	// User is not muzzled
	else
		// Set random emote sound
		sound = pick('modular_splurt/sound/voice/bababooey/fafafoggy.ogg', 'modular_splurt/sound/voice/bababooey/fafafoggy2.ogg')

	// Return normally
	. = ..()

/datum/emote/sound/living/hohohoy
	key = "hohohoy"
	key_third_person = "hohohoys"
	message = "spews hohohoy."
	message_mime = "spews something silently."
	sound = 'modular_splurt/sound/voice/bababooey/hohohoy.ogg'

/datum/emote/sound/living/ffff
	key = "ffff"
	key_third_person = "ffffs"
	message = "spews something softly."
	message_mime = "spews something silently."
	muzzle_ignore = TRUE
	sound = 'modular_splurt/sound/voice/bababooey/ffff.ogg'

/datum/emote/sound/living/fafafail
	key = "fafafail"
	key_third_person = "fafafails"
	message = "spews something unintelligible."
	message_mime = "spews something silent."
	sound = 'modular_splurt/sound/voice/bababooey/ffffhvh.ogg'

/datum/emote/sound/living/boowomp
	key = "boowomp"
	key_third_person = "boowomps"
	message = "produces a sad boowomp."
	message_mime = "produces a silent boowomp."
	sound = 'modular_splurt/sound/voice/boowomp.ogg'

/datum/emote/sound/living/swaos
	key = "swaos"
	key_third_person = "swaos"
	message = "mutters swaos."
	message_mime = "imitates swaos."
	sound = 'modular_splurt/sound/voice/swaos.ogg'

/datum/emote/sound/living/eyebrow2
	key = "eyebrow2"
	key_third_person = "eyebrows2"
	message = "<b>raises an eyebrow.</b>"
	sound = 'modular_splurt/sound/voice/vineboom.ogg'

/datum/emote/sound/living/eyebrow3
	key = "eyebrow3"
	key_third_person = "eyebrows3"
	message = "raises an eyebrow <i>quizzaciously</i>."
	sound = 'modular_splurt/sound/voice/moonmen.ogg'

/datum/emote/sound/living/blink2
	key = "blink2"
	key_third_person = "blinks2"
	message = "blinks."
	sound = 'modular_splurt/sound/voice/blink.ogg'

/datum/emote/sound/living/laugh2
	key = "laugh2"
	key_third_person = "laughs2"
	message = "laughs like a king."
	message_mime = "acts out laughing like a king."
	sound = 'modular_splurt/sound/voice/laugh_king.ogg'

/datum/emote/sound/living/laugh3
	key = "laugh3"
	key_third_person = "laughs3"
	message = "laughs silly."
	message_mime = "acts out laughing silly."
	sound = 'modular_splurt/sound/voice/lol.ogg'

/datum/emote/sound/living/laugh4
	key = "laugh4"
	key_third_person = "laughs4"
	message = "burst into laughter!"
	message_mime = "acts out bursting into laughter."
	sound = 'modular_splurt/sound/voice/laugh_muta.ogg'

/datum/emote/sound/living/laugh5
	key = "laugh5"
	key_third_person = "laughs5"
	message = "laughs in Scottish."
	message_mime = "acts out laughing in Scottish."
	sound = 'modular_splurt/sound/voice/laugh_deman.ogg'

/datum/emote/sound/living/laugh6
	key = "laugh6"
	key_third_person = "laughs6"
	message = "laughs like a kettle!"
	message_mime = "acts out laughing like a kettle."
	sound = 'modular_splurt/sound/voice/laugh6.ogg'

/datum/emote/sound/living/breakbad
	key = "breakbad"
	key_third_person = "breakbads"
	message = "stares intensively with determination."
	sound = 'modular_splurt/sound/voice/breakbad.ogg'

/datum/emote/sound/living/lawyerup
	key = "lawyerup"
	key_third_person = "lawyerups"
	message = "emits an aura of expertise."
	sound = 'modular_splurt/sound/voice/lawyerup.ogg'

/datum/emote/sound/living/goddamn
	key = "damn"
	key_third_person = "damns"
	message = "is in utter stupor."
	muzzle_ignore = TRUE
	sound = 'modular_splurt/sound/voice/god_damn.ogg'

/datum/emote/sound/living/spoonful
	key = "spoonful"
	key_third_person = "spoonfuls"
	message = "asks for a spoonful."
	message_mime = "pretends to ask for a spoonful."
	muzzle_ignore = TRUE
	sound = 'modular_splurt/sound/voice/spoonful.ogg'

/datum/emote/sound/living/ohhmygod
	key = "mygod"
	key_third_person = "omgs"
	message = "invokes the presence of Jesus Christ."
	message_mime = "invokes the presence of Jesus Christ through silent prayer."
	muzzle_ignore = TRUE
	sound = 'modular_splurt/sound/voice/OMG.ogg'

/datum/emote/sound/living/whatthehell
	key = "wth"
	key_third_person = "wths"
	message = "condemns the abysses of hell!"
	muzzle_ignore = TRUE
	sound = 'modular_splurt/sound/voice/WTH.ogg'

/datum/emote/sound/living/fusrodah
	key = "fusrodah"
	key_third_person = "furodahs"
	message = "yells, \"<b>FUS RO DAH!!!</b>\""
	message_mime = "acts out a dragon shout."
	sound = 'modular_splurt/sound/voice/fusrodah.ogg'

/datum/emote/sound/living/skibidi
	key = "skibidi"
	key_third_person = "skibidis"
	message = "yells, \"<b>Skibidi bop mm dada!</b>\""
	message_mime = "makes incoherent mouth motions."
	sound = 'modular_splurt/sound/voice/skibidi.ogg'

/datum/emote/sound/living/fbi
	key = "fbi"
	key_third_person = "fbis"
	message = "yells, \"<b>FBI OPEN UP!</b>\""
	message_mime = "acts out being the FBI."
	sound = 'modular_splurt/sound/voice/fbi.ogg'

/datum/emote/sound/living/illuminati
	key = "illuminati"
	key_third_person = "illuminatis"
	message = "exudes a mysterious aura!"
	sound = 'modular_splurt/sound/voice/illuminati.ogg'

/datum/emote/sound/living/bonerif
	key = "bonerif"
	key_third_person = "bonerifs"
	message = "riffs!"
	message_mime = "riffs silently!"
	sound = 'modular_splurt/sound/voice/bonerif.ogg'

/datum/emote/sound/living/cry2
	key = "cry2"
	key_third_person = "cries2"
	message = "cries like a king."
	message_mime = "acts out crying like a king."
	sound = 'modular_splurt/sound/voice/cry_king.ogg'

/datum/emote/sound/living/cry2/run_emote(mob/user, params)
	// Set random emote sound
	sound = pick('modular_splurt/sound/voice/cry_king.ogg', 'modular_splurt/sound/voice/cry_king2.ogg')

	// Return normally
	. = ..()

/datum/emote/sound/living/choir
	key = "choir"
	key_third_person = "choirs"
	message = "let out a choir!"
	message_mime = "acts out a choir."
	sound = 'modular_splurt/sound/voice/choir.ogg'
	emote_cooldown = 3 SECONDS

/datum/emote/sound/living/sicko
	key = "sicko"
	key_third_person = "sickos"
	message = "briefly goes sicko mode!"
	sound = 'modular_splurt/sound/voice/sicko.ogg'

/datum/emote/sound/living/chill
	key = "chill"
	key_third_person = "chills"
	message = "feels a chill running down their spine..."
	sound = 'modular_splurt/sound/voice/waterphone.ogg'

/datum/emote/sound/living/weh2
	key = "weh2"
	key_third_person = "wehs2"
	message = "let out a weh!"
	message_mime = "acts out a weh!"
	sound = 'modular_splurt/sound/voice/weh2.ogg'

/datum/emote/sound/living/weh3
	key = "weh3"
	key_third_person = "wehs3"
	message = "let out a weh!"
	message_mime = "acts out a weh!"
	sound = 'modular_splurt/sound/voice/weh3.ogg'

/datum/emote/sound/living/weh4
	key = "weh-s"
	key_third_person = "wehs4"
	message = "let out a surprised weh!"
	message_mime = "acts out a surprised weh!"
	sound = 'modular_splurt/sound/voice/weh_s.ogg'

/datum/emote/sound/living/waa
	key = "waa"
	key_third_person = "waas"
	message = "let out a waa!"
	message_mime = "acts out a waa!"
	sound = 'modular_splurt/sound/voice/waa.ogg'

/datum/emote/living/mlem
	key = "mlem"
	key_third_person = "mlems"
	message = "sticks their tongue for a moment. Mlem!"
	emote_type = EMOTE_VISIBLE

/datum/emote/sound/living/snore/snore2
	key = "snore2"
	key_third_person = "snores2"
	message = "lets out an <b>earthshaking</b> snore"
	message_mime = "lets out an <b>inaudible</b> snore!"
	sound = 'modular_splurt/sound/voice/aauugghh1.ogg'

/datum/emote/sound/living/snore/snore2/run_emote(mob/user, params)
	var/datum/dna/D = user.has_dna()
	var/say_mod = (D ? D.species.say_mod : "says")
	var/list/aaauughh = list(
		"lets out an <b>earthshaking</b> snore.",
		"lets out what sounds like a <b>painful</b> snore.",
		"[say_mod], <b>\"AAAAAAUUUUUUGGGHHHHH!!!\"</b>"
	)
	message = pick(aaauughh)

	// Set random emote sound
	sound = pick('modular_splurt/sound/voice/aauugghh1.ogg', 'modular_splurt/sound/voice/aauugghh2.ogg')

	// Return normally
	. = ..()

/datum/emote/living/pant
	key = "pant"
	key_third_person = "pants"
	message = "pants!"

/datum/emote/living/pant/run_emote(mob/user, params, type_override, intentional)
	var/list/pants = list(
		"pants!",
		"pants like a dog.",
		"lets out soft pants.",
		"pulls [user.p_their()] tongue out, panting."
	)
	message = pick(pants)
	. = ..()

/datum/emote/sound/living/yippee
	key = "yippee"
	key_third_person = "yippees"
	message = "lets out a yippee!"
	message_mime = "acts out a yippee!"
	sound = 'modular_splurt/sound/voice/yippee.ogg'

/datum/emote/sound/living/mewo
	key = "mewo"
	key_third_person = "mewos"
	message = "mewos!"
	message_mime = "mewos silently!"
	sound = 'modular_splurt/sound/voice/mewo.ogg'

/datum/emote/sound/living/ara_ara
	key = "ara"
	key_third_person = "aras"
	message = "coos with sultry surprise~..."
	message_mime = "exudes a sultry aura~"
	sound = 'modular_splurt/sound/voice/ara-ara.ogg'

/datum/emote/sound/living/ara_ara/alt
	key = "ara2"
	sound = 'modular_splurt/sound/voice/ara-ara2.ogg'

/datum/emote/sound/living/missouri
	key = "missouri"
	key_third_person = "missouris"
	message = "has relocated to Missouri."
	sound = 'modular_splurt/sound/voice/missouri.ogg'

/datum/emote/sound/living/missouri/run_emote(mob/user, params)
	// Set message pronouns
	message = "appears to believe [user.p_theyre()] in Missouri."

	// Return normally
	. = ..()

/datum/emote/sound/living/facemetacarpus
	key = "facehand" // Facepalm was taken
	key_third_person = "facepalms"
	// Message is generated from metacarpus_type below. You shouldn't see this!
	message = "creates an error in the code." // Hear a slapping sound
	muzzle_ignore = TRUE // Not a spoken emote
	restraint_check = TRUE // Uses your hands
	sound = 'modular_splurt/sound/effects/slap.ogg'
	// Defines appendage type for generated message
	var/metacarpus_type = "palm" // Default to hands

/datum/emote/sound/living/facemetacarpus/run_emote(mob/user, params)
	// Randomly pick a message using metacarpus_type for hand
	message = pick(list(
			"places [usr.p_their()] [metacarpus_type] across [usr.p_their()] face.",
			"lowers [usr.p_their()] face into [usr.p_their()] [metacarpus_type].",
			"face[metacarpus_type]s",
		))

	// Return normally
	. = ..()

/datum/emote/sound/living/facemetacarpus/paw
	key = "facepaw" // For furries
	key_third_person = "facepaws"
	metacarpus_type = "paw"

/datum/emote/sound/living/facemetacarpus/claw
	key = "faceclaw" // For scalies and avians
	key_third_person = "faceclaws"
	metacarpus_type = "claw"

/datum/emote/sound/living/facemetacarpus/hoof
	key = "facehoof" // For horse enthusiasts
	key_third_person = "facehoofs"
	metacarpus_type = "hoof"

/datum/emote/sound/living/poyo
	key = "poyo"
	key_third_person = "poyos"
	message = "%SAYS, \"Poyo!\""
	message_mime = "acts out an excited motion!"
	sound = 'modular_splurt/sound/voice/barks/poyo.ogg'

/datum/emote/sound/living/poyo/run_emote(mob/user, params)
	var/datum/dna/D = user.has_dna()
	var/say_mod = (D ? D.species.say_mod : "says")
	message = replacetextEx(message, "%SAYS", say_mod)

	// Return normally
	. = ..()
