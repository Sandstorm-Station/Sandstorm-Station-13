//Dildo changes.
/obj/item/dildo
	var/hole = CUM_TARGET_VAGINA

/obj/item/dildo/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	var/message = ""
	if(istype(M, /mob/living/carbon/human) && user.zone_selected == BODY_ZONE_PRECISE_GROIN && M.is_bottomless())
		if(M.client && M.client.prefs)
			if(M.client.prefs.toggles & VERB_CONSENT)
				if(hole == CUM_TARGET_VAGINA && M.has_vagina())
					message = (user == M) ? pick("fucks their own pussy with \the [src]","shoves \the [src] into their pussy", "jams \the [src] into their pussy") : pick("fucks [M] right in the pussy with \the [src]", "jams \the [src] right into [M]'s pussy")
				else if(hole == CUM_TARGET_ANUS && M.has_anus())
					message = (user == M) ? pick("fucks their own ass with \the [src]","shoves \the [src] into their ass", "jams \the [src] into their ass") : pick("fucks [M]'s asshole with \the [src]", "jams \the [src] into [M]'s ass")
	else if(istype(M, /mob/living/carbon/human) && user.zone_selected == BODY_ZONE_PRECISE_MOUTH && M.mouth_is_free())
		if(M.client && M.client.prefs)
			if(M.client.prefs.toggles & VERB_CONSENT)
				if(M.has_mouth())
					message = (user == M) ? pick("fucks their own mouth with \the [src]", "shoves \the [src] into their mouth", "jams \the [src] into their mouth") : pick("fucks [M]'s mouth with \the [src]", "jams \the [src] into [M]'s mouth")
	if(message)
		user.visible_message("<font color=purple>[user] [message].</font>")
		M.handle_post_sex(5, null, user)
		playsound(loc, pick('modular_sand/sound/interactions/bang4.ogg',
							'modular_sand/sound/interactions/bang5.ogg',
							'modular_sand/sound/interactions/bang6.ogg'), 70, 1, -1)
	else if(user.a_intent == INTENT_HARM)
		return ..()

/obj/item/dildo/attack_self(mob/living/carbon/human/user as mob)
	if(hole == CUM_TARGET_VAGINA)
		hole = CUM_TARGET_ANUS
	else
		hole = CUM_TARGET_VAGINA
	to_chat(user, "<span class='notice'>Now targetting \the [hole].</span>")

//begin redds code
/obj/item/dildo/cyborg
	name = "F.I.S.T.R. Machine"
	desc = "Fully Integrated Sexual Tension Relief Machine"
//end redds code

/obj/item/pneumatic_cannon/dildo
	color = "#FFC0CB"
	name = "pneumatic cannon"
	desc = "A pneumatic cannon with a picture of a bus printed on the side that resembles an A-shape."
	automatic = TRUE
	selfcharge = TRUE
	gasPerThrow = 0
	checktank = FALSE
	fire_mode = PCANNON_FIFO
	throw_amount = 1
	maxWeightClass = 60
	var/static/list/dildo_typecache = typecacheof(/obj/item/dildo)
	charge_type = /obj/item/dildo

/obj/item/pneumatic_cannon/dildo/Initialize()
	. = ..()
	allowed_typecache = dildo_typecache
