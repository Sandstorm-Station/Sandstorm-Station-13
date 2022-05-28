/datum/component/pregnancy

	dupe_mode = COMPONENT_DUPE_UNIQUE

	/// type of baby the mother will plop out - needs to be subtype of /mob/living
	var/baby_type = /mob/living/carbon/human

	var/obj/item/organ/container

	var/datum/dna/father_dna

	var/stage = 0
	var/max_stage = PREGNANCY_STAGES
	COOLDOWN_DECLARE(stage_time)

	/// this stores the old belly size in case king ass ripper already had a huge, gluttonous belly
	var/old_belly_size = 0
	/// this boolean is for identifying whether this crime against nature is a live birth or oviposition
	var/oviposition = FALSE
	/// this boolean is for saving whether or not we should inflate the belly if appropriate
	var/pregnancy_inflation = TRUE
	/// whether the pregnancy is revealed or not, scanners will reveal this no matter what
	var/revealed = FALSE

/datum/component/pregnancy/Initialize(mob/living/_father, _baby_type, obj/item/organ/container_organ, _oviposition, _pregnancy_inflation)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	var/mob/living/preggo = parent
	if(preggo.stat >= DEAD)
		return COMPONENT_INCOMPATIBLE

	if(ispath(_baby_type, /mob/living))
		baby_type = _baby_type
	else
		stack_trace("Invalid baby_type given to pregnancy component!")
		return COMPONENT_INCOMPATIBLE

	if(iscarbon(_father))
		var/mob/living/carbon/carbo = _father
		father_dna = new
		carbo.dna.copy_dna(father_dna)

	oviposition = oviposition
	pregnancy_inflation = _pregnancy_inflation

	if(container_organ)
		container = container_organ

	if(ishuman(parent))
		human_pragency_start(parent)

	ADD_TRAIT(parent, TRAIT_PREGNANT, PREGNANCY_TRAIT)

/datum/component/pregnancy/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_MOB_DEATH, .proc/fetus_mortus)
	RegisterSignal(parent, COMSIG_LIVING_BIOLOGICAL_LIFE, .proc/handle_life)
	RegisterSignal(parent, COMSIG_HEALTH_SCAN, .proc/on_scan)
	RegisterSignal(parent, COMSIG_MOB_APPLY_DAMAGE, .proc/handle_damage)
	if(container)
		RegisterSignal(container, COMSIG_ORGAN_REMOVED, .proc/fetus_mortus)


/datum/component/pregnancy/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_MOB_DEATH)
	UnregisterSignal(parent, COMSIG_LIVING_BIOLOGICAL_LIFE)
	UnregisterSignal(parent, COMSIG_HEALTH_SCAN)
	UnregisterSignal(parent, COMSIG_MOB_APPLY_DAMAGE)
	if(container)
		UnregisterSignal(container, COMSIG_ORGAN_REMOVED)

/datum/component/pregnancy/Destroy()
	REMOVE_TRAIT(parent, TRAIT_PREGNANT, PREGNANCY_TRAIT)
	var/mob/living/preggo = parent
	preggo.remove_status_effect(/datum/status_effect/pregnancy)
	if(ishuman(parent))
		human_pragency_end(parent)
	return ..()

/datum/component/pregnancy/proc/handle_life(seconds)
	SIGNAL_HANDLER

	if(ishuman(parent))
		handle_belly_stuff(parent)

	if(oviposition)
		handle_ovi_preg()
	else
		handle_preg()

	if((stage > (max_stage / 2)) && !revealed)
		revealed = TRUE
		var/mob/living/preggo = parent
		preggo.apply_status_effect(/datum/status_effect/pregnancy)

	if(COOLDOWN_FINISHED(src, stage_time))
		COOLDOWN_START(src, stage_time, PREGNANCY_STAGE_DURATION)
		stage += 1
		stage = min(stage, max_stage)

/datum/component/pregnancy/proc/handle_belly_stuff(mob/living/carbon/human/gregnant)
	if(!(stage > (max_stage / 2)))
		return
	var/obj/item/organ/genital/belly/belly = gregnant.getorganslot(ORGAN_SLOT_BELLY)
	if(belly && pregnancy_inflation)
		switch(stage)
			if(2)
				belly.size = max(belly.size, 2)
			if(3)
				belly.size = max(belly.size, 3)
			if(4)
				belly.size = max(belly.size, 4)
		belly.update()

/datum/component/pregnancy/proc/handle_preg()
	var/mob/living/preggo = parent

	if(prob(10))
		switch(stage)
			if(2)
				to_chat(preggo, span_warning("You can feel your belly getting bigger!"))
			if(3)
				if(prob(50))
					to_chat(preggo, span_warning("Oh! The kicking in my belly is getting a bit more intense!"))
				else
					to_chat(preggo, span_warning("The kicking is quite intense now!"))
				preggo.adjustStaminaLoss(20)
			if(4)
				to_chat(preggo, span_warning("You feel like you're going into labor very soon! Get ready to give birth!"))
				preggo.adjustStaminaLoss(50)

	if(prob(60))
		return
	if(stage < max_stage)
		return

	if(prob(50))
		to_chat(preggo, span_warning("You're going into labor <b>right now!</b>"))
		preggo.adjustStaminaLoss(30)
	else
		to_chat(preggo, span_userdanger("It hurts! The baby is coming out!"))
		preggo.adjustStaminaLoss(50)
		preggo.emote("scream")
	preggo.adjustStaminaLoss(5)

	var/can_birth = TRUE
	if(ishuman(preggo))
		var/mob/living/carbon/human/human_owner =preggo
		var/obj/item/bodypart/chest = human_owner.get_bodypart(BODY_ZONE_CHEST)
		if(LAZYLEN(human_owner.clothingonpart(chest)))
			can_birth = FALSE
	if(can_birth)
		playsound(parent, 'sound/effects/splat.ogg', 70, TRUE)
		to_chat(preggo, span_nicegreen("The baby came out!"))
		var/mob/living/babby = new baby_type(get_turf(preggo))
		if(ishuman(babby))
			determine_baby_dna(babby)
		INVOKE_ASYNC(src, .proc/offer_control_to_babby, babby, preggo)
		qdel(src)

