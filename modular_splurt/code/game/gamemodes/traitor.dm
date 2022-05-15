/datum/game_mode/traitor/New()
	var/list/extra_protect = list(
		"Brig Physician",
		"Blueshield"
	)
	LAZYADD(protected_jobs, extra_protect)
	. = ..()
