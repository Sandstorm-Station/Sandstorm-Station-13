/obj/item/organ/genital/vagina/get_fluid()
	if(linked_organ)
		return (clamp(linked_organ.fluid_rate * ((world.time - last_orgasmed) / (10 SECONDS)) * linked_organ.fluid_mult, 0, linked_organ.fluid_max_volume) / linked_organ.fluid_max_volume)
	else
		return ..()
