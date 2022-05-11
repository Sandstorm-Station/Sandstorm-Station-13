/obj/machinery/limbgrower/Initialize(mapload)
	var/list/extra_cat = list(
		"shadekin"
	)
	LAZYADD(categories, extra_cat)
	. = ..()

/datum/species/mammal/shadekin
	limbs_id = SPECIES_SHADEKIN
	icon_limbs = 'modular_splurt/icons/mob/human_parts_greyscale.dmi'
