/datum/species/plasmaman
	name = "Plasmaman"
	id = SPECIES_PLASMAMAN
	say_mod = "rattles"
	sexes = 0
	meat = /obj/item/stack/sheet/mineral/plasma
	species_traits = list(NOBLOOD,NOTRANSSTING,NOGENITALS,HAS_BONE)
	inherent_traits = list(TRAIT_RESISTCOLD,TRAIT_RADIMMUNE,TRAIT_NOHUNGER,TRAIT_NOTHIRST,TRAIT_CALCIUM_HEALER)
	inherent_biotypes = MOB_HUMANOID|MOB_MINERAL
	mutantlungs = /obj/item/organ/lungs/plasmaman
	mutanttongue = /obj/item/organ/tongue/bone/plasmaman
	mutantliver = /obj/item/organ/liver/plasmaman
	mutantstomach = /obj/item/organ/stomach/plasmaman
	dangerous_existence = 1 //So so much
	blacklisted = 1 //See above
	burnmod = 1.5
	heatmod = 1.5
	breathid = "tox"
	damage_overlay_type = ""//let's not show bloody wounds or burns over bones.
	var/internal_fire = FALSE //If the bones themselves are burning clothes won't help you much
	disliked_food = FRUIT
	liked_food = VEGETABLES
	outfit_important_for_life = /datum/outfit/plasmaman
	languagewhitelist = list("Calcic") //Skyrat change - species language whitelist

	species_category = SPECIES_CATEGORY_SKELETON
	wings_icons = SPECIES_WINGS_SKELETAL

	ass_image = 'icons/ass/assplasma.png'
	balance_point_values = TRUE
	blacklisted_quirks = list(/datum/quirk/paper_skin)

/datum/species/plasmaman/spec_life(mob/living/carbon/human/H)
	var/datum/gas_mixture/environment = H.loc.return_air()
	var/atmos_sealed = FALSE
	if (H.wear_suit && H.head && istype(H.wear_suit, /obj/item/clothing) && istype(H.head, /obj/item/clothing))
		var/obj/item/clothing/CS = H.wear_suit
		var/obj/item/clothing/CH = H.head
		if (CS.clothing_flags & CH.clothing_flags & STOPSPRESSUREDAMAGE)
			atmos_sealed = TRUE
	if((!istype(H.w_uniform, /obj/item/clothing/under/plasmaman) || !istype(H.head, /obj/item/clothing/head/helmet/space/plasmaman)) && !atmos_sealed)
		if(environment)
			if(environment.total_moles())
				if(environment.get_moles(GAS_O2) >= 1) //Same threshhold that extinguishes fire
					H.adjust_fire_stacks(0.5)
					if(!H.on_fire && H.fire_stacks > 0)
						H.visible_message("<span class='danger'>[H]'s body reacts with the atmosphere and bursts into flames!</span>","<span class='userdanger'>Your body reacts with the atmosphere and bursts into flame!</span>")
					H.IgniteMob()
					internal_fire = TRUE
	else
		if(H.fire_stacks)
			var/obj/item/clothing/under/plasmaman/P = H.w_uniform
			if(istype(P))
				P.Extinguish(H)
				internal_fire = FALSE
		else
			internal_fire = FALSE
	H.update_fire()

/datum/species/plasmaman/handle_fire(mob/living/carbon/human/H, no_protection)
	if(internal_fire)
		no_protection = TRUE
	..()

/datum/species/plasmaman/before_equip_job(datum/job/J, mob/living/carbon/human/H, visualsOnly = FALSE)
	var/datum/outfit/plasmaman/O = new /datum/outfit/plasmaman
	if(J)
		if(J.plasma_outfit)
			O = new J.plasma_outfit

	H.equipOutfit(O, visualsOnly)
	H.internal = H.get_item_for_held_index(2)
	return FALSE

/datum/species/plasmaman/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_plasmaman_name()

	var/randname = plasmaman_name()

	if(lastname)
		randname += " [lastname]"

	return randname
