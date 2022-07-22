/datum/component/pregnancy

	dupe_mode = COMPONENT_DUPE_ALLOWED
	can_transfer = TRUE

	/// type of baby the mother will plop out - needs to be subtype of /mob/living
	var/baby_type = /mob/living/carbon/human

	var/obj/item/organ/container
	var/mob/living/carrier

	var/datum/dna/father_dna
	var/datum/dna/mother_dna

	var/list/mother_features
	var/list/father_features

	var/egg_name

	var/stage = 0
	var/max_stage = PREGNANCY_STAGES
	COOLDOWN_DECLARE(stage_time)

	var/added_size = 0
	/// this boolean is for identifying whether this preg is in the egg state or not
	var/oviposition = TRUE
	/// this boolean is for saving whether or not we should inflate the belly if appropriate
	var/pregnancy_inflation = TRUE
	/// breast growth
	var/pregnancy_breast_growth = TRUE
	/// whether the pregnancy is revealed or not, scanners will reveal this no matter what
	var/revealed = FALSE

/datum/component/pregnancy/Initialize(mob/living/_father, _baby_type = /mob/living/carbon/human, obj/item/organ/container_organ)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	var/mob/living/gregnant = parent

	//don't fuck dead bodies, pretty please
	if(gregnant.stat >= DEAD)
		return COMPONENT_INCOMPATIBLE

	if(ispath(_baby_type, /mob/living))
		baby_type = _baby_type
	else
		stack_trace("Invalid baby_type given to pregnancy component!")
		return COMPONENT_INCOMPATIBLE

	if(iscarbon(_father))
		var/mob/living/carbon/cardad = _father
		father_dna = new
		cardad.dna.copy_dna(father_dna)

	if(iscarbon(parent))
		var/mob/living/carbon/carmom = parent
		mother_dna = new
		carmom.dna.copy_dna(mother_dna)

	if(ishuman(_father))
		var/mob/living/carbon/human/cardad = _father
		LAZYINITLIST(father_features)
		father_features["skin_tone"] = cardad.skin_tone
		father_features["hair_color"] = cardad.hair_color
		father_features["facial_hair_color"] = cardad.facial_hair_color
		father_features["left_eye_color"] = cardad.left_eye_color
		father_features["right_eye_color"] = cardad.right_eye_color

	if(ishuman(parent))
		var/mob/living/carbon/human/carmom = parent
		LAZYINITLIST(mother_features)
		mother_features["skin_tone"] = carmom.skin_tone
		mother_features["hair_color"] = carmom.hair_color
		mother_features["facial_hair_color"] = carmom.facial_hair_color
		mother_features["left_eye_color"] = carmom.left_eye_color
		mother_features["right_eye_color"] = carmom.right_eye_color

	pregnancy_inflation = gregnant.client?.prefs?.pregnancy_inflation

	pregnancy_breast_growth = gregnant.client?.prefs?.pregnancy_breast_growth

	if(container_organ)
		container = container_organ

	carrier = parent

	if(ishuman(parent))
		human_pragency_start(parent)
	ADD_TRAIT(parent, TRAIT_PREGNANT, PREGNANCY_TRAIT)

/datum/component/pregnancy/RegisterWithParent()
	if(carrier)
		register_carrier()
	if(isitem(parent))
		RegisterSignal(parent, COMSIG_ATOM_ENTERING, .proc/on_entering)
		RegisterSignal(parent, COMSIG_OBJ_BREAK, .proc/on_obj_break)
		RegisterSignal(parent, COMSIG_OBJ_WRITTEN_ON, .proc/name_egg)
		RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, .proc/hatch)
		RegisterSignal(parent, COMSIG_PARENT_EXAMINE, .proc/eg_status)

/datum/component/pregnancy/UnregisterFromParent()
	if(carrier)
		unregister_carrier()
	UnregisterSignal(parent, COMSIG_ATOM_ENTERING)
	UnregisterSignal(parent, COMSIG_OBJ_BREAK)
	UnregisterSignal(parent, COMSIG_OBJ_WRITTEN_ON)
	UnregisterSignal(parent, COMSIG_PARENT_ATTACKBY)
	UnregisterSignal(parent, COMSIG_PARENT_EXAMINE)

