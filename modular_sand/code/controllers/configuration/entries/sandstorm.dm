/datum/config_entry/flag/admin_disk_inactive_msg //Allows admins to globally disable ingame logs for this crap

/datum/config_entry/string/new_round_ping
	config_entry_value = null

/datum/config_entry/string/panic_bunker_warn
	config_entry_value = null

/datum/config_entry/string/server_display_name
	config_entry_value = null

/datum/config_entry/number/max_languages
	config_entry_value = 1
	min_val = -1

/datum/config_entry/string/force_gamemode
	config_entry_value = null

/datum/config_entry/flag/enable_dogborg_sleepers	// enable normal dogborg sleepers (otherwise recreational)

/datum/config_entry/flag/limit_stupor_trances	// enable limits to hypnotic stupor

/datum/config_entry/number/min_stupor_hypno_duration	//Minimum random duration to maintain hypnosis from hypnotic stupor
	config_entry_value = 6000
	min_val = 10

/datum/config_entry/number/max_stupor_hypno_duration	//Maximum random duration to maintain hypnosis from hypnotic stupor
	config_entry_value = 12000
	min_val = 10
