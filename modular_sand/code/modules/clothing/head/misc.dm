/obj/item/clothing/head/slouch_hat
	name = "Slouch hat"
	desc = "An Australian Military slouch hat with one side turned up... Smells faintly of Kangaroos."
	icon = 'modular_sand/icons/obj/clothing/hats.dmi'
	icon_state = "slouch"
	item_state = "slouch"
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'
	mutantrace_variation = STYLE_NO_ANTHRO_ICON

/obj/item/clothing/head/lawdog
	name = "Law dog"
	desc = "Hat of the old west law bringers like bass reeves and wyatt erp."
	icon = 'modular_sand/icons/obj/clothing/hats.dmi'
	icon_state = "lawdog"
	item_state = "lawdog"
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'
	mutantrace_variation = STYLE_NO_ANTHRO_ICON

/obj/item/clothing/head/gunfighter
	name = "Gun fighter"
	desc = "One hell of a bastard wears this hat upon their head... with its hat band made out of bullet casings folks can tell you mean business."
	icon = 'modular_sand/icons/obj/clothing/hats.dmi'
	icon_state = "gunfighter"
	item_state = "gunfighter"
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'
	mutantrace_variation = STYLE_NO_ANTHRO_ICON

// This icon fixes blue-ish tint on the helmet
/obj/item/clothing/head/assu_helmet
	icon = 'modular_sand/icons/obj/clothing/head.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'

/obj/item/clothing/head/jester
	unique_reskin = list(
		"Original" = list(
			"icon_state" = "jester_hat",
			"icon" = 'icons/obj/clothing/hats.dmi',
			"mob_overlay_icon" = null,
		),
		"Stripped" = list(
			"icon_state" = "striped_jester_hat",
			"icon" = 'modular_sand/icons/obj/clothing/head.dmi',
			"mob_overlay_icon" = 'modular_sand/icons/mob/clothing/head.dmi',
		)
	)

/obj/item/clothing/head/bridgeofficer
	name = "bridge officer cap"
	desc = "A generic blue cap for the back ground officer"
	icon_state = "bridgeseccap"
	item_state = "bridgeseccap"
	icon = 'modular_sand/icons/obj/clothing/head.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/head.dmi'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	strip_delay = 25
	dynamic_hair_suffix = ""
	dog_fashion = null

/obj/item/clothing/head/bridgeofficer/beret
	name = "bridge officer beret"
	desc = "A generic blue beret for the back ground officer"
	icon_state = "beret_bridgesec"
	item_state = "beret_bridgesec"
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'

/obj/item/clothing/head/press_helmet
	name = "press helmet"
	icon_state = "press_helmet"
	item_state = "press_helmet"
	desc = "A lightweight helmet for reporting on security. You swear up and down it is made of Kevlar and not old cloth and plastic."
	icon = 'modular_sand/icons/obj/clothing/head.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'
	flags_inv = HIDEHAIR

//CBRN/MOPP helmets

/obj/item/clothing/head/helmet/cbrn
	name = "CBRN hood"
	desc = "Chemical, Biological, Radiological and Nuclear. A hood design for harsh environmental conditions short of no atmosphere"
	icon_state = "cbrnhood"
	item_state = "cbrnhood"
	icon = 'modular_sand/icons/obj/clothing/head.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'
	armor = list("melee" = 5, "bullet" = 0, "laser" = 5,"energy" = 5, "bomb" = 0, "bio" = 100, "rad" = 100, "fire" = 40, "acid" = 100)
	w_class = WEIGHT_CLASS_NORMAL
	gas_transfer_coefficient = 0.5
	permeability_coefficient = 0.5
	strip_delay = 60
	equip_delay_other = 60
	body_parts_covered = HEAD
	clothing_flags = THICKMATERIAL
	flags_inv = HIDEHAIR|HIDEEARS
	resistance_flags = ACID_PROOF
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/clothing/head/helmet/cbrn/mopp
	name = "MOPP hood"
	desc = "Mission Oriented Protective Posture. A hood design for harsh combat conditions short of no atmosphere. This one has a helmet towed onto the hood for added protection."
	icon_state = "mopphood"
	item_state = "mopphood"
	can_flashlight = 1
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30,"energy" = 10, "bomb" = 25, "bio" = 100, "rad" = 100, "fire" = 40, "acid" = 100)

/obj/item/clothing/head/helmet/cbrn/mopp/advance
	name = "advance MOPP hood"
	desc = "Mission Oriented Protective Posture. A hood design for harsh combat conditions short of no atmosphere. This is an advance versoin for ERT units and Central Command Staff."
	can_flashlight = 1
	armor = list("melee" = 50, "bullet" = 40, "laser" = 40,"energy" = 20, "bomb" = 35, "bio" = 110, "rad" = 110, "fire" = 50, "acid" = 110)
	clothing_flags = NONE


// research nods
/datum/design/cbrn/cbrnhood
	name = "CBRN Hood"
	desc = "A CBRN hood."
	id = "cbrn_hood"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 200, /datum/material/uranium = 50, /datum/material/iron = 200)
	build_path = /obj/item/clothing/head/helmet/cbrn
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SERVICE | DEPARTMENTAL_FLAG_CARGO | DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_MEDICAL

/datum/design/cbrn/mopphood
	name = "MOPP Hood"
	desc = "A MOPP hood with an integrated helmet"
	id = "mopp_hood"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 200, /datum/material/uranium = 50, /datum/material/iron = 200)
	build_path = /obj/item/clothing/head/helmet/cbrn/mopp
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/clothing/head/invisihat
	name = "invisifiber hat"
	desc = "A hat made of transparent fibers, often used with reinforcement kits."
	icon = 'modular_sand/icons/obj/clothing/head.dmi'
	// No overlay, because they're invisible!
	icon_state = "hat_transparent"
	// Makes the invisible hat not screw up hair.
	dynamic_hair_suffix = ""

/obj/item/clothing/head/clussy_wig
	name = "Clussy wig"
	desc = "Wearing this will certainly make your pussy honk..."
	icon = 'modular_sand/icons/obj/clothing/head.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'
	icon_state = "clussy_wig"
	item_state = "clussy_wig"
	flags_inv = HIDEHAIR

/obj/item/clothing/head/hoodcowl
	name = "Hood cowl"
	desc = "A dirty, worn-down rag with crudely cut-out eyeholes that barely qualifies as clothing."
	icon = 'modular_sand/icons/obj/clothing/head.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'
	icon_state = "hoodcowl"
	item_state = "hoodcowl"
	flags_inv = HIDEHAIR
	dynamic_hair_suffix = ""
