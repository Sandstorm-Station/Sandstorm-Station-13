/datum/species/mammal/undead
	id = SPECIES_UMAMMAL
	name = "Undead Anthropomorph"
	exotic_bloodtype = "U"
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/zombie
	liked_food = GROSS | MEAT | RAW
	disliked_food = NONE
	blacklisted = 1
	say_mod = "moans"
	mutant_bodyparts = list("mcolor" = "FFFFFF","mcolor2" = "FFFFFF","mcolor3" = "FFFFFF", "mam_snouts" = "Husky", "mam_tail" = "Husky", "mam_ears" = "Husky", "deco_wings" = "None",
						 "mam_body_markings" = list(), "taur" = "None", "horns" = "None", "legs" = "Plantigrade", "meat_type" = "Mammalian")

	wings_icons = SPECIES_WINGS_SKELETAL
	species_traits = list(NOBLOOD,NOZOMBIE,NOTRANSSTING,MUTCOLORS,EYECOLOR,LIPS,HAIR,HORNCOLOR,WINGCOLOR,HAS_FLESH,HAS_BONE)
	inherent_traits = list(TRAIT_RESISTCOLD,TRAIT_RESISTHIGHPRESSURE,TRAIT_RESISTLOWPRESSURE,TRAIT_RADIMMUNE,TRAIT_EASYDISMEMBER,TRAIT_LIMBATTACHMENT,TRAIT_NOBREATH,TRAIT_NOHARDCRIT,TRAIT_NODEATH,TRAIT_FAKEDEATH)
	inherent_biotypes = MOB_UNDEAD|MOB_HUMANOID|MOB_BEAST

	mutanteyes = /obj/item/organ/eyes/decayed
	mutanttongue = /obj/item/organ/tongue/zombie

	species_category = SPECIES_CATEGORY_UNDEAD

/datum/species/insect/undead
	id = SPECIES_UINSECT
	name = "Undead Insect"
	exotic_bloodtype = "U"
	exotic_blood_color = BLOOD_COLOR_BUG
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/zombie
	liked_food = GROSS | MEAT | RAW
	disliked_food = NONE
	blacklisted = 1
	say_mod = "moans"
	mutant_bodyparts = list("mcolor" = "FFFFFF","mcolor2" = "FFFFFF","mcolor3" = "FFFFFF", "mam_tail" = "None", "mam_ears" = "None",
							"insect_wings" = "None", "insect_fluff" = "None", "mam_snouts" = "None", "taur" = "None", "insect_markings" = "None", "mam_body_markings" = list())

	species_traits = list(NOBLOOD,NOZOMBIE,NOTRANSSTING,MUTCOLORS,EYECOLOR,LIPS,HAIR,HORNCOLOR,WINGCOLOR,HAS_FLESH,HAS_BONE)
	inherent_traits = list(TRAIT_RESISTCOLD,TRAIT_RESISTHIGHPRESSURE,TRAIT_RESISTLOWPRESSURE,TRAIT_RADIMMUNE,TRAIT_EASYDISMEMBER,TRAIT_LIMBATTACHMENT,TRAIT_NOBREATH,TRAIT_NOHARDCRIT,TRAIT_NODEATH,TRAIT_FAKEDEATH)
	inherent_biotypes = MOB_UNDEAD|MOB_HUMANOID|MOB_BUG

	mutanteyes = /obj/item/organ/eyes/decayed
	mutanttongue = /obj/item/organ/tongue/zombie

	species_category = SPECIES_CATEGORY_UNDEAD

/obj/item/organ/eyes/decayed
	name = "shabriri grapes"
	desc = "Delectably tender and sweet, yet searing..."
	//Budget night_vision... Fear the sun, you monster
	see_in_dark = 6
	flash_protect = -2
