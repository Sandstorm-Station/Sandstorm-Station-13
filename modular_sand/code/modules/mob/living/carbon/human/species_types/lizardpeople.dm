#define ESTROUS_CYCLE_LENGTH 32
#define ESTROUS_CYCLE_OFFSET 11

/datum/species/lizard/New()
	mutant_bodyparts += list("ears" = "None")
	. = ..()

/datum/species/lizard/randomize(mob/living/carbon/human/H)
	. = ..()

	var/mcolor = sanitize_hexcolor(random_short_color(), 6)
	H.dna.features["mcolor"] = mcolor
	H.dna.features["mcolor2"] = mcolor
	H.dna.features["mcolor3"] = mcolor
	H.hair_style = "Bald"
	H.facial_hair_style = "Shaved"
	H.dna.features["legs"] = "Digitigrade"

	H.dna.features["genitals_use_skintone"] = FALSE
	// Male bits
	H.dna.features["cock_color"] = "A50021"
	H.dna.features["cock_shape"] = "Tapered"
	H.dna.features["balls_shape"] = "Hidden"
	// Female bits
	H.dna.features["vag_color"] = mcolor
	H.dna.features["vag_shape"] = "Cloaca"
	H.dna.features["breasts_color"] = mcolor
	// All bits
	H.dna.features["butt_color"] = mcolor

	// If this creature gets to chance gender & get a
	// give_genitals(TRUE) call they'll have features still

/datum/species/lizard/ashwalker/on_species_gain(mob/living/carbon/human/C, datum/species/old_species, pref_load)
	. = ..()
	ADD_TRAIT(C, TRAIT_ESTROUS_DETECT, SPECIES_TRAIT)
	var/temp = text2num(GLOB.round_id)
	var/tempish = ((temp + (ESTROUS_CYCLE_OFFSET + 2)) % ESTROUS_CYCLE_LENGTH)
	if(tempish <= 2 && tempish >= 0)
		to_chat(C, span_userlove("It's this time again.. Your loins lay restless as they await a potential mate."))
		ADD_TRAIT(C, TRAIT_ESTROUS_ACTIVE, SPECIES_TRAIT)

/datum/species/lizard/ashwalker/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	REMOVE_TRAIT(C, TRAIT_ESTROUS_DETECT, SPECIES_TRAIT)
	REMOVE_TRAIT(C, TRAIT_ESTROUS_ACTIVE, SPECIES_TRAIT)
	// Still have the trait? We don't need to know that
	// we lost it from no longer being an ashwalker
	if(!HAS_TRAIT(C, TRAIT_ESTROUS_ACTIVE))
		to_chat(C, span_userlove("Your animalistic need leaves you as you become a different species."))


#undef ESTROUS_CYCLE_LENGTH
#undef ESTROUS_CYCLE_OFFSET
