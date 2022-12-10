// Modular-friendly way of adding new quirk-based inspect text
// Hijacks the function used for abductor examine
/mob/common_trait_examine()
	// Pronoun stuff
	var/t_He = p_they(TRUE)
	var/t_his = p_their()
	var/t_is = p_are()

	// Empathy abilities escape clause
	if(!(HAS_TRAIT(usr, TRAIT_EMPATH) || HAS_TRAIT(usr, TRAIT_FRIENDLY) || src == usr))
		return

	// Check for Distant (no touch head!)
	if(HAS_TRAIT(src, TRAIT_DISTANT))
		. += "<span class='warning'>[t_He] [t_is] emitting an aura of un-pattability from [t_his] head.</span>"
	// Check for Heatpat Slut (pls touch head!)
	if(HAS_TRAIT(src, TRAIT_HEADPAT_SLUT))
		. += "<span class='info'>[t_He] [t_is] emitting a weak memetic aura from [t_his] head that compels your hand to approach.</span>"
