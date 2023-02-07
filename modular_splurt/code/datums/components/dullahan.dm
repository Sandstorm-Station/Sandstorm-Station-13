/*
* Add new worn icons to modular_splurt/icons/mob/clothing/current_head_accessories.dmi and their type to this list
* with the same icon_state from it's respective item
* 	"welding" if the item gives flash protection
* 	"none" if it's a normal item
* (subtypes included)
*/
#define HEAD_ACCESSORIES_LIST list(\
							/obj/item/clothing/head/welding = "welding",\
							/obj/item/clothing/glasses/welding = "welding",\
							/obj/item/clothing/head/beret = "none",\
							/obj/item/clothing/head/caphat = "none",\
							/obj/item/clothing/head/hopcap = "none",\
							/obj/item/clothing/head/fedora = "none",\
							/obj/item/clothing/head/centhat = "none",\
							/obj/item/clothing/head/pirate/captain,\
							/obj/item/clothing/head/chefhat = "none",\
							/obj/item/reagent_containers/glass/bucket = "none",\
							/obj/item/reagent_containers/rag/towel = "none",\
							/obj/item/paper = "none",\
							/obj/item/clothing/head/cowboyhat = "none",\
							/obj/item/clothing/head/morningstar = "none",\
							/obj/item/nullrod/fedora = "none",\
							/obj/item/clothing/head/maid = "none",\
							/obj/item/clothing/head/crown = "none"\
							)

/datum/component/neckfire
	var/mutable_appearance/neck_fire

	var/color

	var/obj/effect/dummy/luminescent_glow/glowth //shamelessly copied from glowy which copied luminescents

	var/light = 1
	var/is_glowing = FALSE

/datum/component/neckfire/Initialize(fire_color)
	. = ..()
	if(!HAS_TRAIT(parent, TRAIT_DULLAHAN))
		return COMPONENT_INCOMPATIBLE
	neck_fire = mutable_appearance('modular_splurt/icons/mob/dullahan_neckfire.dmi')
	neck_fire.icon_state = "neckfire"

	src.color = "#[fire_color]"
	lit(color)
	RegisterSignal(parent, COMSIG_MOB_DEATH, .proc/unlit)
	// RegisterSignal(parent, COMSIG_MOB_LIFE)

/datum/component/neckfire/proc/lit(fire_color)
	var/mob/living/carbon/M = parent

	if(!neck_fire || M.stat == DEAD)
		return

	unlit(M)

	neck_fire.icon_state = "neckfire"
	neck_fire.color = fire_color
	//neck_fire.plane = 19 // glowy i hope

	var/datum/action/neckfire/A = new /datum/action/neckfire(src)
	A.Grant(M)

	M.add_overlay(neck_fire)

/datum/component/neckfire/proc/unlit(mob/living/carbon/M)
	if(M)
		M.cut_overlay(neck_fire)
	qdel(glowth)
	is_glowing = FALSE

/datum/component/neckfire/Destroy(force=FALSE, silent=FALSE)
	. = ..()
	unlit(parent)
	UnregisterSignal(parent, COMSIG_MOB_DEATH)


/datum/action/neckfire
	name = "Toggle Neckfire Glow"
	icon_icon = 'modular_splurt/icons/mob/dullahan_neckfire.dmi'
	button_icon_state = "neckfire_action"

/datum/action/neckfire/Trigger()
	. = ..()
	var/datum/component/neckfire/N = target
	if(!N.neck_fire)
		return
	if(!N.is_glowing)
		N.glowth = new(N.parent)
		N.glowth.set_light(N.light, N.light, N.color)
		N.is_glowing = TRUE
	else
		qdel(N.glowth)
		N.is_glowing = FALSE

/datum/quirk/dullahan/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	if(H.dna.features["neckfire"] && !istype(H, /mob/living/carbon/human/dummy))
		H.AddComponent(/datum/component/neckfire, H.dna.features["neckfire_color"])

/datum/component/dullahan
	var/obj/item/clothing/head_accessory
	var/mutable_appearance/head_accessory_MA

/datum/component/dullahan/proc/add_head_accessory(obj/item/clothing/I)
	head_accessory_MA = mutable_appearance('modular_splurt/icons/mob/clothing/current_head_accessories.dmi')
	head_accessory_MA.icon_state = I.icon_state
	I.forceMove(dullahan_head)

	dullahan_head.add_overlay(head_accessory_MA)
	head_accessory = I

/datum/component/dullahan/proc/remove_head_accessory(obj/item/clothing/I)
	dullahan_head.cut_overlay(head_accessory_MA)
	head_accessory = null

/datum/component/dullahan/proc/on_mouse_dropped(datum/source, obj/item/I, mob/living/user)
	var/mob/living/carbon/owner = dullahan_head.owner

	if(istype(I, /obj/item) && !head_accessory)
		if(I.type in HEAD_ACCESSORIES_LIST)
			if(HEAD_ACCESSORIES_LIST[I.type] == "welding")
				var/obj/item/organ/eyes/dullahan/DE = owner.getorganslot(ORGAN_SLOT_EYES)
				DE.flash_protect = 2
				DE.tint = 2
				owner.update_tint()

			add_head_accessory(I)
	else
		to_chat(user, span_notice("You can't put \the [I.name] on the head of \the [owner.name]"))
		return

/datum/component/dullahan/proc/on_mouse_drop(datum/source, atom/A, mob/living/user)
	var/mob/living/carbon/owner = dullahan_head.owner

	if(head_accessory)
		if(istype(A, /turf/open))
			head_accessory.forceMove(A)
		else if(istype(A, /atom/movable/screen/inventory/hand))
			var/atom/movable/screen/inventory/hand/H = A

			user.put_in_hand(head_accessory, H.held_index)
		else
			return

		for(var/accessory in HEAD_ACCESSORIES_LIST)
			if(istype(head_accessory, accessory))
				if(HEAD_ACCESSORIES_LIST[accessory] == "welding")
					var/obj/item/organ/eyes/dullahan/DE = owner.getorganslot(ORGAN_SLOT_EYES)
					DE.flash_protect = 0
					DE.tint = 0
					owner.update_tint()

				remove_head_accessory(head_accessory)
