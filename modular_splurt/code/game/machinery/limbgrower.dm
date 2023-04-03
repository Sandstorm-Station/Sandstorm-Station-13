/obj/machinery/limbgrower/Initialize(mapload)
	var/list/extra_cat = list(
		"shadekin",
		"teshari"
	)
	LAZYADD(categories, extra_cat)
	. = ..()

/datum/species/mammal/shadekin
	limbs_id = SPECIES_SHADEKIN
	icon_limbs = 'modular_splurt/icons/mob/human_parts_greyscale.dmi'

/datum/species/mammal/teshari
	limbs_id = SPECIES_TESHARI
	icon_limbs = 'modular_splurt/icons/mob/teshari.dmi'
