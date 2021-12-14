/* TODO: Finish these tomorrow
/datum/interaction/lewd/do_breastsmother
	command = "do_breastsmother"
	description = "Smother them in your breasts"
	require_user_breasts = REQUIRE_EXPOSED
	max_distance = 1
	interaction_sound = null
	write_log_target = "got breast smothered by"
	write_log_user = null

/datum/interaction/lewd/lick_sweat
	command = "lick_sweat"
	description = "Lick their sweat"
	require_user_mouth = TRUE
	max_distance = 1
	interaction_sound = null
	write_log_target = "got their sweat licked by"
	write_log_user = "licked sweat"

/datum/interaction/lewd/smother_armpit
	command = "smother_armpit"
	description = "Press your armpit against their face"
	require_target_mouth = TRUE
	max_distance = 1
	interaction_sound = null
	write_log_target = "Got armpit smothered by"
	wtrite_log_user = "Smothered someone in their armpit"

/datum/interaction/lewd/lick_armpit
	command = "lick_armpit"
	description = "Lick their armpit"
	require_user_mouth = TRUE
	max_distance = 1
	interaction_sound = null
	write_log_target = "Got their armpit licked by"
	write_log_user = "ate some armpit"
*/

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
	require_user_penis = REQUIRE_EXPOSED
	max_distance = 1
	interaction_sound = null
	write_log_target = "got fartfucked by"
	write_log_user = null

/datum/interaction/lewd/unholy/do_fartfuck/display_interaction(mob/living/user, mob/living/target)
	user.do_fartfuck(target)

/datum/interaction/lewd/unholy/do_faceshit
	command = "do_faceshit"
	description = "Shit on their face"
	require_user_anus = TRUE
	max_distance = 1
	interaction_sound = null
	write_log_target = "got shat in the face by"
	write_log_user = null

/datum/interaction/lewd/unholy/do_crotchshit
	command = "do_crotchshit"
	description = "Shit on their crotch"
	require_user_anus = REQUIRE_EXPOSED
	max_distance = 1
	interaction_sound = null
	write_log_target = "got shat on the croch by"
	write_log_user = null

/datum/interaction/lewd/unholy/do_shitfuck
	command = "do_shitfuck"
	description = "Fuck their ass + shit"
	require_target_anus = REQUIRE_EXPOSED
	require_user_penis = REQUIRE_EXPOSED
	max_distance = 1
	interaction_sound = null
	write_log_target = "got shitfucked by"
