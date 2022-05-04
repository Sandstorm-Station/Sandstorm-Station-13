// I'm copy/pasting this functionality so I can override shit without it being a major pain
/atom/attack_ghost(mob/dead/observer/user)
	if(SEND_SIGNAL(src, COMSIG_ATOM_ATTACK_GHOST, user) & COMPONENT_NO_ATTACK_HAND)
		return TRUE
	if(user.client)
		if(IsAdminGhost(user))
			attack_ai(user)
		else if(user.client.prefs.inquisitive_ghost)
			user.examinate(src)
		else if(CONFIG_GET(flag/ghost_interaction) && istype(src, /mob/living))	// This is what's new
			var/mob/living/H = src
			H.do_ass_slap(user)

// I'm putting this here because honestly i'm too lazy to find the thing i need
/mob/living/proc/do_ass_slap(mob/dead/observer/user)
	var/mob/living/carbon/H = src
	if(src.client?.prefs.cit_toggles & NO_ASS_SLAP)
		to_chat(user, "Your ethereal hand phases through \The [src].")
		return
	playsound(src.loc, 'sound/weapons/slap.ogg', 50, 1, -1)
	if(HAS_TRAIT(src, TRAIT_STEEL_ASS))
		to_chat(src, "<span class='danger'>You feel something bounce off your steely asscheeks, but nothing is there...</span>")
		to_chat(user, "<span class='danger'>You slap \The [src]'s ass, but your ethereal hand bounces right off!</span>")
		playsound(src.loc, 'sound/weapons/tap.ogg', 50, 1, -1)
		return
	src:adjust_arousal(20, "masochism", maso=TRUE)	// Honestly fuck you, just runtime
	if(ishuman(src) && HAS_TRAIT(src, TRAIT_MASO) && src.has_dna() && prob(10))
		src:mob_climax(forced_climax=TRUE, cause="masochism")
	if(!HAS_TRAIT(src, TRAIT_PERMABONER))
		H.dna.species.stop_wagging_tail(src)
	playsound(src.loc, 'sound/weapons/slap.ogg', 50, 1, -1)
	src.visible_message(\
		"<span class='danger'>You hear someone slap \The [src]'s ass, but nobody's there...</span>",\
		"<span class='notice'>Somebody slaps your ass, but nobody is around...</span>",\
		"You hear a slap.", target=user, target_message="<span class='notice'>You manage to will your ethereal hand to slap \The [src]'s ass.</span>")
	return
