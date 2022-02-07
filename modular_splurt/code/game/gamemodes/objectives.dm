/datum/objective/rescue_prisoner
	name = "rescue prisoner"

/datum/objective/rescue_prisoner/find_target(dupe_search_range, blacklist)
	var/mob/living/rescue_target = pick(GLOB.roundstart_prisoners)
	if(!rescue_target)
		qdel(src)
		return FALSE
	target = rescue_target.mind
	return target

/datum/objective/rescue_prisoner/check_completion()
	return considered_escaped(target)

/datum/objective/slaver
	name = "slave trading"
	explanation_text = "Earn 200,000 credits through slave trading."
