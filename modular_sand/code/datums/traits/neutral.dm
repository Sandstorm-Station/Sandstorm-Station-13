/datum/quirk/hypnotic_stupor //straight from skyrat
	name = "Hypnotic Stupor"
	desc = "Your prone to episodes of extreme stupor that leaves you extremely suggestible."
	value = 0
	human_only = TRUE
	gain_text = null // Handled by trauma.
	lose_text = null
	medical_record_text = "Patient has an untreatable condition with their brain, wiring them to be extreamly suggestible..."

/datum/quirk/hypnotic_stupor/add()
	var/datum/brain_trauma/severe/hypnotic_stupor/T = new()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(T, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/infertile
	name = "Infertile"
	desc = "For one reason or another you simply don't seem able to get pregnant, no matter how hard you try."
	value = 0
	human_only = TRUE
	mob_trait = TRAIT_INFERTILE
	gain_text = span_notice("Your womb starts feeling dry and empty, all the life in it begins to fade away...")
	lose_text = span_love("You feel the warm blow of life flooding your womb, full of newfound, vibrant fertility!")
	medical_record_text = "Patient doesn't seem able to ovulate properly..."

/datum/quirk/estrous_detection
	name = "Estrous Detection"
	desc = "You have a mammalian sense of detecting if someone\'s body longs for breeding."
	value = 0
	mob_trait = TRAIT_ESTROUS_DETECT
	gain_text = span_love("Your senses adjust, allowing a mammalian sense of others' fertility.")
	lose_text = span_notice("Your sense of others' fertility fades.")

/datum/quirk/estrous_active
	name = "In Estrous"
	desc = "Your system burns with the desire to be bred. Satisfying your lust will make you happy, while ignoring it may cause you to become sad and needy."
	value = 0
	mob_trait = TRAIT_ESTROUS_ACTIVE
	gain_text = span_love("You body burns with the desire to engage in breeding.")
	lose_text = span_notice("You feel more in control of your body and thoughts.")

	// Default heat message for examine text
	var/heat_type = "influenced by the estrous cycle"

	// Type of interaction to be performed
	// Intended for use with downstream quirks
	var/positional_orientation = "engage in breeding"

/datum/quirk/estrous_active/add()
	// Add examine hook
	RegisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE, .proc/quirk_examine_estrous_active)

	// Add organ change hooks
	RegisterSignal(quirk_holder, COMSIG_MOB_ORGAN_ADD, .proc/update_heat_type)
	RegisterSignal(quirk_holder, COMSIG_MOB_ORGAN_REMOVE, .proc/update_heat_type)

/datum/quirk/estrous_active/remove()
	// Remove examine hook
	UnregisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE)

	// Remove organ change hooks
	UnregisterSignal(quirk_holder, COMSIG_MOB_ORGAN_ADD, .proc/update_heat_type)
	UnregisterSignal(quirk_holder, COMSIG_MOB_ORGAN_REMOVE, .proc/update_heat_type)

/datum/quirk/estrous_active/post_add()
	// Update text used by message
	update_heat_type()

/datum/quirk/estrous_active/proc/update_heat_type()
	// Check for male reproductive organs
	var/breed_male = quirk_holder.has_balls()

	// Define possible womb
	var/obj/item/organ/genital/womb/organ_womb = quirk_holder.getorganslot(ORGAN_SLOT_WOMB)

	// Check for female reproductive organs
	var/breed_female = (quirk_holder.has_vagina() && istype(organ_womb))

	// Set variable for both reproductive types
	if(breed_male && breed_female)
		heat_type = "in both estrous and rut"

	// Set variable for male-only
	else if(breed_male)
		heat_type = "in rut"

	// Set variable for female-only
	else if(breed_female)
		heat_type = "in estrous"

	// Set variable for none
	else
		positional_orientation = "engage in breeding"

/datum/quirk/estrous_active/proc/quirk_examine_estrous_active(atom/examine_target, mob/living/carbon/human/examiner, list/examine_list)
	SIGNAL_HANDLER

	// Check if human examiner exists
	if(!istype(examiner))
		return

	// Check if examiner lacks the trait, or is self examining
	if(!HAS_TRAIT(examiner, TRAIT_ESTROUS_DETECT) || (examiner == quirk_holder))
		return

	// Add quirk message
	examine_list += span_love("[quirk_holder.p_they(TRUE)] [quirk_holder.p_are()] currently [heat_type], and longs to [positional_orientation].")
