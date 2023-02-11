/**
	# Interactions code by HONKERTRON feat TestUnit
- Contains a lot ammount of ERP and MEHANOYEBLYA
- CREDIT TO ATMTA STATION FOR MOST OF THIS CODE, I ONLY MADE IT WORK IN /vg/ - Matt
- Rewritten 30/08/16 by Zuhayr, sry if I removed anything important.
- I removed ERP and replaced it with handholding. Nothing of worth was lost. - Vic
- Fuck you, Vic. ERP is back. - TT
- >using var/ on everything, also TRUE
- "TGUIzes" the panel because yes - SandPoot
- Makes all the code good because yes as well - SandPoot
**/

/mob/proc/list_interaction_attributes()
	return list()

/mob/living/list_interaction_attributes()
	. = ..()
	if(has_hands())
		. += "...have hands."
	if(has_mouth())
		. += "...have a mouth, which is [mouth_is_free() ? "uncovered" : "covered"]."

/// The base of all interactions
/datum/interaction
	var/description = "Interact with them."
	var/simple_message
	var/simple_style = "notice"
	var/write_log_user
	var/write_log_target

	var/interaction_sound

	var/max_distance = 1
	var/require_ooc_consent = FALSE
	var/require_user_mouth
	var/require_user_hands
	var/require_target_mouth
	var/require_target_hands
	var/needs_physical_contact

	var/user_is_target = FALSE //Boolean. Pretty self explanatory.

/// Checks if user can do an interaction, action_check is for whether you're actually doing it or not (useful for the menu and not removing the buttons)
/datum/interaction/proc/evaluate_user(mob/living/user, silent = TRUE, action_check = TRUE)
	if(SSinteractions.is_blacklisted(user))
		return FALSE

	if(require_user_mouth)
		if(!user.has_mouth() && !issilicon(user)) //Again, silicons do not have the required parts normally.
			if(!silent)
				to_chat(user, span_warning("You don't have a mouth."))
			return FALSE

		if(!user.mouth_is_free() && !issilicon(user)) //Borgs cannot wear mouthgear, bypassing the check.
			if(!silent)
				to_chat(user, span_warning("Your mouth is covered."))
			return FALSE

	if(require_user_hands && !user.has_hands() && !issilicon(user)) //Edited to allow silicons to interact.
		if(!silent)
			to_chat(user, span_warning("You don't have hands."))
		return FALSE

	if(COOLDOWN_FINISHED(user, last_interaction_time))
		return TRUE

	if(action_check)
		return FALSE
	else
		return TRUE

/// Same as evaluate_user, but for target
/datum/interaction/proc/evaluate_target(mob/living/user, mob/living/target, silent = TRUE)
	if(SSinteractions.is_blacklisted(target))
		return FALSE

	if(!user_is_target)
		if(user == target)
			if(!silent)
				to_chat(user, "<span class = 'warning'>You can't do that to yourself.</span>")
			return FALSE

	if(require_target_mouth)
		if(!target.has_mouth())
			if(!silent)
				to_chat(user, "<span class = 'warning'>They don't have a mouth.</span>")
			return FALSE

		if(!target.mouth_is_free() && !issilicon(target))
			if(!silent)
				to_chat(user, "<span class = 'warning'>Their mouth is covered.</span>")
			return FALSE

	if(require_target_hands && !target.has_hands() && !issilicon(target))
		if(!silent)
			to_chat(user, "<span class = 'warning'>They don't have hands.</span>")
		return FALSE

	return TRUE

/// Actually doing the action, has a few checks to see if it's valid, usually overwritten to be make things actually happen and what-not
/datum/interaction/proc/do_action(mob/living/user, mob/living/target)
	if(!user_is_target)
		if(user == target) //tactical href fix
			to_chat(user, span_warning("You cannot target yourself."))
			return
	if(get_dist(user, target) > max_distance)
		to_chat(user, span_warning("They are too far away."))
		return
	if(needs_physical_contact && !(user.Adjacent(target) && target.Adjacent(user)))
		to_chat(user, span_warning("You cannot get to them."))
		return
	if(!evaluate_user(user, silent = FALSE))
		return
	if(!evaluate_target(user, target, silent = FALSE))
		return

	if(write_log_user)
		user.log_message("[write_log_user] [target]", LOG_ATTACK)
	if(write_log_target)
		target.log_message("[write_log_target] [user]", LOG_VICTIM, log_globally = FALSE)

	display_interaction(user, target)
	post_interaction(user, target)

/// Display the message
/datum/interaction/proc/display_interaction(mob/living/user, mob/living/target)
	if(simple_message)
		var/use_message = replacetext(simple_message, "USER", "\the [user]")
		use_message = replacetext(use_message, "TARGET", "\the [target]")
		user.visible_message("<span class='[simple_style]'>[capitalize(use_message)]</span>")

/// After the interaction, the base only plays the sound and only if it has one
/datum/interaction/proc/post_interaction(mob/living/user, mob/living/target)
	COOLDOWN_START(user, last_interaction_time, 0.6 SECONDS)
	if(interaction_sound)
		playsound(get_turf(user), interaction_sound, 50, 1, -1)
	return
