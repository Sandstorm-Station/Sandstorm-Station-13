/datum/reagent/consumable/semen/on_mob_add(mob/living/carbon/M)
	. = ..()
	var/datum/quirk/dumb4cum/d4c
	for(var/datum/quirk/Q in M.roundstart_quirks)
		if(Q.type == /datum/quirk/dumb4cum)
			d4c = Q
			d4c.uncrave()
//incubus and succubus additions below
/datum/reagent/consumable/semen/on_mob_life(mob/living/carbon/M)
	. = ..()
	if(HAS_TRAIT(M,TRAIT_SUCCUBUS))
		M.adjust_nutrition(0.5)

/datum/reagent/consumable/milk/on_mob_life(mob/living/carbon/M)
	. = ..()
	if(HAS_TRAIT(M,TRAIT_INCUBUS))
		M.adjust_nutrition(0.5)
