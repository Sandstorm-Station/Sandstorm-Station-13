/datum/reagent/consumable/semen/on_mob_add(mob/living/carbon/M)
	. = ..()
	var/datum/quirk/dumb4cum/d4c
	for(var/datum/quirk/Q in M.roundstart_quirks)
		if(Q.type == /datum/quirk/dumb4cum)
			d4c = Q
			d4c.uncrave()