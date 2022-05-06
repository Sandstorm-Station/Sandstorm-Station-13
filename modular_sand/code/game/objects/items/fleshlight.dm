/**
 * # Hyperstation 13 fleshlight
 *
 * Humbley request this doesnt get ported to other code bases, we strive to make things unique on our server and we dont have a lot of coders
 * but if you absolutely must. please give us some credit~ <3
 * made by quotefox and heavily modified by SandPoot
*/
/obj/item/fleshlight
	name 				= "fleshlight"
	desc				= "A sex toy disguised as a flashlight, used to stimulate someones penis, complete with colour changing sleeve."
	icon 				= 'modular_sand/icons/obj/fleshlight.dmi'
	icon_state 			= "fleshlight_base"
	item_state 			= "fleshlight"
	w_class				= WEIGHT_CLASS_SMALL
	var/style			= CUM_TARGET_VAGINA
	var/sleevecolor 	= "#ffcbd4" //pink
	custom_price 		= 8
	var/mutable_appearance/sleeve
	var/inuse 			= 0

/obj/item/fleshlight/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-Click \the [name] to customize it.</span>"

/obj/item/fleshlight/update_appearance(updates)
	. = ..()
	cut_overlays()
	sleeve = mutable_appearance(icon, style) // Inherits icon for if an admin wants to var edit it, thank me later.
	sleeve.color = sleevecolor
	add_overlay(sleeve)

