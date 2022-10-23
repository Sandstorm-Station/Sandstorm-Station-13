/datum/job/atmos/New()
	. = ..()
	access += list(ACCESS_TCOMSAT)
	minimal_access += list(ACCESS_TCOMSAT, ACCESS_TECH_STORAGE)
