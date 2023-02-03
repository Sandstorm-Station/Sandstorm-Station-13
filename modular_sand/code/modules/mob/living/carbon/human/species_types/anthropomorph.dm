/datum/species/mammal/synthetic/New()
	. = ..()

	// Define inherent traits to add
	var/modular_inherent_traits = list(TRAIT_NOTHIRST)

	// Add new traits to list
	LAZYADD(inherent_traits, modular_inherent_traits)

/datum/species/mammal/randomize(mob/living/carbon/human/H)
	. = ..()

	var/mcolor = sanitize_hexcolor(random_short_color(), 6)
	H.dna.features["mcolor"] = mcolor
	H.dna.features["mcolor2"] = mcolor
	H.dna.features["mcolor3"] = mcolor

	H.dna.features["legs"] = pick("Plantigrade", "Digitigrade")

	H.dna.features["mam_body_markings"] = list()

	// Let's do a little funny! We need em convincing!
	var/list/sub_species = list("Husky", "Sergal")
	switch(pick(sub_species))
		if("Sergal")
			H.dna.features["mam_ears"] = "Sergal"
			H.dna.features["mam_tail"] = "Sergal"
			H.dna.features["mam_snouts"] = "Sergal"
			prepare_markings(H, selected_marking = sub_species, color1 = mcolor, color2 = mcolor, color3 = mcolor)
		if("Husky")
			H.dna.features["mam_ears"] = "Husky"
			H.dna.features["mam_tail"] = "Husky"
			H.dna.features["mam_snouts"] = "Husky"
			prepare_markings(H, selected_marking = sub_species, color1 = mcolor, color2 = mcolor, color3 = mcolor)
		else
			H.dna.features["mam_ears"] = pick(GLOB.mam_ears_list)
			H.dna.features["mam_tail"] = pick(GLOB.mam_tails_list)
			H.dna.features["mam_snouts"] = pick(GLOB.mam_snouts_list)
			H.dna.features["snout"] = pick(GLOB.snouts_list)
			H.dna.features["spines"] = pick(GLOB.spines_list)
			H.dna.features["insect_wings"] = pick(GLOB.insect_wings_list)
			H.dna.features["deco_wings"] = pick(GLOB.deco_wings_list)
			H.dna.features["insect_fluff"] = pick(GLOB.insect_fluffs_list)
			H.dna.features["arachnid_legs"] = pick(GLOB.arachnid_legs_list)
			H.dna.features["arachnid_spinneret"] = pick(GLOB.arachnid_spinneret_list)
			H.dna.features["arachnid_mandibles"] = pick(GLOB.arachnid_mandibles_list)

	H.dna.features["genitals_use_skintone"] = FALSE
	// Male bits
	H.dna.features["cock_color"] = "A50021"
	H.dna.features["cock_shape"] = "Knotted"
	H.dna.features["balls_shape"] = "Single"
	// Female bits
	H.dna.features["vag_color"] = mcolor
	H.dna.features["breasts_color"] = mcolor
	// All bits
	H.dna.features["butt_color"] = mcolor
