/datum/job/engineer/New()
	. = ..()
	minimal_access += list(ACCESS_ATMOSPHERICS)
