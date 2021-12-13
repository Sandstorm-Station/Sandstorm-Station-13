////////////////////////////////////////////////////////////////////////////////////////////////////////
///////// 									U N H O L Y										   /////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/interaction/lewd/unholy
	unholy = TRUE

/datum/interaction/lewd/unholy/do_facefart
	command = "do_facefart"
	description = "Fart on their face"
	require_user_anus = REQUIRE_EXPOSED
	max_distance = 1
	interaction_sound = null
	write_log_target = "got facefarted by"
	write_log_user = null

/datum/interaction/lewd/unholy/do_facefart/display_interaction(mob/living/user, mob/living/target)
	user.do_facefart(target)

/datum/interaction/lewd/unholy/do_crotchfart
	command = "do_crotchfart"
	description = "Fart on their crotch"
	require_user_anus = REQUIRE_EXPOSED
	max_distance = 1
	interaction_sound = null
	write_log_target = "got crotchfarted by"
	write_log_user = null

/datum/interaction/lewd/unholy/do_crotchfart/display_interaction(mob/living/user, mob/living/target)
	user.do_crotchfart(target)

/datum/interaction/lewd/unholy/do_fartfuck
	command = "do_fartfuck"
	description = "Fuck their ass + fart"
	require_target_anus = REQUIRE_EXPOSED
	require_user_penis = REQUIRE_UNEXPOSED
	max_distance = 1
	interaction_sound = null
	write_log_target = "got fartfucked by"
	write_log_user = null

/datum/interaction/lewd/unholy/do_fartfuck/display_interaction(mob/living/user, mob/living/target)
	user.do_fartfuck(target)
