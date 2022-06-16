/datum/mood_event/masked_mook_incomplete
	description = "<span class='warning'>I feel incomplete without a gas mask...</span>\n"
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