/obj/item/fleshlight/AltClick(mob/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	customize(user)
	return TRUE

/obj/item/fleshlight/proc/customize(mob/living/user)
	if(src && !user.incapacitated() && in_range(user,src))
		var/new_style = tgui_input_list(usr, "Choose style", "Customize Fleshlight", list(CUM_TARGET_VAGINA, CUM_TARGET_ANUS))
		if(new_style)
			style = new_style
	update_appearance()
	if(src && !user.incapacitated() && in_range(user,src))
		var/new_color = input(user, "Choose color.", "Customize Fleshlight", sleevecolor) as color|null
		if(new_color)
			sleevecolor = new_color
	update_appearance()
	return TRUE

/obj/item/fleshlight/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	var/possessive_verb = user.p_their()
	var/message = ""
	var/lust_amt = 0
	if(ishuman(M) && (M?.client?.prefs?.toggles & VERB_CONSENT))
		switch(user.zone_selected)
			if(BODY_ZONE_PRECISE_GROIN)
				if(M.has_penis(REQUIRE_EXPOSED))
					message = (user == M) ? "pumps [src] on [possessive_verb] penis" : "pumps \the [src] on [M]'s penis"
					lust_amt = NORMAL_LUST
	if(message)
		user.visible_message("<span class='lewd'>[user] [message].</span>")
		M.handle_post_sex(lust_amt, null, user)
		playlewdinteractionsound(loc, pick('modular_sand/sound/interactions/bang4.ogg',
							'modular_sand/sound/interactions/bang5.ogg',
							'modular_sand/sound/interactions/bang6.ogg'), 70, 1, -1)
	else if(user.a_intent == INTENT_HARM)
		return ..()

/**
 * # Hyperstation 13 portal fleshlight
 * kinky!
*/

/obj/item/portallight
	name 				= "portal fleshlight"
	desc 				= "A silver love(TM) fleshlight, used for self-stimulation, with bluespace tech that allows lovers to hump at a distance. Also functions as a dildo, if your partner has the right parts."
	icon 				= 'modular_sand/icons/obj/fleshlight.dmi'
	icon_state 			= "unpaired"
	item_state 			= "fleshlight"
	w_class 			= WEIGHT_CLASS_SMALL
	var/partnercolor 	= "#ffcbd4"
	var/partnerbase 	= "normal"
	var/partnerorgan 	= "portal_vag"
	custom_price 		= 20
	var/mutable_appearance/sleeve
	var/mutable_appearance/organ
	var/obj/item/clothing/underwear/briefs/panties/portalpanties/portalunderwear
	var/targetting      = CUM_TARGET_PENIS
	var/useable 		= FALSE

/obj/item/portallight/attack_self(mob/user)
	. = ..()
	switch(targetting)
		if(CUM_TARGET_PENIS)
			targetting = CUM_TARGET_VAGINA
		if(CUM_TARGET_VAGINA)
			targetting = CUM_TARGET_ANUS
		if(CUM_TARGET_ANUS)
			targetting = CUM_TARGET_PENIS
	to_chat(user, "<span class='notice'>Now when using on groin, it will now be it will now be targetting \an [targetting].</span>")

/obj/item/portallight/examine(mob/user)
	. = ..()
	if(!portalunderwear)
		. += "<span class='notice'>The device is unpaired, to pair, swipe against a pair of portal panties.</span>"
	else
		. += "<span class='notice'>The device is paired, and awaiting input. </span>"

/obj/item/portallight/update_appearance(updates)
	. = ..()
	updatesleeve()

/obj/item/portallight/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	var/message = ""
	var/user_lust_amt = NONE
	var/target_lust_amt = NONE
	var/obj/item/organ/genital/P
	var/target
	if(ishuman(M) && (M?.client?.prefs?.toggles & VERB_CONSENT) && useable) // I promise all those checks are worth it!
		switch(user.zone_selected)
			if(BODY_ZONE_PRECISE_GROIN)
				switch(targetting)
					if(CUM_TARGET_PENIS)
						if(M.has_penis(REQUIRE_EXPOSED))
							switch(portalunderwear.targetting)
								if(CUM_TARGET_PENIS)
									message = (user == M) ? "frots with \the [src]" : "forces \the [M] to frot with \the [src]"
									P = M.getorganslot(ORGAN_SLOT_PENIS)
									target = CUM_TARGET_PENIS
									user_lust_amt = NORMAL_LUST
									target_lust_amt = NORMAL_LUST
								if(CUM_TARGET_VAGINA)
									message = (user == M) ? "fucks \the [src]'s pussy" : "forces \the [M] to fuck \the [src]'s pussy"
									P = M.getorganslot(ORGAN_SLOT_PENIS)
									target = CUM_TARGET_PENIS
									user_lust_amt = NORMAL_LUST
									target_lust_amt = NORMAL_LUST
								if(CUM_TARGET_ANUS)
									message = (user == M) ? "fucks \the [src] anally" : "forces \the [M] to fuck \the [src] anally"
									P = M.getorganslot(ORGAN_SLOT_PENIS)
									target = CUM_TARGET_PENIS
									user_lust_amt = NORMAL_LUST
									target_lust_amt = NORMAL_LUST
								if(CUM_TARGET_MOUTH)
									message = (user == M) ? "fucks \the [src]'s mouth" : "forces \the [M] to fuck \the [src]'s mouth"
									P = M.getorganslot(ORGAN_SLOT_PENIS)
									target = CUM_TARGET_PENIS
									user_lust_amt = NORMAL_LUST
									target_lust_amt = LOW_LUST
						else
							to_chat(user, "<span class='warning'>The penis is covered or there is none!</span>")
					if(CUM_TARGET_VAGINA)
						if(M.has_vagina(REQUIRE_EXPOSED))
							switch(portalunderwear.targetting)
								if(CUM_TARGET_PENIS)
									message = (user == M) ? "fucks \the [src]" : "fucks \the [M] with \the [src]"
									P = M.getorganslot(ORGAN_SLOT_VAGINA)
									target = CUM_TARGET_VAGINA
									user_lust_amt = NORMAL_LUST
									target_lust_amt = NORMAL_LUST
								if(CUM_TARGET_VAGINA)
									message = (user == M) ? "grinds [M.p_their()] pussy into \the [src]'s pussy" : "rubs \the [src]'s pussy against \the [M]'s pussy"
									P = M.getorganslot(ORGAN_SLOT_VAGINA)
									target = CUM_TARGET_VAGINA
									user_lust_amt = NORMAL_LUST
									target_lust_amt = NORMAL_LUST
								if(CUM_TARGET_ANUS)
									message = (user == M) ? "grinds [M.p_their()] pussy into \the [src]'s anus" : "rubs \the [src]'s anus against \the [M]'s pussy"
									P = M.getorganslot(ORGAN_SLOT_VAGINA)
									target = CUM_TARGET_VAGINA
									user_lust_amt = LOW_LUST
									target_lust_amt = LOW_LUST
								if(CUM_TARGET_MOUTH)
									message = (user == M) ? "grinds [M.p_their()] pussy into \the [src]'s mouth" : "rubs \the [src]'s mouth against \the [M]'s pussy"
									P = M.getorganslot(ORGAN_SLOT_VAGINA)
									target = CUM_TARGET_VAGINA
									user_lust_amt = NORMAL_LUST
									target_lust_amt = LOW_LUST
					if(CUM_TARGET_ANUS)
						if(M.has_anus(REQUIRE_EXPOSED))
							switch(portalunderwear.targetting)
								if(CUM_TARGET_PENIS)
									message = (user == M) ? "fucks \the [src] anally" : "fucks \the [M] anally with \the [src]"
									target = CUM_TARGET_ANUS
									user_lust_amt = NORMAL_LUST
									target_lust_amt = NORMAL_LUST
								if(CUM_TARGET_VAGINA)
									message = (user == M) ? "grinds [M.p_their()] anus into \the [src]'s pussy" : "rubs \the [src]'s pussy against \the [M]'s anus"
									target = CUM_TARGET_ANUS
									user_lust_amt = LOW_LUST
									target_lust_amt = LOW_LUST
								if(CUM_TARGET_ANUS)
									message = (user == M) ? "grinds [M.p_their()] anus into \the [src]'s anus" : "rubs \the [src]'s anus against \the [M]'s anus"
									target = CUM_TARGET_ANUS
									user_lust_amt = LOW_LUST
									target_lust_amt = LOW_LUST
								if(CUM_TARGET_MOUTH)
									message = (user == M) ? "grinds [M.p_their()] anus into \the [src]'s mouth" : "rubs \the [src]'s mouth against \the [M]'s anus"
									target = CUM_TARGET_ANUS
									user_lust_amt = NORMAL_LUST
									target_lust_amt = LOW_LUST
						else
							to_chat(user, "<span class='warning'>The anus is covered or there is none!</span>")
			if(BODY_ZONE_PRECISE_MOUTH)
				if(M.has_mouth() && !M.is_mouth_covered())
					switch(portalunderwear.targetting)
						if(CUM_TARGET_PENIS)
							message = (user == M) ? "sucks on \the [src]" : "forces \the [M] to suck on \the [src]"
							target = CUM_TARGET_MOUTH
							user_lust_amt = LOW_LUST
							target_lust_amt = NORMAL_LUST
						if(CUM_TARGET_VAGINA)
							message = (user == M) ? "laps at \the [src]'s pussy" : "rubs \the [src]'s pussy against \the [M]'s mouth"
							target = CUM_TARGET_MOUTH
							user_lust_amt = LOW_LUST
							target_lust_amt = NORMAL_LUST
						if(CUM_TARGET_ANUS)
							message = (user == M) ? "laps at \the [src]'s anus" : "rubs \the [src]'s anus against \the [M]'s mouth"
							target = CUM_TARGET_MOUTH
							user_lust_amt = LOW_LUST
							target_lust_amt = NORMAL_LUST
						if(CUM_TARGET_MOUTH)
							message = (user == M) ? "kisses \the [src]'s mouth" : "forces \the [src]'s lips and \the [M]'s lips together"
							target = CUM_TARGET_MOUTH
							user_lust_amt = LOW_LUST
							target_lust_amt = LOW_LUST
				else
					to_chat(user, "<span class='warning'>The mouth is covered or there is none!</span>")
			if(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM)
				if(M.has_hand(REQUIRE_ANY))
					var/can_interact = FALSE
					if(user.zone_selected == BODY_ZONE_R_ARM)
						for(var/obj/item/bodypart/r_arm/R in M.bodyparts)
							can_interact = TRUE
					else
						for(var/obj/item/bodypart/l_arm/L in M.bodyparts)
							can_interact = TRUE
					if(can_interact)
						switch(portalunderwear.targetting)
							if(CUM_TARGET_PENIS)
								message = (user == M) ? "jerks off \the [src]" : "forces \the [M] to jerk off \the [src]"
								target = CUM_TARGET_HAND
								user_lust_amt = NONE
								target_lust_amt = NORMAL_LUST
							if(CUM_TARGET_VAGINA)
								message = (user == M) ? "fingers \the [src]'s pussy" : "fingers \the [src]'s pussy with \the [M]'s fingers"
								target = CUM_TARGET_HAND
								user_lust_amt = NONE
								target_lust_amt = NORMAL_LUST
							if(CUM_TARGET_ANUS)
								message = (user == M) ? "fingers \the [src]'s anus" : "fingers \the [src]'s anus with \the [M]'s fingers"
								target = CUM_TARGET_HAND
								user_lust_amt = NONE
								target_lust_amt = NORMAL_LUST
							if(CUM_TARGET_MOUTH)
								message = (user == M) ? "prods at the inside of \the [src]'s mouth" : "prods the inside of \the [src]'s mouth with \the [M]'s fingers"
								target = CUM_TARGET_HAND
								user_lust_amt = NONE
								target_lust_amt = LOW_LUST
					else
						to_chat(user, "<span class='warning'>There is no [user.zone_selected == BODY_ZONE_R_ARM ? "right" : "left"] hands!</span>")
			if(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
				if(M.has_feet(REQUIRE_ANY))
					var/can_interact = FALSE
					if(user.zone_selected == BODY_ZONE_R_LEG)
						for(var/obj/item/bodypart/r_leg/R in M.bodyparts)
							can_interact = TRUE
					else
						for(var/obj/item/bodypart/l_leg/L in M.bodyparts)
							can_interact = TRUE
					if(can_interact)
						switch(portalunderwear.targetting)
							if(CUM_TARGET_PENIS)
								message = (user == M) ? "rubs \the [src] with [M.p_their()] foot" : "rubs \the [src] against \the [M]'s foot"
								target = CUM_TARGET_FEET
								user_lust_amt = NONE
								target_lust_amt = NORMAL_LUST
							if(CUM_TARGET_VAGINA)
								message = (user == M) ? "rubs \the [src]'s pussy with [M.p_their()] toes" : "rubs \the [src]'s pussy with \the [M]'s toes"
								target = CUM_TARGET_FEET
								user_lust_amt = NONE
								target_lust_amt = NORMAL_LUST
							if(CUM_TARGET_ANUS)
								message = (user == M) ? "rubs \the [src]'s anus with [M.p_their()] toes" : "rubs \the [src]'s anus with \the [M]'s toes"
								target = CUM_TARGET_FEET
								user_lust_amt = NONE
								target_lust_amt = NORMAL_LUST
							if(CUM_TARGET_MOUTH)
								message = (user == M) ? "sticks [M.p_their()] toes inside of \the [src]'s mouth" : "sticks \the [M]'s toes inside of \the [src]'s mouth"
								target = CUM_TARGET_FEET
								user_lust_amt = NONE
								target_lust_amt = LOW_LUST
					else
						to_chat(user, "<span class='warning'>There is no [user.zone_selected == BODY_ZONE_R_LEG ? "right" : "left"] feet!</span>")
	if(!useable)
		to_chat(user, "<span class='notice'>It seems the device has failed or your partner is not wearing their device.</span>")
	if(message)
		var/mob/living/carbon/human/portal_target = ishuman(portalunderwear.loc) && (portalunderwear.current_equipped_slot & (ITEM_SLOT_UNDERWEAR | ITEM_SLOT_MASK)) ? portalunderwear.loc : null
		if(portal_target && (portal_target?.client?.prefs.toggles & VERB_CONSENT || !portal_target.ckey))
			user.visible_message("<span class='lewd'>[user] [message].</span>")
			if(M.handle_post_sex(user_lust_amt, target, portal_target))
				switch(target)
					if(CUM_TARGET_PENIS)
						var/obj/item/organ/genital/penis/temp = P
						switch(portalunderwear.targetting)
							if(CUM_TARGET_PENIS)
								to_chat(portal_target, "<span class='userlove'>You feel a [temp.shape] penis push harder against yours and cum!</span>")
							if(CUM_TARGET_VAGINA, CUM_TARGET_ANUS, CUM_TARGET_MOUTH)
								to_chat(portal_target, "<span class='userlove'>You feel a [temp.shape] penis of [temp.length] inches go deep into your [portalunderwear.targetting] and cum!</span>")
					if(CUM_TARGET_VAGINA)
						switch(portalunderwear.targetting)
							if(CUM_TARGET_PENIS, CUM_TARGET_VAGINA, CUM_TARGET_ANUS, CUM_TARGET_MOUTH)
								to_chat(portal_target, "<span class='userlove'>You feel a [P.shape] vagina squirting on your [portalunderwear.targetting]!</span>")
					if(CUM_TARGET_ANUS)
						switch(portalunderwear.targetting)
							if(CUM_TARGET_PENIS)
								to_chat(portal_target, "<span class='userlove'>You feel an anus constricting around your penis!</span>")
							if(CUM_TARGET_VAGINA, CUM_TARGET_ANUS)
								to_chat(portal_target, "<span class='userlove'>You feel an anus constricting around nothing while rubbing against it!</span>")
							if(CUM_TARGET_MOUTH)
								to_chat(portal_target, "<span class='userlove'>You feel an anus constricting around nothing while licking it!</span>")
					if(CUM_TARGET_MOUTH)
						switch(portalunderwear.targetting)
							if(CUM_TARGET_PENIS, CUM_TARGET_VAGINA, CUM_TARGET_ANUS)
								to_chat(portal_target, "<span class='userlove'>You feel a tongue lapping more fervently at your [portalunderwear.targetting], until it suddenly tenses up and freezes, then finally relaxes. The person on the other side must have finished.</span>")
							if(CUM_TARGET_MOUTH)
								to_chat(portal_target, "<span class='userlove'>You feel a pair of lips press even deeper to yours, then finally relaxes. The person on the other side must have finished.</span>")
					// /* I don't think cumming while using these is even possible. If anyone feels otherwise, feel free to write some */
					// if(CUM_TARGET_HAND)
					// if(CUM_TARGET_FEET)
			switch(user.zone_selected)
				if(BODY_ZONE_PRECISE_GROIN)
					playlewdinteractionsound(loc, pick('modular_sand/sound/interactions/bang4.ogg',
														'modular_sand/sound/interactions/bang5.ogg',
														'modular_sand/sound/interactions/bang6.ogg'), 70, 1, -1)
				if(BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
					playlewdinteractionsound(loc, 'modular_sand/sound/interactions/champ_fingering.ogg', 50, 1, -1)

			var/targeted = portalunderwear.targetting
			if(M != user)
				message = replacetext(message, "\the [M]", "someone")
			message = replacetext(message, "[M.p_their()]", "its")
			message = replacetext(message, "\the [src] anally", "you anally")
			message = replacetext(message, "\the [src]'s [targeted]", "your [targeted]")
			message = replacetext(message, "\the [src]'s pussy", "your pussy")
			message = replacetext(message, "\the [src]", "your [targeted]")
			if(target == CUM_TARGET_PENIS)
				var/obj/item/organ/genital/penis/temp = P
				message = "[message], it is a [temp.shape] penis of [temp.length] inches"
			to_chat(portal_target, "<span class='lewd'>You feel something on your panties, it [message].</span>")
			if(portal_target.handle_post_sex(target_lust_amt, portalunderwear.targetting, M))
				switch(portalunderwear.targetting)
					if(CUM_TARGET_VAGINA)
						switch(target)
							if(CUM_TARGET_PENIS, CUM_TARGET_VAGINA, CUM_TARGET_ANUS, CUM_TARGET_MOUTH)
								to_chat(M, "<span class='userlove'>You feel \the [portalunderwear.targetting] squirt on your [target]!</span>")
							if(CUM_TARGET_HAND)
								to_chat(M, "<span class='userlove'>You feel \the [portalunderwear.targetting] squirt on your fingers!</span>")
							if(CUM_TARGET_FEET)
								to_chat(M, "<span class='userlove'>You feel \the [portalunderwear.targetting] squirt on your foot!</span>")
					if(CUM_TARGET_ANUS)
						switch(target)
							if(CUM_TARGET_PENIS)
								to_chat(M, "<span class='userlove'>You feel the anus tighten around your [target]!</span>")
							if(CUM_TARGET_VAGINA, CUM_TARGET_ANUS)
								to_chat(M, "<span class='userlove'>You feel the anus tighten around nothing while rubbing it with your [target]!</span>")
							if(CUM_TARGET_MOUTH)
								to_chat(M, "<span class='userlove'>You feel the anus tighten around nothing while licking at it!</span>")
							if(CUM_TARGET_HAND)
								to_chat(M, "<span class='userlove'>You feel the anus tighten around your fingers!</span>")
							if(CUM_TARGET_FEET)
								to_chat(M, "<span class='userlove'>You feel the anus tighten around your toes!</span>")
					if(CUM_TARGET_PENIS)
						switch(target)
							if(CUM_TARGET_PENIS)
								to_chat(M, "<span class='userlove'>You feel \the [portalunderwear.targetting] twitch a few times before cumming on your [target]!</span>")
							if(CUM_TARGET_VAGINA, CUM_TARGET_ANUS, CUM_TARGET_MOUTH, CUM_TARGET_HAND)
								to_chat(M, "<span class='userlove'>You feel \the [portalunderwear.targetting] twitch a few times before cumming in your [target]!</span>")
							if(CUM_TARGET_FEET)
								to_chat(M, "<span class='userlove'>You feel \the [portalunderwear.targetting] twitch a few times before cumming on your foot!</span>")
					if(CUM_TARGET_MOUTH)
						switch(target)
							if(CUM_TARGET_PENIS)
								to_chat(M, "<span class='userlove'>You feel \the [src]'s lips quiver while wrapped around your [target]!</span>")
							if(CUM_TARGET_VAGINA, CUM_TARGET_ANUS)
								to_chat(M, "<span class='userlove'>You feel \the [src]'s tongue quiver while licking your [target]!</span>")
							if(CUM_TARGET_MOUTH)
								to_chat(M, "<span class='userlove'>You feel \the [src]'s lips quiver while pressed against yours!</span>")
							if(CUM_TARGET_HAND)
								to_chat(M, "<span class='userlove'>You feel \the [src]'s lips quiver while wrapped around your prodding fingers!</span>")
							if(CUM_TARGET_FEET)
								to_chat(M, "<span class='userlove'>You feel \the [src]'s lips quiver while wrapped around your toes!</span>")
			portal_target.do_jitter_animation() //make your partner shake too!
		else
			user.visible_message("<span class='warning'>\The [src] beeps and does not let [M] through.</span>")
	else if(user.a_intent == INTENT_HARM)
		return ..()

/obj/item/portallight/proc/updatesleeve()
	//get their looks and vagina colour!
	cut_overlays()//remove current overlays

	var/mob/living/carbon/human/H = null
	if(ishuman(portalunderwear.loc) && portalunderwear) // Wouldn't this make more sense the other way around?
		H = portalunderwear.loc
	else
		useable = FALSE
		return
	var/obj/item/organ/genital/G
	if(portalunderwear.targetting == CUM_TARGET_VAGINA)
		G = H.getorganslot(ORGAN_SLOT_VAGINA)
		if(!G)
			useable = FALSE
			return
	else if(portalunderwear.targetting == CUM_TARGET_PENIS)
		G = H.getorganslot(ORGAN_SLOT_PENIS)
		if(!G)
			useable = FALSE
			return
	if(H) //if the portal panties are on someone.
		if(!(portalunderwear.current_equipped_slot & (ITEM_SLOT_UNDERWEAR | ITEM_SLOT_MASK)))
			useable = FALSE
			return

		sleeve = mutable_appearance('modular_sand/icons/obj/fleshlight.dmi', "portal_sleeve_normal")
		if(islizard(H)) // lizard nerd
			sleeve = mutable_appearance('modular_sand/icons/obj/fleshlight.dmi', "portal_sleeve_lizard")

		if(isslimeperson(H)) // slime nerd
			sleeve = mutable_appearance('modular_sand/icons/obj/fleshlight.dmi', "portal_sleeve_slime")

		if(H.dna.species.name == "Avian") // bird nerd (obviously bad hyper code)
			sleeve = mutable_appearance('modular_sand/icons/obj/fleshlight.dmi', "portal_sleeve_avian")

		sleeve.color = "#" + H.dna.features["mcolor"]
		add_overlay(sleeve)

		switch(portalunderwear.targetting)
			if(CUM_TARGET_VAGINA)
				name = "portal fleshlight"
				organ = mutable_appearance('modular_sand/icons/obj/fleshlight.dmi', "portal_vag")
				organ.color = G.color
			if(CUM_TARGET_ANUS)
				name = "portal fleshlight"
				organ = mutable_appearance('modular_sand/icons/obj/fleshlight.dmi', "portal_anus")
				organ.color = "#[H.dna.features["mcolor"]]"
			if(CUM_TARGET_PENIS)
				name = "portal dildo"
				organ = mutable_appearance('modular_sand/icons/obj/fleshlight.dmi', "portal_vag") // TODO: I'm not great at sprite work, gonna leave this up to someone else to deal with
				organ.color = G.color
			if(CUM_TARGET_MOUTH)
				name = "portal fleshlight"
				organ = mutable_appearance('modular_sand/icons/obj/fleshlight.dmi', "portal_vag") // TODO: also not dealing with this one
				organ.color = "#[H.lip_style == "lipstick" ? H.lip_color : H.dna.features["mcolor"]]"

		useable = TRUE
		add_overlay(organ)
	else
		useable = FALSE

/obj/item/portallight/Destroy()
	if(portalunderwear)
		portalunderwear.portallight = null
		if(isliving(portalunderwear.loc))
			portalunderwear.audible_message("[icon2html(portalunderwear, hearers(portalunderwear))] *beep* *beep* *beep*")
			playsound(portalunderwear, 'sound/machines/triple_beep.ogg', ASSEMBLY_BEEP_VOLUME, TRUE)
			to_chat(portalunderwear.loc, "<span class='notice'>The panties beep as the link to the [src] is lost.</span>")
	. = ..()

/**
 * # Hyperstation 13 portal underwear
 * Wear it, cannot be worn if not pointing to the bits you have.
*/
/obj/item/clothing/underwear/briefs/panties/portalpanties
	name = "portal panties"
	desc = "A silver love(TM) pair of portal underwear, with bluespace tech allows lovers to hump at a distance. Needs to be paired with a portal fleshlight before use. Can also be used as a mask."
	icon = 'modular_sand/icons/obj/fleshlight.dmi'
	icon_state = "portalpanties"
	item_state = "fleshlight"
	w_class = WEIGHT_CLASS_SMALL
	var/obj/item/portallight/portallight
	var/targetting = CUM_TARGET_VAGINA
	equip_delay_self = 2 SECONDS
	equip_delay_other = 5 SECONDS

/obj/item/clothing/underwear/briefs/panties/portalpanties/attack_self(mob/user)
	. = ..()
	// targetting = targetting == CUM_TARGET_ANUS ? CUM_TARGET_VAGINA : CUM_TARGET_ANUS
	switch(targetting)
		if(CUM_TARGET_VAGINA)
			targetting = CUM_TARGET_ANUS
			slot_flags = ITEM_SLOT_UNDERWEAR
			name = "portal panties"
		if(CUM_TARGET_ANUS)
			targetting = CUM_TARGET_PENIS
			slot_flags = ITEM_SLOT_UNDERWEAR
			name = "portal panties"
		if(CUM_TARGET_PENIS)
			targetting = CUM_TARGET_MOUTH
			slot_flags = ITEM_SLOT_MASK
			name = "portal mask"
		if(CUM_TARGET_MOUTH)
			targetting = CUM_TARGET_VAGINA
			slot_flags = ITEM_SLOT_UNDERWEAR
			name = "portal panties"
	to_chat(user, "<span class='notice'>Now when worn the portal will now be facing \an [targetting].</span>")

/obj/item/clothing/underwear/briefs/panties/portalpanties/examine(mob/user)
	. = ..()
	if(!portallight)
		. += "<span class='notice'>The device is unpaired, to pair, swipe the fleshlight against this pair of portal panties(TM). </span>"
	else
		. += "<span class='notice'>The device is paired, and awaiting attachment. </span>"

/obj/item/clothing/underwear/briefs/panties/portalpanties/attackby(obj/item/I, mob/living/user) //pairing
	if(istype(I, /obj/item/portallight))
		var/obj/item/portallight/P = I
		if(!P.portalunderwear) //make sure it aint linked to someone else
			portallight = P //pair the fleshlight
			P.portalunderwear = src //pair the panties on the fleshlight.
			P.icon_state = "paired" //we are paired!
			playsound(src, 'sound/machines/ping.ogg', 50, FALSE)
			to_chat(user, "<span class='notice'>[P] has been linked up successfully.</span>")
			if(src.current_equipped_slot & (ITEM_SLOT_UNDERWEAR | ITEM_SLOT_MASK))
				update_portal()
				RegisterSignal(user, COMSIG_PARENT_QDELETING, .proc/drop_out)
		else
			to_chat(user, "<span class='notice'>[P] has already been linked to another pair of underwear.</span>")
	else
		..() //just allows people to hit it with other objects, if they so wished.

/obj/item/clothing/underwear/briefs/panties/portalpanties/mob_can_equip(M, equipper, slot, disable_warning, bypass_equip_delay_self)
	if(!..())
		return FALSE
	if(ishuman(M))
		var/mob/living/carbon/human/human = M
		switch(targetting)
			if(CUM_TARGET_VAGINA)
				if(!human.has_vagina(REQUIRE_EXPOSED))
					to_chat(human, "<span class='warning'>The vagina is covered or there is none!</span>")
					return FALSE
			if(CUM_TARGET_ANUS)
				if(!human.has_anus(REQUIRE_EXPOSED))
					to_chat(human, "<span class='warning'>The anus is covered or there is none!</span>")
					return FALSE
			if(CUM_TARGET_PENIS)
				if(!human.has_penis(REQUIRE_EXPOSED))
					to_chat(human, "<span class='warning'>The penis is covered or there is none!</span>")
					return FALSE
			if(CUM_TARGET_MOUTH)
				if(!human.has_mouth() || human.is_mouth_covered())
					to_chat(human, "<span class='warning'>The mouth is covered or there is none!</span>")
					return FALSE
	return TRUE

/obj/item/clothing/underwear/briefs/panties/portalpanties/equipped(mob/user, slot)
	. = ..()
	switch(slot)
		if(ITEM_SLOT_UNDERWEAR, ITEM_SLOT_MASK)
			if(!portallight)
				audible_message("[icon2html(src, hearers(src))] *beep* *beep* *beep*")
				playsound(src, 'sound/machines/triple_beep.ogg', ASSEMBLY_BEEP_VOLUME, TRUE)
				to_chat(user, "<span class='notice'>The panties are not linked to a portal fleshlight.</span>")
			else
				update_portal()
				RegisterSignal(user, COMSIG_PARENT_QDELETING, .proc/drop_out)
		else
			update_portal()
			UnregisterSignal(user, COMSIG_PARENT_QDELETING)

/obj/item/clothing/underwear/briefs/panties/portalpanties/dropped(mob/user)
	UnregisterSignal(user, COMSIG_PARENT_QDELETING)
	. = ..()
	update_portal()

/obj/item/clothing/underwear/briefs/panties/portalpanties/Destroy()
	if(portallight)
		var/obj/item/portallight/temp = portallight
		moveToNullspace() // loc cannot be human so let's destroy ourselves out of anything
		portallight.portalunderwear = null
		temp.updatesleeve()
	. = ..()

/obj/item/clothing/underwear/briefs/panties/portalpanties/proc/drop_out()
	var/mob/living/carbon/human/deleted
	if(ishuman(loc))
		deleted = loc
	forceMove(get_turf(loc))
	dropped(deleted) // Act like we've been dropped
	plane = initial(plane)
	layer = initial(layer)
	update_portal()

/obj/item/clothing/underwear/briefs/panties/portalpanties/proc/update_portal()
	if(portallight)
		var/obj/item/portallight/P = portallight
		P.updatesleeve()

/obj/item/storage/box/portallight
	name =  "Portal Fleshlight and Underwear"
	icon = 'modular_sand/icons/obj/fleshlight.dmi'
	desc = "A small silver box with Silver Love Co embossed."
	icon_state = "box"
	custom_price = 15

// portal fleshlight box
/obj/item/storage/box/portallight/PopulateContents()
	new /obj/item/portallight/(src)
	new /obj/item/clothing/underwear/briefs/panties/portalpanties/(src)
	new /obj/item/paper/fluff/portallight(src)

/obj/item/paper/fluff/portallight
	name = "Portal Fleshlight Instructions"
	info = "Thank you for purchasing the Silver Love Portal Fleshlight!<BR>\
	To use, simply register your new portal fleshlight with the provided underwear to link them together. The ask your lover to wear the underwear.<BR>\
	Have fun lovers,<BR>\
	<BR>\
	Wilhelmina Steiner."
