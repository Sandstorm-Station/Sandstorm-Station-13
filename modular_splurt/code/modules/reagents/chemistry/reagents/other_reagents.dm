/datum/reagent/consumable/semen/on_mob_add(mob/living/carbon/M)
	. = ..()
	var/datum/quirk/dumb4cum/d4c
	for(var/datum/quirk/Q in M.roundstart_quirks)
		if(Q.type == /datum/quirk/dumb4cum)
			d4c = Q
			d4c.uncrave()

/datum/reagent/blood/on_mob_life(mob/living/carbon/C)
	. = ..()
	if(HAS_TRAIT(C,BLOODFLEDGE))
		C.adjust_nutrition(6) //3/4ed this, felt it was a bit too much
		C.adjust_disgust(-3) //makes the churches effects easily negated

/datum/reagent/water/holywater/on_mob_life(mob/living/carbon/M)//makes holy water slightly disgusting and hungering for vampires
	. = ..()
	if(HAS_TRAIT(M,BLOODFLEDGE))
		M.adjust_disgust(1)
		M.adjust_nutrition(-0.1)
