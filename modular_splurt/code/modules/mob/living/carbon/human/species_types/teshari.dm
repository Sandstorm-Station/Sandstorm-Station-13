#define TESHARI_TEMP_OFFSET -30 // K, added to comfort/damage limit etc
#define TESHARI_BURNMOD 1.25 // They take more damage from practically everything
#define TESHARI_BRUTEMOD 1.2
#define TESHARI_HEATMOD 1.3
#define TESHARI_COLDMOD 0.67 // Except cold.


/datum/species/mammal/teshari
	name = "Teshari"
	id = SPECIES_TESHARI
	say_mod = "mars"
	eye_type = "teshari"
	mutant_bodyparts = list("mcolor" = "FFFFFF", "mcolor2" = "FFFFFF", "mcolor3" = "FFFFFF", "mam_tail" = "Shadekin", "mam_ears" = "Shadekin", "deco_wings" = "None",
						"taur" = "None", "horns" = "None", "legs" = "Plantigrade", "meat_type" = "Mammalian")
	allowed_limb_ids = null
	override_bp_icon = 'modular_splurt/icons/mob/teshari.dmi'
	eye_type = "teshari"


	species_traits = list(MUTCOLORS,
		EYECOLOR,
		NO_UNDERWEAR
		)

	coldmod = TESHARI_COLDMOD
	heatmod = TESHARI_HEATMOD
	brutemod = TESHARI_BRUTEMOD
	burnmod = TESHARI_BURNMOD



	species_language_holder = /datum/language_holder/teshari



	disliked_food = GROSS | GRAIN
	liked_food = MEAT

	payday_modifier = 0.75

/datum/language_holder/teshari
	understood_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
								/datum/language/schechi = list(LANGUAGE_ATOM))
	spoken_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
							/datum/language/schechi = list(LANGUAGE_ATOM))

/datum/language/schechi
