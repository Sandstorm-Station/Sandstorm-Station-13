/obj/item/organ/genital/testicles/get_features(mob/living/carbon/human/H)
	var/datum/dna/D = H.dna
	if(D.features["balls_fluid"])
		var/datum/reagent/fluid = find_reagent_object_from_type(D.features["balls_fluid"])
		if(fluid && ((fluid in GLOB.genital_fluids_list) || istype(fluid, H.get_blood_id())))
			fluid_id = D.features["balls_fluid"]
	else
		fluid_id = initial(fluid_id)
	original_fluid_id = fluid_id
	. = ..()
