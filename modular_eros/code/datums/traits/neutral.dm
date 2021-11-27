// HYPERSTATION TRAITS

/datum/quirk/choke_slut
	name = "Choke Slut"
	desc = "You are aroused by suffocation."
	value = 0
	mob_trait = TRAIT_CHOKE_SLUT
	gain_text = "<span class='notice'>You feel like you want to feel fingers around your neck, choking you until you pass out or make a mess... Maybe both.</span>"
	lose_text = "<span class='notice'>Seems you don't have a kink for suffocation anymore.</span>"

/datum/quirk/pharmacokinesis //Supposed to prevent unwanted organ additions. But i don't think it's really working rn
	name = "Acute hepatic pharmacokinesis" //copypasting dumbo
	desc = "You have a rare genetic disorder that causes Incubus draft and Succubus milk to be absorbed by your liver instead."
	value = 0
	mob_trait = TRAIT_PHARMA
	lose_text = "<span class='notice'>Your liver feels different.</span>"
	var/active = FALSE
	var/power = 0
	var/cachedmoveCalc = 1

/datum/quirk/steel_ass
	name = "Buns of Steel"
	desc = "You've never skipped ass day. You are completely immune to all forms of ass slapping and anyone who tries to slap your rock hard ass usually gets a broken hand."
	value = 0
	mob_trait = TRAIT_STEEL_ASS
	gain_text = "<span class='notice'>Your ass rivals those of golems.</span>"
	lose_text = "<span class='notice'>Your butt feels more squishy and slappable.</span>"
