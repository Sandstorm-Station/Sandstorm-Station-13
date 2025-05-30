/datum/interaction/lewd/do_breastfeed
	description = "Breastfeed them"
	required_from_user_exposed = INTERACTION_REQUIRE_BREASTS
	required_from_target = INTERACTION_REQUIRE_MOUTH
	write_log_user = "breastfed"
	write_log_target = "was breastfed by"
	interaction_sound = null
	additional_details = list(
		list(
			"info" = "Will feed the target with your breasts' reagents if any",
			"icon" = "cow",
			"color" = "white"
		)
	)

/datum/interaction/lewd/do_breastfeed/display_interaction(mob/living/user, mob/living/target)
	var/message
	var/u_His = user.p_their()
	var/u_He = user.p_they()
	var/t_His = target.p_their()
	var/obj/item/organ/genital/breasts/milkers = user.getorganslot(ORGAN_SLOT_BREASTS)
	var/milktype = milkers?.fluid_id
	var/modifier
	var/list/lines

	if(!milkers || !milktype)
		return

	var/datum/reagent/milk = find_reagent_object_from_type(milktype)

	var/milktext = milk.name

	lines = list(
		"pushes [u_His] breasts against \the <b>[target]</b>'s mouth, squirting [u_His] warm [lowertext(milktext)] into [t_His] mouth",
		"fills \the <b>[target]</b>'s mouth with warm, sweet [lowertext(milktext)] as [u_He] squeezes [u_His] boobs, panting",
		"lets a large stream of [u_His] own abundant [lowertext(milktext)] coat the back of \the <b>[target]</b>'s throat"
	)

	message = span_lewd("\The <b>[user]</b> [pick(lines)]")
	user.visible_message(message, ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), pick('modular_sand/sound/interactions/oral1.ogg',
						'modular_sand/sound/interactions/oral2.ogg'), 70, 1, -1)

	switch(milkers.size)
		if("c", "d", "e")
			modifier = 2
		if("f", "g", "h")
			modifier = 3
		else
			if(milkers.size in milkers.breast_values)
				modifier = clamp(milkers.breast_values[milkers.size] - 5, 0, INFINITY)
			else
				modifier = 1
	target.reagents.add_reagent(milktype, rand(1,3 * modifier))

/datum/interaction/lewd/titgrope
	description = "Grope their breasts."
	required_from_user = INTERACTION_REQUIRE_HANDS
	required_from_target_exposed = INTERACTION_REQUIRE_BREASTS
	required_from_target_unexposed = INTERACTION_REQUIRE_BREASTS
	write_log_user = "groped"
	write_log_target = "was groped by"
	interaction_sound = null

	additional_details = list(
		INTERACTION_FILLS_CONTAINERS
	)

