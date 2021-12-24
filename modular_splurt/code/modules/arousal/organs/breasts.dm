/obj/item/organ/genital/breasts/get_features(mob/living/carbon/human/H)
	var/datum/dna/D = H.dna
	fluid_id = D.features["breasts_fluid"]
	. = ..()