/datum/component/pregnancy/proc/register_carrier()
	RegisterSignal(carrier, COMSIG_MOB_DEATH, .proc/fetus_mortus)
	RegisterSignal(carrier, COMSIG_LIVING_BIOLOGICAL_LIFE, .proc/handle_life)
	RegisterSignal(carrier, COMSIG_HEALTH_SCAN, .proc/on_scan)
	RegisterSignal(carrier, COMSIG_MOB_APPLY_DAMAGE, .proc/handle_damage)
	if(container)
		RegisterSignal(container, COMSIG_ORGAN_REMOVED, .proc/fetus_mortus)
	if(oviposition)
		RegisterSignal(carrier, COMSIG_MOB_CLIMAX, .proc/on_climax)

/datum/component/pregnancy/proc/unregister_carrier()
	UnregisterSignal(carrier, COMSIG_MOB_DEATH)
	UnregisterSignal(carrier, COMSIG_LIVING_BIOLOGICAL_LIFE)
	UnregisterSignal(carrier, COMSIG_HEALTH_SCAN)
	UnregisterSignal(carrier, COMSIG_MOB_APPLY_DAMAGE)
	UnregisterSignal(carrier, COMSIG_MOB_CLIMAX)
	if(container)
		UnregisterSignal(container, COMSIG_ORGAN_REMOVED)

/datum/component/pregnancy/Destroy()
	if(carrier)
		generic_pragency_end()
	return ..()

/datum/component/pregnancy/PreTransfer()
	if(carrier)
		generic_pragency_end()
	oviposition = FALSE

/datum/component/pregnancy/PostTransfer()
	carrier = null
	container = null
	egg_name = null

	if(isliving(parent))
		carrier = parent
	else if(isitem(parent))
		max_stage += 1
	else
		return COMPONENT_INCOMPATIBLE

/datum/component/pregnancy/proc/name_egg(datum/source, name)
	SIGNAL_HANDLER

	egg_name = name

/datum/component/pregnancy/proc/on_climax(datum/source, atom/target, obj/item/organ/genital/sender, obj/item/organ/genital/receiver, spill)
	SIGNAL_HANDLER

	if(stage < 2)
		return FALSE

	to_chat(carrier, span_userlove("You feel your egg sliding out slowly inside!"))

	if(receiver && isliving(target))
		if(CHECK_BITFIELD(receiver.genital_flags, GENITAL_CAN_STUFF))
			return lay_eg(receiver)
	return lay_eg(get_turf(carrier))

/datum/component/pregnancy/proc/on_obj_break(datum/source, damage_flag)
	SIGNAL_HANDLER

	qdel(src)

/datum/component/pregnancy/proc/on_entering(datum/source, atom/destination, atom/oldLoc)
	SIGNAL_HANDLER

	if(istype(destination, /obj/item/organ))
		var/obj/item/organ/preg_container = destination
		//severed wombs don't count, boyos
		if(!preg_container.owner)
			return
		carrier = preg_container.owner
		container = preg_container
		pregnancy_inflation = carrier.client?.prefs?.pregnancy_inflation
		pregnancy_breast_growth = carrier.client?.prefs?.pregnancy_breast_growth
		register_carrier()
		generic_pragency_start()
	else if(carrier)
		generic_pragency_end()
		unregister_carrier()
		carrier = null
		container = null

