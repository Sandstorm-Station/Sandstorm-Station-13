/datum/interaction/lewd/fuck
	command = "fuckvag"
	description = "Fuck their pussy."
	require_user_penis = REQUIRE_EXPOSED
	require_target_vagina = REQUIRE_EXPOSED
	write_log_user = "fucked"
	write_log_target = "was fucked by"
	interaction_sound = null
	max_distance = 1

/datum/interaction/lewd/fuck/display_interaction(mob/living/user, mob/living/partner)
	var/message

	var/u_His = user.p_their()

	if(user.is_fucking(partner, CUM_TARGET_VAGINA))
		message = "[pick(
			"pounds \the <b>[partner]</b>'s pussy.",
			"shoves [u_His] dick deep into \the <b>[partner]</b>'s pussy",
			"thrusts in and out of \the <b>[partner]</b>'s cunt.",
			"goes balls deep into \the <b>[partner]</b>'s pussy over and over again.")]"
	else
		message = "slides [u_His] cock into \the <b>[partner]</b>'s pussy."
		user.set_is_fucking(partner, CUM_TARGET_VAGINA, user.getorganslot(ORGAN_SLOT_PENIS))

	playlewdinteractionsound(get_turf(user), pick('modular_sand/sound/interactions/champ1.ogg',
						'modular_sand/sound/interactions/champ2.ogg'), 50, 1, -1)
	user.visible_message("<span class='lewd'><b>\The [user]</b> [message]</span>", ignored_mobs = user.get_unconsenting())
	user.handle_post_sex(NORMAL_LUST, CUM_TARGET_VAGINA, partner)
	partner.handle_post_sex(NORMAL_LUST, CUM_TARGET_PENIS, user)

/datum/interaction/lewd/fuck/anal
	command = "fuckass"
	description = "Fuck their ass."
	require_target_vagina = null
	require_target_anus = REQUIRE_EXPOSED

/datum/interaction/lewd/fuck/anal/display_interaction(mob/living/user, mob/living/partner)
	var/message

	var/u_His = user.p_their()
	var/t_His = partner.p_their()

	if(user.is_fucking(partner, CUM_TARGET_ANUS))
		message = "[pick(
			"thrusts in and out of \the <b>[partner]</b>'s ass.",
			"pounds \the <b>[partner]</b>'s ass.",
			"slams [u_His] hips up against \the <b>[partner]</b>'s ass hard.",
			"goes balls deep into \the <b>[partner]</b>'s ass over and over again.")]"
	else
		message = "[pick(
			"works [u_His] cock into \the <b>[partner]</b>'s asshole.",
			"grabs the base of [u_His] twitching cock and presses the tip into \the <b>[partner]</b>'s asshole.",
			"shoves [u_His] dick deep inside of \the <b>[partner]</b>'s ass, making [t_His] rear jiggle.")]"
		user.set_is_fucking(partner, CUM_TARGET_ANUS, user.getorganslot(ORGAN_SLOT_PENIS))

	playlewdinteractionsound(get_turf(user), pick('modular_sand/sound/interactions/bang1.ogg',
						'modular_sand/sound/interactions/bang2.ogg',
						'modular_sand/sound/interactions/bang3.ogg'), 70, 1, -1)
	user.visible_message("<span class='lewd'><b>\The [user]</b> [message]</span>", ignored_mobs = user.get_unconsenting())
	user.handle_post_sex(NORMAL_LUST, CUM_TARGET_ANUS, partner)
	partner.handle_post_sex(NORMAL_LUST, null, user)

/datum/interaction/lewd/breastfuck
	command = "breastfuck"
	description = "Fuck their breasts."
	interaction_sound = null
	require_user_penis = REQUIRE_EXPOSED
	require_target_breasts = REQUIRE_EXPOSED
	max_distance = 1

/datum/interaction/lewd/breastfuck/display_interaction(mob/living/user, mob/living/partner)
	var/message

	var/u_His = user.p_their()

	if(user.is_fucking(partner, CUM_TARGET_BREASTS))
		message = "[pick("fucks \the <b>[partner]</b>'s' breasts.",
			"grinds [u_His] cock between \the <b>[partner]</b>'s boobs.",
			"thrusts into \the <b>[partner]</b>'s tits.",
			"grabs \the <b>[partner]</b>'s breasts together and presses [u_His] dick between them.")]"
	else
		message = "pushes \the <b>[partner]</b>'s breasts together and presses [u_His] dick between them."
		user.set_is_fucking(partner, CUM_TARGET_BREASTS, user.getorganslot(ORGAN_SLOT_PENIS))


	playlewdinteractionsound(get_turf(user), pick('modular_sand/sound/interactions/bang1.ogg',
						'modular_sand/sound/interactions/bang2.ogg',
						'modular_sand/sound/interactions/bang3.ogg'), 70, 1, -1)
	user.visible_message("<span class='lewd'><b>\The [user]</b> [message]</span>", ignored_mobs = user.get_unconsenting())
	user.handle_post_sex(NORMAL_LUST, CUM_TARGET_BREASTS, partner)

/datum/interaction/lewd/footfuck
	command = "footfuck"
	description = "Rub your cock on their foot."
	interaction_sound = null
	require_target_num_feet = 1
	require_target_feet = REQUIRE_ANY
	require_user_penis = REQUIRE_EXPOSED
	max_distance = 1

