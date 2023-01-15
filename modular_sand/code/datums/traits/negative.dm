/datum/quirk/sheltered
	name = "Sheltered"
	desc = "You never learned galactic common."
	value = 0
	mob_trait = TRAIT_SHELTERED
	gain_text = span_danger("You do not understand galactic common.")
	lose_text = span_notice("You start to put together what people are saying in galactic common.")
	medical_record_text = "Patient looks perplexed when questioned in galactic common."

/datum/quirk/sheltered/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.remove_language(/datum/language/common)
// You can pick languages for your character, if you don't pick anything, enjoy the rest of the round understanding nothing.

/datum/quirk/sheltered/remove() //i mean, the lose text explains it, so i'm making it actually work
	var/mob/living/carbon/human/H = quirk_holder
	H.grant_language(/datum/language/common)
