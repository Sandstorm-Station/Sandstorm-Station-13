/datum/preferences/update_character(current_version, savefile/S)
	. = ..()
	if(current_version < 52.01)
		if(features["balls_fluid"])
			features["balls_fluid"] = /datum/reagent/consumable/semen
		if(features["breasts_fluid"])
			features["breasts_fluid"] = /datum/reagent/consumable/milk