/datum/interaction/lewd/footfuck/display_interaction(mob/living/user, mob/living/partner)
	var/message

	var/u_His = user.p_their()

	var/shoes = partner.get_shoes(TRUE)

	if(user.is_fucking(partner, CUM_TARGET_FEET))
		message = "[pick("fucks \the <b>[partner]</b>'s [shoes ? shoes : pick("foot", "sole")].",
			"rubs [u_His] dick on \the <b>[partner]</b>'s [shoes ? shoes : pick("foot", "sole")].",
			"grinds [u_His] cock on \the <b>[partner]</b>'s [shoes ? shoes : pick("foot", "sole")].")]"
	else
		message = "[pick("positions [u_His] cock on \the <b>[partner]</b>'s [shoes ? shoes : pick("foot", "sole")].",
			"positions [u_His] cock on \the <b>[partner]</b>'s [shoes ? shoes : pick("foot","sole")].",
			"starts grinding [u_His] cock against \the <b>[partner]</b>'s [shoes ? shoes : pick("foot", "sole")].")]"
		user.set_is_fucking(partner, CUM_TARGET_FEET, user.getorganslot(ORGAN_SLOT_PENIS))

	playlewdinteractionsound(get_turf(user), pick('modular_sand/sound/interactions/foot_dry1.ogg',
						'modular_sand/sound/interactions/foot_dry3.ogg',
						'modular_sand/sound/interactions/foot_wet1.ogg',
						'modular_sand/sound/interactions/foot_wet2.ogg'), 70, 1, -1)
	user.visible_message("<span class='lewd'><b>\The [user]</b> [message]</span>", ignored_mobs = user.get_unconsenting())
	user.handle_post_sex(NORMAL_LUST, CUM_TARGET_FEET, partner)

/datum/interaction/lewd/footfuck/double
	command = "footfuckdouble"
	description = "Rub your cock between their feet."
	require_target_num_feet = 2

/datum/interaction/lewd/footfuck/double/display_interaction(mob/living/user, mob/living/partner)
	var/message

	var/u_His = user.p_their()

	var/shoes = partner.get_shoes()

	if(user.is_fucking(partner, CUM_TARGET_FEET))
		message = "[pick("fucks \the <b>[partner]</b>'s [shoes ? shoes : pick("feet", "soles")].",
			"rubs [u_His] dick between \the <b>[partner]</b>'s [shoes ? shoes : pick("feet", "soles")].",
			"thrusts [u_His] cock between \the <b>[partner]</b>'s [shoes ? shoes : pick("feet", "soles")].")]"
	else
		message = "[pick("positions [u_His] cock between \the <b>[partner]</b>'s [shoes ? shoes : pick("feet", "soles")].",
			"starts grinding [u_His] cock against \the <b>[partner]</b>'s [shoes ? shoes : pick("feet", "soles")].",
			"starts grinding [u_His] cock between \the <b>[partner]</b>'s [shoes ? shoes : pick("feet", "soles")].")]"
		user.set_is_fucking(partner, CUM_TARGET_FEET, user.getorganslot(ORGAN_SLOT_PENIS))

	playlewdinteractionsound(get_turf(user), pick('modular_sand/sound/interactions/foot_dry1.ogg',
						'modular_sand/sound/interactions/foot_dry3.ogg',
						'modular_sand/sound/interactions/foot_wet1.ogg',
						'modular_sand/sound/interactions/foot_wet2.ogg'), 70, 1, -1)
	user.visible_message("<span class='lewd'><b>\The [user]</b> [message]</span>", ignored_mobs = user.get_unconsenting())
	user.handle_post_sex(NORMAL_LUST, CUM_TARGET_FEET, partner)

/datum/interaction/lewd/footfuck/vag
	command = "footfuckvag"
	description = "Rub your vagina on their foot."
	interaction_sound = null
	require_target_num_feet = 1
	require_target_feet = REQUIRE_ANY
	require_user_vagina = REQUIRE_EXPOSED
	require_user_penis = REQUIRE_NONE
	max_distance = 1

/datum/interaction/lewd/footfuck/vag/display_interaction(mob/living/user, mob/living/partner)
	var/message

	var/u_His = user.p_their()

	var/shoes = partner.get_shoes(TRUE)

	if(user.is_fucking(partner, CUM_TARGET_FEET))
		message = "[pick("grinds [u_His] pussy against \the <b>[partner]</b>'s [shoes ? shoes : pick("foot", "sole")].",
			"rubs [u_His] clit on \the <b>[partner]</b>'s [shoes ? shoes : pick("foot", "sole")].",
			"ruts on \the <b>[partner]</b>'s [shoes ? shoes : pick("foot", "sole")].")]"
	else
		message = "[pick("positions [u_His] vagina on \the <b>[partner]</b>'s [shoes ? shoes : pick("foot", "sole")].",
			"positions [u_His] clit on \the <b>[partner]</b>'s [shoes ? shoes : pick("foot","sole")].",
			"starts grinding [u_His] pussy against \the <b>[partner]</b>'s [shoes ? shoes : pick("foot", "sole")].")]"
		user.set_is_fucking(partner, CUM_TARGET_FEET, user.getorganslot(ORGAN_SLOT_VAGINA))

	playlewdinteractionsound(get_turf(user), pick('modular_sand/sound/interactions/foot_dry1.ogg',
						'modular_sand/sound/interactions/foot_dry3.ogg',
						'modular_sand/sound/interactions/foot_wet1.ogg',
						'modular_sand/sound/interactions/foot_wet2.ogg'), 70, 1, -1)
	user.visible_message("<span class='lewd'><b>\The [user]</b> [message]</span>", ignored_mobs = user.get_unconsenting())
	user.handle_post_sex(NORMAL_LUST, CUM_TARGET_FEET, partner)
