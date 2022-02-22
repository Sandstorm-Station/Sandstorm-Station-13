/obj/item/organ/genital/breasts/get_features(mob/living/carbon/human/H)
	var/datum/dna/D = H.dna
	if(D.features["breasts_fluid"])
		fluid_id = D.features["breasts_fluid"]
	else
		fluid_id = initial(fluid_id)
	. = ..()

