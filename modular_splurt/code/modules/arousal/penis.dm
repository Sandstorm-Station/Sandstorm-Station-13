/obj/item/organ/genital/penis/get_features(mob/living/carbon/human/H)
	. = ..()
	fluid_max_volume += (length - initial(length))*2.5
	fluid_rate += (length - initial(length))/10