/datum/component/pregnancy/proc/handle_ovi_preg()
	if(stage < (max_stage / 2))
		if(stage == 2 && prob(3))
			to_chat(parent, span_notice("You feel something pressing lightly inside"))
		return
	var/mob/living/preggo = parent
	if(prob(50))
		to_chat(preggo, span_warning("Something presses hard against your anus! It's probably your egg!"))
		preggo.adjustStaminaLoss(30)
	else
		to_chat(preggo, span_warning("You REALLY need to get this egg out!"))
		preggo.adjustStaminaLoss(50)
		preggo.emote("scream")

	var/can_oviposit = TRUE
	if(ishuman(parent))
		var/mob/living/carbon/human/human_owner =parent
		var/obj/item/bodypart/chest = human_owner.get_bodypart(BODY_ZONE_CHEST)
		if(LAZYLEN(human_owner.clothingonpart(chest)))
			can_oviposit = FALSE
	if(can_oviposit)
		playsound(parent, 'sound/effects/splat.ogg', 70, TRUE)
		new /obj/item/reagent_containers/food/snacks/egg/oviposition(get_turf(preggo), src)
		to_chat(parent, span_nicegreen("The egg came out!"))
		qdel(src)

//not how genetics work but okay
/datum/component/pregnancy/proc/determine_baby_dna(mob/living/carbon/human/babby)
	var/mob/living/carbon/mommy = parent
	var/datum/dna/mother_dna = mommy?.dna
	if(mother_dna && father_dna)
		if(prob(50))
			mother_dna.transfer_identity(babby)
		else
			father_dna.transfer_identity(babby)
	else if(mother_dna && !father_dna)
		mother_dna.transfer_identity(babby)
	else if(!mother_dna && father_dna)
		father_dna.transfer_identity(babby)
	else
		var/datum/dna/rando = new
		rando.initialize_dna(random_blood_type())
		rando.transfer_identity(babby)

/datum/component/pregnancy/proc/human_pragency_start(mob/living/carbon/human/gregnant)
	if(gregnant.client?.prefs)
		oviposition = gregnant.client.prefs.oviposition
		pregnancy_inflation = gregnant.client.prefs.pregnancy_inflation
	if(pregnancy_inflation)
		//give them a king ass ripper belly initially
		var/obj/item/organ/genital/belly/belly = gregnant.getorganslot(ORGAN_SLOT_BELLY)
		if(!belly)
			belly = gregnant.give_genital(/obj/item/organ/genital/belly)
		else
			old_belly_size = belly.size
		belly.size = max(belly.size, 1)
		belly.update()
	return TRUE

/datum/component/pregnancy/proc/human_pragency_end(mob/living/carbon/human/gregnant)
	//get rid of king ass ripper belly
	var/obj/item/organ/genital/belly/belly = gregnant.getorganslot(ORGAN_SLOT_BELLY)
	if(belly && pregnancy_inflation)
		belly.size = 1
		belly.update()

/datum/component/pregnancy/proc/fetus_mortus()
	SIGNAL_HANDLER

	var/mob/living/preggo = parent
	if(!QDELETED(parent) && get_turf(preggo) && (stage > (max_stage / 2)))
		if(!oviposition)
			new /obj/effect/gibspawner/generic(get_turf(preggo))
		else
			new /obj/effect/decal/cleanable/egg_smudge(get_turf(preggo))
	preggo.visible_message(span_danger("[parent] has a miscarriage!"), \
						span_userdanger("Oh no! My baby is dead!"))
	qdel(src)

/datum/component/pregnancy/proc/on_scan(datum/source, mob/user)
	SIGNAL_HANDLER

	to_chat(user, span_notice("<b>Pregnancy detected!</b>"))

//drop kicked
/datum/component/pregnancy/proc/handle_damage(datum/source, damage, damagetype, def_zone)
	SIGNAL_HANDLER

	if(def_zone == BODY_ZONE_CHEST && damage > 25 && prob(40))
		fetus_mortus()

/datum/component/pregnancy/proc/offer_control_to_babby(mob/living/babby, mob/living/mommy)
	var/poll_message = "Do you want to play as [mommy]'s offspring?"
	var/list/mob/candidates = pollCandidatesForMob(poll_message, ROLE_RESPAWN, null, FALSE, 120, babby)
	if(!LAZYLEN(candidates))
		babby.real_name = random_unique_name(babby.gender, FALSE)
		babby.update_name()
		return

	var/mob/player = pick(candidates)
	player.transfer_ckey(babby, TRUE)
	var/mommy_name = "someone"
	if(!QDELETED(mommy))
		mommy_name = mommy.real_name

	to_chat(babby, "You are the son (or daughter) of [mommy_name]!")
	var/time = world.time
	var/name = input(babby, "What will be your name? (You have a minute to decide!)", "Name yourself") as null|text
	if(world.time - time >= 1 MINUTES)
		to_chat(babby, "You took too long to decide a name and have been given a random name instead.")
	if(!name || (world.time - time >= 1 MINUTES))
		babby.real_name = random_unique_name(babby.gender, FALSE)
		babby.update_name()
	else
		babby.real_name = name
		babby.update_name()
