/obj/item/clothing/under/misc/latex_catsuit
	name = "latex catsuit"
	desc = "A shiny uniform that fits snugly to the skin."
	icon_state = "latex_catsuit_female"
	item_state = "latex_catsuit"
	icon = 'modular_sand/icons/obj/clothing/lewd_clothes/uniform/lewd_uniform.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/lewd_clothing/uniform/lewd_uniform.dmi'
	anthro_mob_worn_overlay = 'modular_sand/icons/mob/clothing/lewd_clothing/uniform/lewd_uniform-digi.dmi'
	taur_mob_worn_overlay = 'modular_sand/icons/mob/clothing/lewd_clothing/uniform/lewd_uniform-taur.dmi'
	lefthand_file = 'modular_sand/icons/mob/inhands/lewd_items/lewd_inhand_left.dmi'
	righthand_file = 'modular_sand/icons/mob/inhands/lewd_items/lewd_inhand_right.dmi'
	//equip_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg'
	can_adjust = FALSE
	strip_delay = 80
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_ALL_TAURIC

	var/mutable_appearance/breasts_overlay
	var/mutable_appearance/breasts_icon_overlay
/*//this fragment of code makes unequipping not instant
/obj/item/clothing/under/misc/latex_catsuit/attack_hand(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/human/C = user
		if(src == C.w_uniform)
			if(!do_after(C, 60, target = src))
				return
	. = ..()
*/
// //some gender identification magic
/obj/item/clothing/under/misc/latex_catsuit/equipped(mob/living/U, slot)
	. = ..()
	var/mob/living/carbon/human/C = U
	var/obj/item/organ/genital/breasts/B = C.getorganslot(ORGAN_SLOT_BREASTS)
	/*if(src == C.w_uniform)
		if(U.gender == FEMALE)
			icon_state = "latex_catsuit_female"
			U.update_inv_w_uniform()

		if(U.gender == MALE)
			icon_state = "latex_catsuit_male"
			U.update_inv_w_uniform()

	//For giving taurs proper sprites
	if(C.dna.species.mutant_bodyparts["taur"])
		breasts_overlay = mutable_appearance('modular_sand/icons/mob/clothing/lewd_clothing/uniform/lewd_uniform-snake.dmi', "none")
		update_overlays()
	else
		breasts_overlay = mutable_appearance('modular_sand/icons/mob/clothing/lewd_clothing/uniform/lewd_uniform.dmi', "none")
		update_overlays()
*/
	//Breasts overlay for catsuit
	if(B?.shape == "Pair")
		breasts_overlay.icon_state = "breasts_double"
		breasts_icon_overlay.icon_state = "iconbreasts_double"
		accessory_overlay = breasts_overlay
		add_overlay(breasts_icon_overlay)
		update_overlays()
	if(B?.shape == "Quad")
		breasts_overlay.icon_state = "breasts_quad"
		breasts_icon_overlay.icon_state = "iconbreasts_quad"
		accessory_overlay = breasts_overlay
		add_overlay(breasts_icon_overlay)
		update_overlays()
	if(B?.shape == "Sextuple")
		breasts_overlay.icon_state = "breasts_sextuple"
		breasts_icon_overlay.icon_state = "iconbreasts_sextuple"
		accessory_overlay = breasts_overlay
		add_overlay(breasts_icon_overlay)
		update_overlays()

	if(C.dna.species.mutant_bodyparts["taur"] && src == C.w_uniform)
		C.remove_overlay(BODY_BEHIND_LAYER)
		C.remove_overlay(BODY_FRONT_LAYER)
	C.regenerate_icons()

/obj/item/clothing/under/misc/latex_catsuit/dropped(mob/living/U)
	. = ..()
	var/mob/living/carbon/human/C = U
	accessory_overlay = null
	breasts_overlay.icon_state = "none"
	cut_overlay(breasts_icon_overlay)
	breasts_icon_overlay.icon_state = "none"
	if(C.dna.species.mutant_bodyparts["taur"] && src == C.w_uniform)
		C.apply_overlay(BODY_BEHIND_LAYER)
		C.apply_overlay(BODY_FRONT_LAYER)

//Plug to bypass the bug with instant suit equip/drop
/obj/item/clothing/under/misc/latex_catsuit/MouseDrop(atom/over_object)

/obj/item/clothing/under/misc/latex_catsuit/Initialize()
	. = ..()
	breasts_overlay = mutable_appearance('modular_sand/icons/mob/clothing/lewd_clothing/uniform/lewd_uniform.dmi', "none", ABOVE_MOB_LAYER)
	breasts_overlay.icon_state = "breasts"
	breasts_icon_overlay = mutable_appearance('modular_sand/icons/obj/clothing/lewd_clothes/uniform/lewd_uniform.dmi', "none")
	breasts_icon_overlay.icon_state = "breasts"
