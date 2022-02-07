/obj/item/organ/genital/testicles/get_features(mob/living/carbon/human/H)
	var/datum/dna/D = H.dna
	fluid_id = D.features["balls_fluid"]
	. = ..()

