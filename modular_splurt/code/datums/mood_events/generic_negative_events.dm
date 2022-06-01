/datum/mood_event/masked_mook_incomplete
	description = "<span class='warning'>I feel incomplete without a gas mask...</span>\n"
	mood_change = -4

/datum/mood_event/creampie/cheesed
	description = span_warning("I've been cheesed. Tastes like cheese.\n")

/datum/mood_event/creampie/cheesed/add_effects(param)
	. = ..()
	if(!ishuman(owner))
		return .
	var/mob/living/carbon/human/H = owner

	if(iscatperson(H))
		description = span_warning("<b>CHEESE!!! WAAAAAAAAAAAAAAAAAAAAAAAAAAAA!!!</b>")
		mood_change = -5
		timeout = 5 MINUTES
