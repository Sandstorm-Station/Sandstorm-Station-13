//SPLURT drinks

/datum/reagent/consumable/ethanol/panty_dropper
	name = "Liquid Panty Dropper"
	description = "You feel it's not named like that for nothing."
	color = "#ce3b01" // rgb: 206, 59, 1
	boozepwr = 70
	quality = DRINK_VERYGOOD
	taste_description = "cloth ripping and tearing"
	glass_name = "Liquid Panty Dropper"
	glass_desc = "You feel it's not named like that for no reason."
	value = 6

/datum/reagent/consumable/ethanol/panty_dropper/on_mob_life(mob/living/carbon/C)
	var/mob/living/carbon/human/M = C
	var/anyclothes = FALSE
	var/items = M.get_contents()
	for(var/obj/item/W in items)
		if(W.body_parts_covered && ismob(W.loc))
			anyclothes = TRUE
			M.dropItemToGround(W, TRUE)
			playsound(M.loc, 'sound/items/poster_ripped.ogg', 50, 1)
	if(anyclothes)
		M.visible_message("<span class='userlove'>[M] suddenly bursts out of [M.p_their()] clothes!</span>")
	return ..()

/datum/reagent/consumable/ethanol/lean
	name = "Lean"
	description = "The choice drink of space-pop stars, composed of soda, cough syrup and candies."
	color =  "#9109ba"
	boozepwr = 0
	metabolization_rate = 1 * REAGENTS_METABOLISM
	quality = DRINK_VERYGOOD
	taste_description = "cough syrup and space-pop music"
	glass_name = "Lean"
	glass_desc = "I LOVE LEAN!!"
	glass_icon_state = "lean" // the icon is not in the modular folder because it's literally impossible to get an icon from the modular folder unless it's an actual obj and not a drink. Go **** yourself.

/datum/reagent/consumable/ethanol/lean/on_mob_life(mob/living/carbon/C)
	var/mob/living/carbon/human/M = C
	var/message = "I LOVE LEAN!!"
	M.Dizzy(40)
	M.Jitter(40)
	M.set_drugginess(50)
	switch(current_cycle)
		if(1)
			M.say(message)
		if(80 to 100)
			M.adjustOrganLoss(ORGAN_SLOT_LIVER, 1)
			M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1) // it's cough syrup what'd you expect?
		if(100 to INFINITY)
			M.adjustOrganLoss(ORGAN_SLOT_LIVER, 2)
			M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2)
			if(!M.undergoing_cardiac_arrest() && M.can_heartattack() && prob(1))
				M.set_heartattack(TRUE)
				if(M.stat == CONSCIOUS)
					M.visible_message("<span class='userdanger'>[M] clutches at [M.p_their()] chest as if [M.p_their()] heart stopped!</span>") // too much lean :(
	..()

/datum/reagent/consumable/ethanol/cum_in_a_hot_tub
	name = "Cum in the Hot Tub"
	description = "Doesn't really leave it to the imagination, eh?"
	boozepwr = 80
	color = "#D2D7D9"
	quality = DRINK_VERYGOOD
	taste_description = "smooth cream"
	glass_icon_state = "cum_glass"
	shot_glass_icon_state = "cum_shot"	//I'm funny, I know
	glass_name = "Cum in the Hot Tub"
	glass_desc = "Doesn't really leave it to the imagination, eh?"

/datum/reagent/consumable/ethanol/cum_in_a_hot_tub/semen
	boozepwr = 65
	taste_description = "viscous cream"
	description = "The name is probably exactly what it is."
	glass_desc = "The name is probably exactly what it is."

/datum/reagent/consumable/ethanol/mech_rider
	name = "Mech Rider"
	description = "Who would even drink this? "
	boozepwr = 65
	color = rgb(111, 127, 63)
	quality = DRINK_GOOD
	taste_description = "the sweat of a certain Mauler pilot"
	glass_icon = 'modular_splurt/icons/obj/drinks.dmi'
	glass_icon_state = "mech_rider_bottle"
	glass_name = "Mech Rider"
	glass_desc = "Who would even drink this?"

/datum/reagent/consumable/ethanol/isloation_cell
	name = "Isolation Cell"
	description = "Ice cubes in a padded Cell."
	color = "#b4b4b4"
	quality = DRINK_FANTASTIC
	taste_description = "cloth dissolved in sulphuric acid."
	glass_icon = 'modular_splurt/icons/obj/drinks.dmi'
	glass_icon_state = "isolationcell"
	glass_name = "Isolation Cell"
	glass_desc = "Ice cubes in a padded Cell"


/datum/reagent/consumable/ethanol/isloation_cell/on_mob_life(mob/living/carbon/C)
	. = ..()
	C.reagents.add_reagent_list(list(/datum/reagent/drug/aphrodisiac = 1, /datum/reagent/medicine/morphine = 1))

/datum/reagent/consumable/ethanol/chemical_ex
	name = "Chemical Ex"
	description = "Date rape in a glass, a mixture courtesy of the Chief Witchdoctor. The stench of cigar smoke permeates the air wherever it goes."
	color = rgb(14, 14, 14)
	quality = DRINK_FANTASTIC
	taste_description = "ghost peppers, carbonated water and oil. Burns your tongue."
	glass_icon = 'modular_splurt/icons/obj/drinks.dmi'
	glass_icon_state = "chemicalex"
	glass_name = "Chemical Ex"
	glass_desc = "Date rape in a glass, a mixture courtesy of the Chief Witchdoctor. The stench of cigar smoke permeates the air wherever it goes."

/datum/reagent/consumable/ethanol/chemical_ex/on_mob_life(mob/living/carbon/C)
	. = ..()
	C.reagents.add_reagent_list(list(/datum/reagent/drug/aphrodisiacplus = 1, /datum/reagent/medicine/morphine = 1, /datum/reagent/fermi/enthrall = 1))

/datum/reagent/consumable/ethanol/heart_of_gold
	name = "Heart Of Gold"
	description = "The Captain's Ambrosia. Something about it just feels divine."
	boozepwr = 15
	color = "#fc56e6"
	quality = DRINK_FANTASTIC
	taste_description = "a fruit punch-like blend with a little fruity kick at the back of your throat, with an aftertaste of pineapple."
	glass_icon = 'modular_splurt/icons/obj/drinks.dmi'
	glass_icon_state = "heartofgold"
	glass_name = "Heart Of Gold"
	glass_desc = "The Captain's Ambrosia. Something about it just feels divine."

/datum/reagent/consumable/ethanol/moth_in_chief
	name = "Moth in Chief"
	description = "A simole yet elegant drink, inspires confidence in even the most pessimistic of men. The mantle rests well upon your shoulders."
	boozepwr = 50
	color = "#0919be"
	quality = DRINK_FANTASTIC
	taste_description = "fuzz, warmth and comfort"
	glass_icon = 'modular_splurt/icons/obj/drinks.dmi'
	glass_icon_state = "mothinchief"
	glass_name = "Moth in Chief"
	glass_desc = "A simole yet elegant drink, inspires confidence in even the most pessimistic of men. The mantle rests well upon your shoulders."