/datum/component/pregnancy/proc/handle_life(seconds)
	SIGNAL_HANDLER

	if(oviposition)
		handle_ovi_preg()
	else
		handle_incubation()

	if((stage >= 2) && !revealed)
		revealed = TRUE
		carrier.apply_status_effect(/datum/status_effect/pregnancy)

	if(stage > 3 && ishuman(carrier) && oviposition)
		SEND_SIGNAL(carrier, COMSIG_ADD_MOOD_EVENT, "pregnancy", /datum/mood_event/pregnant_negative)

	if(COOLDOWN_FINISHED(src, stage_time))
		stage += 1
		stage = min(stage, max_stage)
		if(ishuman(carrier) && stage >= 2 && (pregnancy_inflation || pregnancy_breast_growth))
			handle_organ_inflation(carrier)
		COOLDOWN_START(src, stage_time, PREGNANCY_STAGE_DURATION)

/datum/component/pregnancy/proc/handle_organ_inflation(mob/living/carbon/human/gregnant)
	var/obj/item/organ/genital/belly/belly = gregnant.getorganslot(ORGAN_SLOT_BELLY)
	var/obj/item/organ/genital/breasts/boob = gregnant.getorganslot(ORGAN_SLOT_BREASTS)

	if(added_size < 4)
		added_size += 1
	else
		return
	if(pregnancy_inflation)
		belly?.modify_size(1)
	else if(pregnancy_breast_growth)
		boob?.modify_size(1)

/datum/component/pregnancy/proc/handle_incubation()
	if(carrier && (stage < max_stage) && prob(2))
		to_chat(carrier, span_warning("You feel \The [parent] moving a bit inside you!"))
	if(carrier && (stage == max_stage) && prob(2))
		to_chat(carrier, span_warning("\The [parent] moves, it's probably ready to hatch!"))

/datum/component/pregnancy/proc/hatch(datum/source, obj/item/I, mob/user, params)
	SIGNAL_HANDLER

	if(stage < max_stage)
		return

	playsound(parent, 'sound/effects/splat.ogg', 70, TRUE)
	var/mob/living/babby = new baby_type(get_turf(parent))
	if(ishuman(babby))
		determine_baby_features(babby)
		determine_baby_dna(babby)
	INVOKE_ASYNC(GLOBAL_PROC, .proc/offer_control_to_babby, babby, user, egg_name)
	var/obj/item = parent
	item.forceMove(get_turf(parent))
	item.obj_break(MELEE)
	qdel(src)

