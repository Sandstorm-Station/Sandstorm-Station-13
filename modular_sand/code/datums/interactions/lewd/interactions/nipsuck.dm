/datum/interaction/lewd/nipsuck
	command = "nipsuck"
	description = "Suck their nipples."
	require_target_topless = TRUE
	require_user_mouth = TRUE
	write_log_user = "sucked nipples"
	write_log_target = "had their nipples sucked by"
	interaction_sound = null
	max_distance = 1

/datum/interaction/lewd/nipsuck/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if((user.a_intent == INTENT_HELP) || (user.a_intent == INTENT_DISARM))
		user.visible_message(
				pick("<span class='lewd'>\The <b>[user]</b> gently sucks on \the <b>[target]</b>'s [pick("nipple", "nipples")].</span>",
					"<span class='lewd'>\The <b>[user]</b> gently nibs \the <b>[target]</b>'s [pick("nipple", "nipples")].</span>",
					"<span class='lewd'>\The <b>[user]</b> licks \the <b>[target]</b>'s [pick("nipple", "nipples")].</span>"))
		if(target.has_breasts(REQUIRE_EXPOSED))
			var/modifier = 1
			var/obj/item/organ/genital/breasts/B = target.getorganslot(ORGAN_SLOT_BREASTS)
			switch(B.size)
				if("c", "d", "e")
					modifier = 2
				if("f", "g", "h")
					modifier = 3
				else
					if(B.size in B.breast_values)
						modifier = clamp(B.breast_values[B.size] - 5, 0, INFINITY)
					else
						modifier = 1
			if(B.fluid_id)
				user.reagents.add_reagent(B.fluid_id, rand(1,2 * modifier))

	if(user.a_intent == INTENT_HARM)
		user.visible_message(
				pick("<span class='lewd'>\The <b>[user]</b> bites \the <b>[target]</b>'s [pick("nipple", "nipples")].</span>",
					"<span class='lewd'>\The <b>[user]</b> aggressively sucks \the <b>[target]</b>'s [pick("nipple", "nipples")].</span>"))
		if(target.has_breasts(REQUIRE_EXPOSED))
			var/modifier = 1
			var/obj/item/organ/genital/breasts/B = target.getorganslot(ORGAN_SLOT_BREASTS)
			switch(B.size)
				if("c", "d", "e")
					modifier = 2
				if("f", "g", "h")
					modifier = 3
				else
					if(B.size in B.breast_values)
						modifier = clamp(B.breast_values[B.size] - 5, 0, INFINITY)
					else
						modifier = 1
			if(B.fluid_id)
				user.reagents.add_reagent(B.fluid_id, rand(1,3 * modifier)) //aggressive sucking leads to high rewards

	if(user.a_intent == INTENT_GRAB)
		user.visible_message(
				pick("<span class='lewd'>\The <b>[user]</b> sucks \the <b>[target]</b>'s [pick("nipple", "nipples")] intently.</span>",
					"<span class='lewd'>\The <b>[user]</b> feasts \the <b>[target]</b>'s [pick("nipple", "nipples")].</span>",
					"<span class='lewd'>\The <b>[user]</b> glomps \the <b>[target]</b>'s [pick("nipple", "nipples")].</span>"))
		if(target.has_breasts(REQUIRE_EXPOSED))
			var/modifier = 1
			var/obj/item/organ/genital/breasts/B = target.getorganslot(ORGAN_SLOT_BREASTS)
			switch(B.size)
				if("c", "d", "e")
					modifier = 2
				if("f", "g", "h")
					modifier = 3
				else
					if(B.size in B.breast_values)
						modifier = clamp(B.breast_values[B.size] - 5, 0, INFINITY)
					else
						modifier = 1
			if(B.fluid_id)
				user.reagents.add_reagent(B.fluid_id, rand(1,3 * modifier)) //aggressive sucking leads to high rewards

	if(prob(5 + target.get_lust()))
		if(target.a_intent == INTENT_HELP)
			if(!target.has_breasts())
				user.visible_message(
					pick("<span class='lewd'>\The <b>[target]</b> shivers in arousal.</span>",
						"<span class='lewd'>\The <b>[target]</b> moans quietly.</span>",
						"<span class='lewd'>\The <b>[target]</b> breathes out a soft moan.</span>",
						"<span class='lewd'>\The <b>[target]</b> gasps.</span>",
						"<span class='lewd'>\The <b>[target]</b> shudders softly.</span>",
						"<span class='lewd'>\The <b>[target]</b> trembles as their chest gets molested.</span>"))
			else
				user.visible_message(
					pick("<span class='lewd'>\The <b>[target]</b> shivers in arousal.</span>",
						"<span class='lewd'>\The <b>[target]</b> moans quietly.</span>",
						"<span class='lewd'>\The <b>[target]</b> breathes out a soft moan.</span>",
						"<span class='lewd'>\The <b>[target]</b> gasps.</span>",
						"<span class='lewd'>\The <b>[target]</b> shudders softly.</span>",
						"<span class='lewd'>\The <b>[target]</b> trembles as their breasts get molested.</span>",
						"<span class='lewd'>\The <b>[target]</b> quivers in arousal as \the <b>[user]</b> delights themselves on their milk.</span>"))
			if(target.get_lust() < 5)
				target.set_lust(5)
		if(target.a_intent == INTENT_DISARM)
			if (target.restrained())
				if(!target.has_breasts())
					user.visible_message(
						pick("<span class='lewd'>\The <b>[target]</b> twists playfully against the restraints.</span>",
							"<span class='lewd'>\The <b>[target]</b> squirms away from \the <b>[user]</b>'s mouth.</span>",
							"<span class='lewd'>\The <b>[target]</b> slides back from \the <b>[user]</b>'s mouth.</span>",
							"<span class='lewd'>\The <b>[target]</b> thrusts their bare chest forward into \the <b>[user]</b>'s mouth.</span>"))
				else
					user.visible_message(
						pick("<span class='lewd'>\The <b>[target]</b> twists playfully against the restraints.</span>",
							"<span class='lewd'>\The <b>[target]</b> squirms away from \the <b>[user]</b>'s mouth.</span>",
							"<span class='lewd'>\The <b>[target]</b> slides back from \the <b>[user]</b>'s mouth.</span>",
							"<span class='lewd'>\The <b>[target]</b> thrust their bare breasts forward into \the <b>[user]</b>'s mouth.</span>"))
			else
				if(!target.has_breasts())
					user.visible_message(
						pick("<span class='lewd'>\The <b>[target]</b> playfully shoos away \the <b>[user]</b>'s head.</span>",
							"<span class='lewd'>\The <b>[target]</b> squirms away from \the <b>[user]</b>'s mouth.</span>",
							"<span class='lewd'>\The <b>[target]</b> holds \the <b>[user]</b>'s head against their chest.</span>",
							"<span class='lewd'>\The <b>[target]</b> teasingly caresses \the <b>[user]</b>'s neck.</span>"))
				else
					user.visible_message(
						pick("<span class='lewd'>\The <b>[target]</b> playfully shoos away \the <b>[user]</b>'s head.</span>",
							"<span class='lewd'>\The <b>[target]</b> squirms away from \the <b>[user]</b>'s mouth.</span>",
							"<span class='lewd'>\The <b>[target]</b> holds \the <b>[user]</b>'s head against their breast.</span>",
							"<span class='lewd'>\The <b>[target]</b> teasingly caresses \the <b>[user]</b>'s neck.</span>",
							"<span class='lewd'>\The <b>[target]</b> rubs their breasts against \the <b>[user]</b>'s head.</span>"))
			if(target.get_lust() < 10)
				target.add_lust(1)
	if(target.a_intent == INTENT_GRAB)
		user.visible_message(
				pick("<span class='lewd'>\The <b>[target]</b> grips \the <b>[user]</b>'s head tight.</span>",
				 "<span class='lewd'>\The <b>[target]</b> digs nails into \the <b>[user]</b>'s scalp.</span>",
				 "<span class='lewd'>\The <b>[target]</b> grabs and shoves \the <b>[user]</b>'s head away.</span>"))
	if(target.a_intent == INTENT_HARM)
		user.adjustBruteLoss(1)
		user.visible_message(
				pick("<span class='lewd'>\The <b>[target]</b> slaps \the <b>[user]</b> away.</span>",
				 "<span class='lewd'>\The <b>[target]</b> scratches <b>[user]</b>'s face.</span>",
				 "<span class='lewd'>\The <b>[target]</b> fiercely struggles against <b>[user]</b>.</span>",
				 "<span class='lewd'>\The <b>[target]</b> claws <b>[user]</b>'s face, drawing blood.</span>",
				 "<span class='lewd'>\The <b>[target]</b> elbows <b>[user]</b>'s mouth away.</span>"))
	target.dir = get_dir(target, user)
	user.dir = get_dir(user, target)
	playlewdinteractionsound(get_turf(user), pick('modular_sand/sound/interactions/oral1.ogg',
						'modular_sand/sound/interactions/oral2.ogg'), 70, 1, -1)
	return
