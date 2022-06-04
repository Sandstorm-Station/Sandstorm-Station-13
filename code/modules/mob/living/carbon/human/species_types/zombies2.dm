/mob/living/carbon/handle_breathing(times_fired)
	if(iszombie(src)) //silly zombie, breathing is for the living
		return
	. = ..()

/mob/living/carbon/human/handle_blood()
	if(iszombie(src)) //We're basically pudding pops.
		return
	. = ..()


/datum/species/mammal/undead
	id = SPECIES_UMAMMAL
	name = "Undead Anthropomorph"
	exotic_bloodtype = "U"
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/zombie
	liked_food = GROSS | MEAT | RAW
	disliked_food = NONE
	blacklisted = 1
	say_mod = "moans"
	mutant_organs = list(/obj/item/organ/undead_infection/mammal)
	brutemod = 1.2	//Get hurts more than average. doesn't fall down as easily, though.
	burnmod = 1.2	//Essentially 1-2 more hits from weapons before hard-crit, compared to soft-critting

	wings_icons = SPECIES_WINGS_SKELETAL
	species_traits = list(NOZOMBIE,NOTRANSSTING,MUTCOLORS,EYECOLOR,LIPS,HAIR,HORNCOLOR,WINGCOLOR,CAN_SCAR,HAS_FLESH,HAS_BONE)
	inherent_traits = list(TRAIT_AUXILIARY_LUNGS,TRAIT_RESISTCOLD,TRAIT_RESISTLOWPRESSURE,TRAIT_RADIMMUNE,TRAIT_EASYDISMEMBER,TRAIT_LIMBATTACHMENT,TRAIT_NOSOFTCRIT,TRAIT_NODEATH,TRAIT_FAKEDEATH)
	inherent_biotypes = MOB_UNDEAD|MOB_HUMANOID|MOB_BEAST

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
	mutant_organs = list(/obj/item/organ/undead_infection/insect)
	species_traits = list(NOZOMBIE,NOTRANSSTING,MUTCOLORS,EYECOLOR,LIPS,HAIR,HORNCOLOR,WINGCOLOR,CAN_SCAR,HAS_FLESH,HAS_BONE)
	inherent_traits = list(TRAIT_AUXILIARY_LUNGS,TRAIT_RESISTCOLD,TRAIT_RESISTLOWPRESSURE,TRAIT_RADIMMUNE,TRAIT_EASYDISMEMBER,TRAIT_LIMBATTACHMENT,TRAIT_NODEATH,TRAIT_FAKEDEATH)
	inherent_biotypes = MOB_UNDEAD|MOB_HUMANOID|MOB_BUG

	mutanteyes = /obj/item/organ/eyes/decayed 	//Can see well in the dark. Pretty much no protection from flashes, even with goggles.
	mutanttongue = /obj/item/organ/tongue/zombie

	species_category = SPECIES_CATEGORY_UNDEAD

/datum/species/lizard/undead
	id = SPECIES_GLIZZY
	name = "Undead Lizard"
	exotic_bloodtype = "U"
	exotic_blood_color = BLOOD_COLOR_LIZARD
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/zombie
	liked_food = GROSS | MEAT | RAW
	blacklisted = 1
	say_mod = "moans"
	mutant_organs = list(/obj/item/organ/undead_infection/lizard)
	burnmod = 0.5 //They are fire retardant... Glizzy popsicles can't survive in cold or space, though.

	species_traits = list(NOZOMBIE,NOTRANSSTING,MUTCOLORS,EYECOLOR,LIPS,HAIR,HORNCOLOR,WINGCOLOR,CAN_SCAR,HAS_FLESH,HAS_BONE)
	inherent_traits = list(TRAIT_AUXILIARY_LUNGS,TRAIT_RESISTHEAT,TRAIT_RESISTHIGHPRESSURE,TRAIT_RADIMMUNE,TRAIT_EASYDISMEMBER,TRAIT_LIMBATTACHMENT,TRAIT_NOHARDCRIT,TRAIT_NODEATH,TRAIT_FAKEDEATH)
	inherent_biotypes = MOB_UNDEAD|MOB_HUMANOID|MOB_REPTILE

	mutanttongue = /obj/item/organ/tongue/zombie

	species_category = SPECIES_CATEGORY_UNDEAD