/datum/component/pregnancy/proc/eg_status(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(stage >= max_stage)
		examine_list += span_notice("\The [parent] seems ready to hatch! You can tap it with something to hatch it")

///datum/component/pregnancy/proc/handle_preg()
//
//	if(prob(60))
//		return
//	if(stage < max_stage)
//		return
//
//	if(prob(50))
//		to_chat(carrier, span_warning("Something is moving inside you!"))
//	else
//		to_chat(carrier, span_userdanger("It hurts! Something is trying to come out!"))
//
//	carrier.emote("scream")
//
//	var/can_birth = TRUE
//	if(ishuman(carrier))
//		var/mob/living/carbon/human/human_owner = carrier
//		var/obj/item/bodypart/chest = human_owner.get_bodypart(BODY_ZONE_CHEST)
//		if(LAZYLEN(human_owner.clothingonpart(chest)))
//			can_birth = FALSE
//	if(can_birth)
//		playsound(carrier, 'sound/effects/splat.ogg', 70, TRUE)
//		to_chat(carrier, span_nicegreen("The egg hatched!"))
//		carrier.Knockdown(200, TRUE, TRUE)
//		carrier.Stun(200, TRUE, TRUE)
//		carrier.adjustStaminaLoss(200)
//		var/mob/living/babby = new baby_type(get_turf(carrier))
//		if(ishuman(babby))
//			determine_baby_dna(babby)
//		INVOKE_ASYNC(GLOBAL_PROC, .proc/offer_control_to_babby, babby, carrier, egg_name)
//		SEND_SIGNAL(carrier, COMSIG_ADD_MOOD_EVENT, "pregnancy_end", /datum/mood_event/pregnant_positive)
//		if(isitem(parent))
//			var/obj/item = parent
//			item.forceMove(get_turf(carrier))
//			item.obj_break(MELEE)
//		qdel(src)

/datum/component/pregnancy/proc/handle_ovi_preg()
	if(stage <= 2)
		if(stage == 2 && prob(2))
			to_chat(carrier, span_notice("You feel something pressing lightly inside"))
		return
	if(prob(10))
		if(prob(50))
			to_chat(carrier, span_warning("Something presses hard against your anus! It's probably your egg!"))
		else
			to_chat(carrier, span_warning("You REALLY need to get this egg out!"))
		carrier.emote("scream")
		carrier.adjustStaminaLoss(15)

	lay_eg(get_turf(carrier))

/datum/component/pregnancy/proc/lay_eg(atom/location)
	if(prob(60))
		return FALSE
	if(isorgan(location))
		var/obj/item/organ/recv = location
		if(!recv.owner)
			return FALSE

	if(container && isgenital(container))
		var/obj/item/organ/genital/gen = container
		if(!gen.is_exposed() && gen.linked_organ && !gen.linked_organ.is_exposed())
			return FALSE

	playsound(carrier, 'sound/effects/splat.ogg', 70, TRUE)
	carrier.Knockdown(200, TRUE, TRUE)
	carrier.Stun(200, TRUE, TRUE)
	carrier.adjustStaminaLoss(200)

	SEND_SIGNAL(carrier, COMSIG_ADD_MOOD_EVENT, "pregnancy_end", /datum/mood_event/pregnant_positive)

	var/obj/item/oviposition_egg/eggo = new(carrier)

	eggo.icon_state = carrier.client?.prefs?.egg_shell ? ("egg_" + carrier.client.prefs.egg_shell) : "egg_chicken"
	eggo.update_appearance()

	if(isorgan(location))
		var/obj/item/organ/recv = location
		carrier.visible_message(span_userlove("[carrier] laid an egg!"), \
			span_userlove("You laid an egg inside [recv.owner]'s [recv]"))
	else
		carrier.visible_message(span_notice("[carrier] laid an egg!"), \
			span_nicegreen("The egg came out!"))

	eggo.TakeComponent(src)
	eggo.forceMove(location)

	return TRUE

//not how genetics work but okay
/datum/component/pregnancy/proc/determine_baby_dna(mob/living/carbon/human/babby)
	if(mother_dna && father_dna)
		mother_dna.transfer_identity_random(father_dna, babby)
	else if(mother_dna && !father_dna)
		mother_dna.transfer_identity_random(babby.dna, babby)
	else if(!mother_dna && father_dna)
		father_dna.transfer_identity_random(babby.dna, babby)

/datum/component/pregnancy/proc/determine_baby_features(mob/living/carbon/human/babby)

	var/list/final_features = list()

	transfer_randomized_list(final_features, mother_features, father_features)

	if(final_features["skin_tone"])
		babby.skin_tone = final_features["skin_tone"]
	if(final_features["hair_color"])
		babby.hair_color = final_features["hair_color"]
	if(final_features["facial_hair_color"])
		babby.facial_hair_color = final_features["facial_hair_color"]
	if(final_features["left_eye_color"])
		babby.left_eye_color = final_features["left_eye_color"]
	if(final_features["right_eye_color"])
		babby.right_eye_color = final_features["right_eye_color"]

	babby.hair_style = pick("Bedhead", "Bedhead 2", "Bedhead 3")
	babby.facial_hair_style = "Shaved"
	babby.underwear = "Nude"
	babby.undershirt = "Nude"
	babby.socks = "Nude"

	babby.saved_underwear = babby.underwear
	babby.saved_undershirt = babby.undershirt
	babby.saved_socks = babby.socks

/datum/component/pregnancy/proc/generic_pragency_start()
	if(revealed)
		carrier.apply_status_effect(/datum/status_effect/pregnancy)
	if(ishuman(carrier))
		human_pragency_start(carrier)
	ADD_TRAIT(carrier, TRAIT_PREGNANT, PREGNANCY_TRAIT)

/datum/component/pregnancy/proc/generic_pragency_end()
	REMOVE_TRAIT(carrier, TRAIT_PREGNANT, PREGNANCY_TRAIT)
	carrier.remove_status_effect(/datum/status_effect/pregnancy)
	if(ishuman(carrier))
		human_pragency_end(carrier)

/datum/component/pregnancy/proc/human_pragency_start(mob/living/carbon/human/gregnant)
	if(pregnancy_inflation)
		//give them a king ass ripper belly initially
		var/obj/item/organ/genital/belly/belly = gregnant.getorganslot(ORGAN_SLOT_BELLY)
		if(!belly)
			belly = gregnant.give_genital(/obj/item/organ/genital/belly)
		if(added_size > 0)
			belly.modify_size(added_size)
	if(pregnancy_breast_growth)
		var/obj/item/organ/genital/breasts/boob = gregnant.getorganslot(ORGAN_SLOT_BREASTS)
		if(!boob)
			boob = gregnant.give_genital(/obj/item/organ/genital/breasts)
		if(added_size > 0)
			boob.modify_size(added_size)
	return TRUE

/datum/component/pregnancy/proc/human_pragency_end(mob/living/carbon/human/gregnant)
	//get rid of king ass ripper belly
	var/obj/item/organ/genital/belly/belly = gregnant.getorganslot(ORGAN_SLOT_BELLY)
	var/obj/item/organ/genital/breasts/boob = gregnant.getorganslot(ORGAN_SLOT_BREASTS)
	if(pregnancy_inflation)
		belly?.modify_size(-added_size)
	if(pregnancy_breast_growth)
		boob?.modify_size(-added_size)
	SEND_SIGNAL(gregnant, COMSIG_CLEAR_MOOD_EVENT, "pregnancy")

/datum/component/pregnancy/proc/fetus_mortus()
	SIGNAL_HANDLER

	if(!QDELETED(carrier) && get_turf(carrier) && (stage >= 2))
		if(!oviposition)
			new /obj/effect/gibspawner/generic(get_turf(carrier))
		else
			new /obj/effect/decal/cleanable/egg_smudge(get_turf(carrier))
	carrier.Knockdown(200, TRUE, TRUE)
	carrier.Stun(200, TRUE, TRUE)
	carrier.adjustStaminaLoss(200)
	carrier.visible_message(span_danger("[carrier] has a miscarriage!"), \
						span_userdanger("Oh no! My baby is dead!"))
	qdel(src)

/datum/component/pregnancy/proc/on_scan(datum/source, mob/user)
	SIGNAL_HANDLER

	if(isliving(parent))
		to_chat(user, span_notice("<b>Pregnancy detected!</b>"))

//drop kicked
/datum/component/pregnancy/proc/handle_damage(datum/source, damage, damagetype, def_zone)
	SIGNAL_HANDLER

	if(def_zone == BODY_ZONE_CHEST && damage > 20 && prob(40))
		fetus_mortus()

/proc/offer_control_to_babby(mob/living/babby, mob/living/mommy, pre_named)
	var/poll_message = "Do you want to play as [mommy]'s offspring?"
	var/list/mob/candidates = pollCandidatesForMob(poll_message, ROLE_RESPAWN, null, FALSE, 120, babby)
	if(!LAZYLEN(candidates))
		babby.real_name = random_unique_name(babby.gender)
		babby.update_name()
		return

	var/mob/player = pick(candidates)

	player.transfer_ckey(babby, TRUE)

	var/mommy_name = "someone"
	if(!QDELETED(mommy))
		mommy_name = mommy.real_name

	to_chat(babby, "You are the son (or daughter) of [mommy_name]!")

	var/name
	if(pre_named)
		name = pre_named
	else if(QDELETED(mommy))
		name = input(babby, "What will be your name?", "Name yourself") as null|text
	else
		name = input(mommy, "What will be your baby's name?", "Name the baby") as null|text

	if(!name)
		babby.real_name = random_unique_name(babby.gender, )
		babby.update_name()
	else
		babby.real_name = name
		babby.update_name()
