/datum/quirk/no_clone
	name = "DNC"
	desc = "You have filed a Do Not Clone order, stating that you do not wish to be cloned. You can still be revived by other means."
	value = -2
	mob_trait = TRAIT_NO_CLONE
	medical_record_text = "Patient has a DNC (Do not clone) order on file, and cannot be cloned as a result."

/datum/quirk/no_guns
	name = "Fat-Fingered"
	desc = "Due to the shape of your hands, width of your fingers or just not having fingers at all, you're unable to fire the majority of guns."
	value = -2
	mob_trait = TRAIT_NOGUNS
	gain_text = "<span class='notice'>Your fingers feel.. thick.</span>"
	lose_text = "<span class='notice'>Your fingers feel normal again.</span>"

/datum/quirk/illiterate
	name = "Illiterate"
	desc = "You can't read nor write, plain and simple."
	value = -1
	mob_trait = TRAIT_ILLITERATE
	gain_text = "<span class='notice'>The knowledge of how to read seems to escape from you.</span>"
	lose_text = "<span class='notice'>Written words suddenly make sense again."

/datum/quirk/flimsy
	name = "Flimsy"
	desc = "Your body is a little more fragile then most, decreasing total health by 20%."
	value = -2
	medical_record_text = "Patient has abnormally low capacity for injury."
	gain_text = "<span class='notice'>You feel like you could break with a single hit."
	lose_text = "<span class='notice'>You feel more durable."

/datum/quirk/flimsy/add()
	quirk_holder.maxHealth *= 0.8

/datum/quirk/flimsy/remove() //how do admins even remove traits?
	if(!quirk_holder)
		return
	quirk_holder.maxHealth *= 1.25