/datum/interaction/lewd/titgrope/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/reagent_containers/liquid_container

	var/obj/item/cached_item = user.get_active_held_item()
	if(istype(cached_item, /obj/item/reagent_containers))
		liquid_container = cached_item
	else
		cached_item = user.pulling
		if(istype(cached_item, /obj/item/reagent_containers))
			liquid_container = cached_item

	if(liquid_container)
		var/obj/item/organ/genital/breasts/milkers = target.getorganslot(ORGAN_SLOT_BREASTS)
		var/milktype = milkers?.fluid_id

		if(milkers && milktype)
			var/modifier
			switch(milkers.size)
				if("c", "d", "e")
					modifier = 2
				if("f", "g", "h")
					modifier = 3
				else
					if(milkers.size in milkers.breast_values)
						modifier = clamp(milkers.breast_values[milkers.size] - 5, 0, INFINITY)
					else
						modifier = 1
			liquid_container.reagents.add_reagent(milktype, rand(1,3 * modifier))

			user.visible_message(span_lewd("<b>\The [user]</b> milks <b>[target]</b>'s breasts into \the [liquid_container]."), ignored_mobs = user.get_unconsenting())
			playlewdinteractionsound(get_turf(user), 'modular_sand/sound/interactions/squelch1.ogg', 50, 1, -1)
	else
		if(user.a_intent == INTENT_HARM)
			user.visible_message(
					pick(span_lewd("\The <b>[user]</b> aggressively gropes \the <b>[target]</b>'s breast."),
						span_lewd("\The <b>[user]</b> grabs \the <b>[target]</b>'s breasts."),
						span_lewd("\The <b>[user]</b> tightly squeezes \the <b>[target]</b>'s breasts."),
						span_lewd("\The <b>[user]</b> slaps at \the <b>[target]</b>'s breasts."),
						span_lewd("\The <b>[user]</b> gropes \the <b>[target]</b>'s breasts roughly.")))
		else
			user.visible_message(
					pick(span_lewd("\The <b>[user]</b> gently gropes \the <b>[target]</b>'s breast."),
						span_lewd("\The <b>[user]</b> softly squeezes \the <b>[target]</b>'s breasts."),
						span_lewd("\The <b>[user]</b> grips \the <b>[target]</b>'s breasts."),
						span_lewd("\The <b>[user]</b> runs a few fingers over \the <b>[target]</b>'s breast."),
						span_lewd("\The <b>[user]</b> delicately teases \the <b>[target]</b>'s nipple."),
						span_lewd("\The <b>[user]</b> traces a touch across \the <b>[target]</b>'s breast.")))
		if(prob(5 + target.get_lust()))
			if(target.a_intent == INTENT_HELP)
				user.visible_message(
					pick(span_lewd("\The <b>[target]</b> shivers in arousal."),
						span_lewd("\The <b>[target]</b> moans quietly."),
						span_lewd("\The <b>[target]</b> breathes out a soft moan."),
						span_lewd("\The <b>[target]</b> gasps."),
						span_lewd("\The <b>[target]</b> shudders softly."),
						span_lewd("\The <b>[target]</b> trembles as hands run across bare skin.")))
				if(target.get_lust() < 5)
					target.set_lust(5)
			if(target.a_intent == INTENT_DISARM)
				if (target.restrained())
					user.visible_message(
						pick(span_lewd("\The <b>[target]</b> twists playfully against the restraints."),
							span_lewd("\The <b>[target]</b> squirms away from <b>[user]</b>'s hand."),
							span_lewd("\The <b>[target]</b> slides back from <b>[user]</b>'s roaming hand."),
							span_lewd("\The <b>[target]</b> thrusts bare breasts forward into <b>[user]</b>'s hands.")))
				else
					user.visible_message(
						pick(span_lewd("\The <b>[target]</b> playfully bats at <b>[user]</b>'s hand."),
							span_lewd("\The <b>[target]</b> squirms away from <b>[user]</b>'s hand."),
							span_lewd("\The <b>[target]</b> guides <b>[user]</b>'s hand across bare breasts."),
							span_lewd("\The <b>[target]</b> teasingly laces a few fingers over <b>[user]</b>'s knuckles.")))
				if(target.get_lust() < 10)
					target.add_lust(1)
		if(target.a_intent == INTENT_GRAB)
			user.visible_message(
					pick(span_lewd("\The <b>[target]</b> grips <b>[user]</b>'s wrist tight."),
					span_lewd("\The <b>[target]</b> digs nails into <b>[user]</b>'s arm."),
					span_lewd("\The <b>[target]</b> grabs <b>[user]</b>'s wrist for a second.")))
		if(target.a_intent == INTENT_HARM)
			user.adjustBruteLoss(1)
			user.visible_message(
					pick(span_lewd("\The <b>[target]</b> pushes <b>[user]</b> roughly away."),
					span_lewd("\The <b>[target]</b> digs nails angrily into <b>[user]</b>'s arm."),
					span_lewd("\The <b>[target]</b> fiercely struggles against <b>[user]</b>."),
					span_lewd("\The <b>[target]</b> claws <b>[user]</b>'s forearm, drawing blood."),
					span_lewd("\The <b>[target]</b> slaps <b>[user]</b>'s hand away.")))