/obj/item/organ/eyes/decayed
	name = "shabriri grapes"
	desc = "Delectably tender and sweet, yet searing..."
	//Budget night_vision... Fear the sun, you monster
	lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	see_in_dark = 6
	flash_protect = -2

/obj/item/organ/undead_infection
	name = "festering ooze"
	desc = "A black web of pus and viscera."
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_ZOMBIE
	icon_state = "blacktumor"
	var/causes_damage = TRUE
	var/datum/species/old_species = /datum/species/human
	var/living_transformation_time = 30
	var/converts_living = FALSE

	var/revive_time_min = 450
	var/revive_time_max = 700
	var/timer_id

/obj/item/organ/undead_infection/Initialize(mapload)
	. = ..()
	if(iscarbon(loc))
		Insert(loc)
	GLOB.zombie_infection_list += src

/obj/item/organ/zombie_infection/Destroy()
	GLOB.zombie_infection_list -= src
	. = ..()

/obj/item/organ/undead_infection/Insert(var/mob/living/carbon/M, special = 0, drop_if_replaced = FALSE)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/organ/undead_infection/Remove(special = FALSE)
	if(owner)
		if(iszombie(owner) && old_species)
			owner.set_species(old_species)
		if(timer_id)
			deltimer(timer_id)
	. = ..()
	STOP_PROCESSING(SSobj, src) //Required to be done after the parent call to avoid conflicts with organ decay.

/obj/item/organ/undead_infection/on_find(mob/living/finder)
	to_chat(finder, "<span class='warning'>Inside the head is a disgusting black \
		web of pus and viscera, bound tightly around the brain like some \
		biological harness.</span>")

/obj/item/organ/undead_infection/process()
	if(!owner)
		return
	if(!(src in owner.internal_organs))
		INVOKE_ASYNC(src,.proc/Remove,owner)
	if(owner.mob_biotypes & MOB_MINERAL)//does not process in inorganic things
		return
	if (causes_damage && !iszombie(owner) && owner.stat != DEAD)
		owner.adjustToxLoss(1)
		if (prob(10))
			to_chat(owner, "<span class='danger'>You feel sick...</span>")
	if(timer_id)
		return
	if(owner.suiciding)
		return
	if(owner.stat != DEAD && !converts_living)
		return
	if(!owner.getorgan(/obj/item/organ/brain))
		return
	if(!iszombie(owner))
		to_chat(owner, "<span class='cultlarge'>You can feel your heart stopping, but something isn't right... \
		life has not abandoned your broken form. You can only feel a deep and immutable hunger that \
		not even death can stop, you will rise again!</span>")
		var/revive_time = rand(revive_time_min, revive_time_max)
		var/flags = TIMER_STOPPABLE
		timer_id = addtimer(CALLBACK(src, .proc/zombify), revive_time, flags)

/obj/item/organ/undead_infection/proc/zombify()
	timer_id = null

	if(!converts_living && owner.stat != DEAD)
		return

	if(!iszombie(owner))
		old_species = owner.dna.species.type
		if(old_species == /datum/species/mammal)
			owner.set_species(/datum/species/mammal/undead)
		else if(old_species == /datum/species/insect)
			owner.set_species(/datum/species/insect/undead)
		else if(old_species == /datum/species/lizard)
			owner.set_species(/datum/species/lizard/undead)
		else
			owner.set_species(/datum/species/zombie/infectious)

	//Fully heal the zombie's damage the first time they rise
	owner.setToxLoss(0, 0)
	owner.setOxyLoss(0, 0)
	owner.heal_overall_damage(INFINITY, INFINITY, INFINITY, FALSE, FALSE, TRUE)

	if(!owner.revive())
		return

	owner.grab_ghost()
	owner.visible_message("<span class='danger'>[owner] suddenly convulses, as [owner.p_they()] squirm back awake and gain a ravenous hunger in [owner.p_their()] eyes!</span>", "<span class='alien'>You HUNGER!</span>")
	playsound(owner.loc, 'sound/hallucinations/far_noise.ogg', 50, 1)
	owner.do_jitter_animation(living_transformation_time)
	owner.Stun(living_transformation_time)

/obj/item/organ/undead_infection/mammal
	old_species = /datum/species/mammal

/obj/item/organ/undead_infection/insect
	old_species = /datum/species/insect

/obj/item/organ/undead_infection/lizard
	old_species = /datum/species/lizard
