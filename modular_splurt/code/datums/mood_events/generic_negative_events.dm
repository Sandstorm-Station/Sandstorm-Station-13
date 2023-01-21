/datum/mood_event/masked_mook_incomplete
	description = span_warning("I feel incomplete without a gas mask...")
	mood_change = -4

/datum/mood_event/creampie/cheesed
	description = span_warning("I've been cheesed. Tastes like cheese.\n")

/datum/mood_event/creampie/cheesed/add_effects(param)
	. = ..()
	var/mob/living/carbon/human/actual_owner = owner_mob()

	if(!ishuman(actual_owner))
		return .
	if(iscatperson(actual_owner))
		description = span_warning("<b>CHEESE!!! WAAAAAAAAAAAAAAAAAAAAAAAAAAAA!!!</b>")
		mood_change = -5
		timeout = 5 MINUTES

/datum/mood_event/nudist_negative
	description = span_warning("I don't feel comfortable wearing this.\n")
	mood_change = -4

/datum/mood_event/dorsualiphobic_mood_negative
	description = span_warning("I can't let anyone find out if I'm wearing a backpack or not!\n")
	mood_change = -4
