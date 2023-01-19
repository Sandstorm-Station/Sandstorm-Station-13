// HYPERSTATION TRAITS

/datum/quirk/choke_slut
	name = "Choke Slut"
	desc = "You are aroused by suffocation."
	value = 0
	mob_trait = TRAIT_CHOKE_SLUT
	gain_text = span_notice("You feel like you want to feel fingers around your neck, choking you until you pass out or make a mess... Maybe both.")
	lose_text = span_notice("Seems you don't have a kink for suffocation anymore.")

/datum/quirk/pharmacokinesis //Supposed to prevent unwanted organ additions. But i don't think it's really working rn
	name = "Acute Hepatic Pharmacokinesis" //copypasting dumbo
	desc = "You have a genetic disorder that causes Incubus Draft and Succubus Milk to be absorbed by your liver instead."
	value = 0
	mob_trait = TRAIT_PHARMA
	lose_text = span_notice("Your liver feels... different, somehow.")
	var/active = FALSE
	var/power = 0
	var/cachedmoveCalc = 1

/datum/quirk/steel_ass
	name = "Buns of Steel"
	desc = "You've never skipped ass day. You are completely immune to all forms of ass slapping and anyone who tries to slap your rock hard ass usually gets a broken hand."
	value = 0
	mob_trait = TRAIT_STEEL_ASS
	gain_text = span_notice("Your ass rivals those of golems.")
	lose_text = span_notice("Your butt feels more squishy and slappable.")

/datum/quirk/cursed_blood
	name = "Cursed Blood"
	desc = "Your lineage is cursed with the paleblood curse. Best to stay away from holy water... Hell water, on the other hand..."
	value = 0
	mob_trait = TRAIT_CURSED_BLOOD
	gain_text = span_notice("A curse from a land where men return as beasts runs deep in your blood.")
	lose_text = span_notice("You feel the weight of the curse in your blood finally gone.")
	medical_record_text = "Patient suffers from an unknown type of aversion to holy reagents. Keep them away from a chaplain."

/datum/quirk/headpat_hater
	name = "Distant"
	desc = "You don't seem to show much care for being touched. Whether it's because you're reserved or due to self control, others touching your head won't make you wag your tail should you possess one, and the action may even attract your ire."
	mob_trait = TRAIT_DISTANT
	value = 0
	gain_text = span_notice("Others' touches begin to make your blood boil...")
	lose_text = span_notice("Having your head pet doesn't sound so bad right about now...")
	medical_record_text = "Patient cares little with or dislikes being touched."

/datum/quirk/headpat_slut
	name = "Headpat Slut"
	desc = "You love the feeling of others touching your head! Maybe a little too much, actually... Others patting your head will provide a bigger mood boost and cause aroused reactions."
	mob_trait = TRAIT_HEADPAT_SLUT
	value = 0
	gain_text = span_notice("You crave headpats immensely!")
	lose_text = span_notice("Your headpats addiction wanes.")
	medical_record_text = "Patient seems overly affectionate."

/datum/quirk/headpat_slut/add()
	. = ..()
	quirk_holder.AddElement(/datum/element/wuv/headpat, null, null, /datum/mood_event/pet_animal)

/datum/quirk/headpat_slut/remove()
	. = ..()
	quirk_holder.RemoveElement(/datum/element/wuv/headpat)

/datum/quirk/in_heat
	name = "In Heat"
	desc = "Your system burns with the desire to be bred. Satisfying your lust will make you happy, but ignoring it may cause you to become sad and needy."
	value = 0
	mob_trait = TRAIT_IN_HEAT
	gain_text = span_notice("You body burns with the desire to be bred.")
	lose_text = span_notice("You feel more in control of your body and thoughts.")

/datum/quirk/Hypnotic_gaze
	name = "Hypnotic Gaze"
	desc = "Be it through mysterious patterns, flickering colors, or some genetic oddity, prolonged eye contact with you will place the viewer into a highly-suggestible hypnotic trance."
	value = 0
	mob_trait = TRAIT_HYPNOTIC_GAZE
	gain_text = span_notice("Your eyes glimmer hypnotically...")
	lose_text = span_notice("Your eyes return to normal.")
	medical_record_text = "Prolonged exposure to Patient's eyes exhibits soporific effects."

/datum/quirk/Hypnotic_gaze/on_spawn()
	var/mob/living/carbon/human/Hypno_eyes = quirk_holder
	var/datum/action/innate/Hypnotize/spell = new
	spell.Grant(Hypno_eyes)
	spell.owner = Hypno_eyes

/datum/quirk/heat
	name = "Estrus Detection"
	desc = "You have a animalistic sense of detecting if someone is in heat."
	value = 0
	mob_trait = TRAIT_HEAT_DETECT
	gain_text = span_notice("You feel your senses adjust, allowing a animalistic sense of others' fertility.")
	lose_text = span_notice("You feel your sense of others' fertility fade.")

/datum/quirk/overweight
	name = "Overweight"
	desc = "You're particularly fond of food, and join the shift being overweight."
	value = 0
	gain_text = span_notice("You feel a bit chubby!")
	//no lose_text cause why would there be?

/datum/quirk/overweight/on_spawn()
	var/mob/living/M = quirk_holder
	M.nutrition = rand(NUTRITION_LEVEL_FAT + NUTRITION_LEVEL_START_MIN, NUTRITION_LEVEL_FAT + NUTRITION_LEVEL_START_MAX)
	M.overeatduration = 100
	ADD_TRAIT(M, TRAIT_FAT, OBESITY)

/datum/quirk/vegetarian
	name = "Vegetarian"
	desc = "You find the idea of eating meat morally and physically repulsive."
	value = 0
	gain_text = span_notice("You feel repulsion at the idea of eating meat.")
	lose_text = span_notice("You feel like eating meat isn't that bad.")
	medical_record_text = "Patient reports a vegetarian diet."

/datum/quirk/vegetarian/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.liked_food &= ~MEAT
	species.disliked_food |= MEAT

/datum/quirk/vegetarian/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		if(initial(species.liked_food) & MEAT)
			species.liked_food |= MEAT
		if(initial(species.disliked_food) & ~MEAT)
			species.disliked_food &= ~MEAT

/datum/quirk/cum_plus
	name = "Extra-Productive Genitals"
	desc = "Your genitals produce and hold more than normal."
	value = 0
	gain_text = span_notice("You feel pressure in your groin.")
	lose_text = span_notice("You feel a weight lifted from your groin.")
	medical_record_text = "Patient exhibits increased production of sexual fluids."

/datum/quirk/cum_plus/add()
	var/mob/living/carbon/M = quirk_holder
	if(M.getorganslot("testicles"))
		var/obj/item/organ/genital/testicles/T = M.getorganslot("testicles")
		T.fluid_mult = 1.5 //Base is 1
		T.fluid_max_volume = 5

/datum/quirk/cum_plus/remove()
	var/mob/living/carbon/M = quirk_holder
	if(!M)
		return
	if(quirk_holder.getorganslot("testicles"))
		var/obj/item/organ/genital/testicles/T = M.getorganslot("testicles")
		T.fluid_mult = 1 //Base is 1
		T.fluid_max_volume = 3 //Base is 3

/datum/quirk/cum_plus/on_process()
	var/mob/living/carbon/M = quirk_holder //If you get balls later, then this will still proc
	if(M.getorganslot("testicles"))
		var/obj/item/organ/genital/testicles/T = M.getorganslot("testicles")
		if(T.fluid_max_volume <= 5 || T.fluid_mult <= 0.2) //INVALID EXPRESSION?
			T.fluid_mult = 1.5 //Base is 0.133
			T.fluid_max_volume = 5

//well-trained moved to neutral to stop the awkward situation of a dom snapping and the 30 trait powergamers fall to the floor.
/datum/quirk/well_trained
	name = "Well-Trained"
	desc = "You absolutely love being dominated. The thought of someone stronger than you is enough to make you act up."
	value = 0
	gain_text = span_notice("You feel like being someone's pet...")
	lose_text = span_notice("You no longer feel like being a pet...")
	processing_quirk = TRUE
	var/mood_category = "dom_trained"
	var/notice_delay = 0
	var/mob/living/carbon/human/last_dom

/datum/quirk/well_trained/add()
	. = ..()
	RegisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE, .proc/on_examine_holder)

/datum/quirk/well_trained/remove()
	. = ..()
	UnregisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE)

/datum/quirk/well_trained/proc/on_examine_holder(atom/source, mob/living/user, list/examine_list)
	SIGNAL_HANDLER

	if(!istype(user))
		return
	if(!user.has_quirk(/datum/quirk/dominant_aura))
		return
	examine_list += span_lewd("You sense a strong aura of submission from [quirk_holder.p_them()].")

/datum/quirk/well_trained/on_process()
	. = ..()
	if(!quirk_holder)
		return

	var/good_x = "pet"
	switch(quirk_holder.gender)
		if(MALE)
			good_x = "boy"
		if(FEMALE)
			good_x = "girl"

	//Check for possible doms with the dominant_aura quirk, and for the closest one if there is
	. = FALSE
	var/list/mob/living/carbon/human/doms = range(DOMINANT_DETECT_RANGE, quirk_holder)
	var/closest_distance
	for(var/mob/living/carbon/human/dom in doms)
		if(dom != quirk_holder && dom.has_quirk(/datum/quirk/dominant_aura))
			if(!closest_distance || get_dist(quirk_holder, dom) <= closest_distance)
				. = dom
				closest_distance = get_dist(quirk_holder, dom)

	//Return if no dom is found
	if(!.)
		last_dom = null
		return

	//Handle the mood
	var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
	if(istype(mood.mood_events[mood_category], /datum/mood_event/dominant/good_boy))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, mood_category, /datum/mood_event/dominant/good_boy)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, mood_category, /datum/mood_event/dominant/need)

	//Don't do anything if a previous dom was found
	if(last_dom)
		notice_delay = world.time + 15 SECONDS
		return

	last_dom = .

	if(notice_delay > world.time)
		return

	//Let them know they're near
	var/list/notices = list(
		"You feel someone's presence making you more submissive...",
		"Thoughts of being commanded flood you with lust...",
		"You really want to be called a good [good_x]...",
		"Someone's presence is making you all flustered...",
		"You start getting sweaty and excited..."
	)

	to_chat(quirk_holder, span_lewd(pick(notices)))
	notice_delay = world.time + 15 SECONDS


//hydra code below

/datum/quirk/hydra
	name = "Hydra Heads"
	desc = "You are a tri-headed creature. To use, format your name like (Rucks-Sucks-Ducks)."
	value = 0
	mob_trait = TRAIT_HYDRA_HEADS
	gain_text = span_notice("You hear two other voices inside of your head(s).")
	lose_text = span_danger("All of your minds become singular.")
	medical_record_text = "Patient has multiple heads and personalities affixed to their body."

/datum/quirk/hydra/on_spawn()
	var/mob/living/carbon/human/hydra = quirk_holder
	var/datum/action/innate/hydra/spell = new
	var/datum/action/innate/hydrareset/resetspell = new
	spell.Grant(hydra)
	spell.owner = hydra
	resetspell.Grant(hydra)
	resetspell.owner = hydra
	hydra.name_archive = hydra.real_name

//Own traits
/datum/quirk/cum_sniff
	name = "Genital Taster"
	desc = "You've built so much experience savoring other people's genitals through your life that you can easily tell what liquids they're full of, besides reagents in their blood that is."
	value = 0
	mob_trait = TRAIT_GFLUID_DETECT
	gain_text = span_notice("You begin sensing peculiar smells from people's bits...")
	lose_text = span_notice("People's genitals start smelling all the same to you...")
	medical_record_text = "Patient attempted to get their doctor to drag his balls accross their face."

/datum/quirk/fluid_infuser
	name = "Fluid Infuser"
	desc = "You just couldn't wait to get one of NanoTrasen's new fluid inducers when they first came out, so now you can hop in the station with editable titty milk!"
	value = 0

/datum/quirk/fluid_infuser/on_spawn()
	. = ..()
	var/obj/item/implant/genital_fluid/put_in = new
	put_in.implant(quirk_holder, null, TRUE, TRUE)

/datum/quirk/storage_concealment
	name = "Dorsualiphobic Augmentation"
	desc = "You despise the idea of being seen wearing any type of back-mounted storage apparatus! A new technology shields you from the immense shame you may experience, by hiding your equipped backpack."
	
	// UNUSED: Enable by setting these values to TRUE
	// The shame is unbearable
	mood_quirk = FALSE
	processing_quirk = FALSE
	var/mood_category = "backpack_implant_mood"

/datum/quirk/storage_concealment/on_spawn()
	. = ..()
	
	// Create a new augment item
	var/obj/item/implant/hide_backpack/put_in = new
	
	// Apply the augment to the quirk holder
	put_in.implant(quirk_holder, null, TRUE, TRUE)

/datum/quirk/storage_concealment/on_process()
	// This trait should only be applied by the augment
	// Check the quirk holder for the trait
	if(HAS_TRAIT(quirk_holder, TRAIT_HIDE_BACKPACK))
		// When found: Mood bonus
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, mood_category, /datum/mood_event/dorsualiphobic_mood_positive)
	else
		// When not found: Mood penalty
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, mood_category, /datum/mood_event/dorsualiphobic_mood_negative)

//succubus and incubus below
/datum/quirk/incubus
	name = "Incubus"
	desc = "Your seductor-like metabolism can only be sated by milk. (And semen, if you're a Succubus as well.)"
	value = 0
	mob_trait = TRAIT_INCUBUS
	processing_quirk = TRUE

/datum/quirk/incubus/add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H,TRAIT_NO_PROCESS_FOOD,ROUNDSTART_TRAIT)
	ADD_TRAIT(H,TRAIT_NOTHIRST,ROUNDSTART_TRAIT)

/datum/quirk/incubus/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	REMOVE_TRAIT(H,TRAIT_NO_PROCESS_FOOD,ROUNDSTART_TRAIT)
	REMOVE_TRAIT(H,TRAIT_NOTHIRST,ROUNDSTART_TRAIT)

/datum/quirk/incubus/on_process()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.adjust_nutrition(-0.09)//increases their nutrition loss rate to encourage them to gain a partner they can essentially leech off of

/datum/quirk/succubus
	name = "Succubus"
	desc = "Your seductress-like metabolism can only be sated by semen. (And milk, if you're an Incubus as well.)"
	value = 0
	mob_trait = TRAIT_SUCCUBUS
	processing_quirk = TRUE

/datum/quirk/succubus/add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H,TRAIT_NO_PROCESS_FOOD,ROUNDSTART_TRAIT)
	ADD_TRAIT(H,TRAIT_NOTHIRST,ROUNDSTART_TRAIT)

/datum/quirk/succubus/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	REMOVE_TRAIT(H,TRAIT_NO_PROCESS_FOOD,ROUNDSTART_TRAIT)
	REMOVE_TRAIT(H,TRAIT_NOTHIRST,ROUNDSTART_TRAIT)

/datum/quirk/succubus/on_process()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.adjust_nutrition(-0.09)//increases their nutrition loss rate to encourage them to gain a partner they can essentially leech off of

/datum/quirk/vampire//splurt change start
	name = "Bloodsucker Fledgeling"
	desc = "You are a fledgeling of an ancient Bloodsucker bloodline; your skin is incurably pale and your mouth glimmers with vampiric fangs. Only blood will sate your hungers, and holy energies will cause your flesh to char."
	value = 0
	medical_record_text = "this person was partially infected by a bloodsucker"
	mob_trait = BLOODFLEDGE
	gain_text = span_notice("You feel an otherworldly thirst.")
	lose_text = span_notice("you feel an otherworldy burden remove itself")
	processing_quirk = TRUE

/datum/quirk/vampire/add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H,TRAIT_NO_PROCESS_FOOD,ROUNDSTART_TRAIT)
	ADD_TRAIT(H,TRAIT_COLDBLOODED,ROUNDSTART_TRAIT)
	ADD_TRAIT(H,TRAIT_NOBREATH,ROUNDSTART_TRAIT)
	ADD_TRAIT(H,TRAIT_NOTHIRST,ROUNDSTART_TRAIT)
	ADD_TRAIT(H,TRAIT_QUICKER_CARRY,ROUNDSTART_TRAIT)
	ADD_TRAIT(H,TRAIT_AUTO_CATCH_ITEM,ROUNDSTART_TRAIT)//these two make the vampire fast and enables some sexy "bet you didnt think i could do this" romance
	if(!H.dna.skin_tone_override)
		H.skin_tone = "albino"
	var/datum/action/vbite/B = new
	var/datum/action/vrevive/R = new
	B.Grant(H)
	R.Grant(H)
	H.grant_language(/datum/language/vampiric, TRUE, TRUE, LANGUAGE_BLOODSUCKER)

/datum/quirk/vampire/on_process()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	var/area/A = get_area(H)
	if(istype(A, /area/service/chapel) && H.mind?.assigned_role != "Chaplain")
		H.adjustStaminaLoss(2)
		H.adjust_nutrition(-0.3)//changed these to be less deadly and more of an inconvinience
		H.adjust_disgust(1)
	if(istype(H.loc, /obj/structure/closet/crate/coffin))//heals the vampire if in a coffin, except burn which fire can be considered holy
		H.heal_overall_damage(4,4)
		H.adjust_disgust(-7)
		H.adjustOxyLoss(-4)
		H.adjustCloneLoss(-4)
		H.adjustBruteLoss(-0.3)
		H.adjustFireLoss(-0.3)
		if(!is_species(H, /datum/species/jelly)) //checks species
			H.adjustToxLoss(-5)//heals toxin if not slime
		else
			H.adjustToxLoss(5)//heals toxin if slime
		return
	if(H.nutrition == 0)
		if(H.staminaloss < 99)//makes them tired but dosent stun them
			H.adjustStaminaLoss(3, FALSE, TRUE)
		else
			H.adjustStaminaLoss(-1,FALSE, FALSE)//this also helps with if someone is stuck in the chapel for way too long, and i tested with a stun sword that stunning for sec is still possible
		if(prob(2)) //2 percent chance (if it was true randome D:<)
			to_chat(H, span_warning("I need blood NOW!!!"))

/datum/quirk/vampire/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/action/vbite/B = locate() in H.actions
	var/datum/action/vrevive/R = locate() in H.actions
	REMOVE_TRAIT(H, TRAIT_NO_PROCESS_FOOD, ROUNDSTART_TRAIT)
	REMOVE_TRAIT(H, TRAIT_COLDBLOODED, ROUNDSTART_TRAIT)
	REMOVE_TRAIT(H, TRAIT_NOBREATH, ROUNDSTART_TRAIT)
	REMOVE_TRAIT(H, TRAIT_NOTHIRST, ROUNDSTART_TRAIT)
	REMOVE_TRAIT(H,TRAIT_QUICKER_CARRY,ROUNDSTART_TRAIT)
	REMOVE_TRAIT(H,TRAIT_AUTO_CATCH_ITEM,ROUNDSTART_TRAIT)
	B.Remove(H)
	R.Remove(H)
	H.remove_language(/datum/language/vampiric, TRUE, TRUE, LANGUAGE_BLOODSUCKER)

/datum/quirk/vampire/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/card/id/vampire/vcard = new /obj/item/card/id/vampire
	H.equip_to_slot(vcard, ITEM_SLOT_BACKPACK)
	vcard.registered_name = H.real_name
	vcard.update_label(addtext(vcard.registered_name, " the vampire"))
	//var/obj/item/card/id/I = H.get_idcard(FALSE)   maybe later, hop can just give the extra card proper access if needed, as for banking, that can be set on spawn by the player using the card in hand
	//vcard.access = I.access
	H.regenerate_icons()
	. = ..()


/datum/quirk/werewolf //adds the werewolf quirk
	name = "Werewolf"
	desc = "A beastly affliction allows you to shapeshift into a more wolfish appearance at will. This will increase your size (In general and below!) and cause you to behave as though you were an anthropomorphic canine. (This is still being tested. Please send any bugs to nukechicken on discord)"
	value = 0

/datum/quirk/werewolf/add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/action/werewolf/W = new
	W.Grant(H)

/datum/quirk/werewolf/remove()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/action/werewolf/W = locate() in H.actions
	W.Remove(H)
	. = ..()


/datum/quirk/gargoyle //Mmmm yes stone time
	name = "Gargoyle"
	desc = "You are some form of gargoyle! You can only leave your stone form for so long, and will have to return to it to regain energy. On the bright side, you heal in statue form!"
	value = 0
	processing_quirk = TRUE
	var/energy = 0
	var/transformed = 0
	var/cooldown = 0
	var/paused = 0
	var/turf/position
	var/obj/structure/statue/gargoyle/current = null

/datum/quirk/gargoyle/add()
	.=..()
	var/mob/living/carbon/human/H = quirk_holder
	if (!H)
		return
	var/datum/action/gargoyle/transform/T = new
	var/datum/action/gargoyle/check/C = new
	var/datum/action/gargoyle/pause/P = new
	energy = 100
	cooldown = 30
	T.Grant(H)
	C.Grant(H)
	P.Grant(H)

/datum/quirk/gargoyle/on_process()
	.=..()
	var/mob/living/carbon/human/H = quirk_holder

	if (!H)
		return

	if(paused && H.loc != position)
		paused = 0
		energy -= 20

	if(cooldown > 0)
		cooldown--

	if(!transformed && !paused && energy > 0)
		energy -= 0.05

	if(transformed)
		energy = min(energy + 0.3, 100)
		if (H.getBruteLoss() > 0 || H.getFireLoss() > 0)
			H.adjustBruteLoss(-0.5, forced = TRUE)
			H.adjustFireLoss(-0.5, forced = TRUE)
		else if (H.getOxyLoss() > 0 || H.getToxLoss() > 0)
			H.adjustToxLoss(-0.3, forced = TRUE)
			H.adjustOxyLoss(-0.5, forced = TRUE) //oxyloss heals by itself, doesn't need a nerfed heal
		else if (H.getCloneLoss() > 0)
			H.adjustCloneLoss(-0.3, forced = TRUE)
		else if (current && current.obj_integrity < current.max_integrity) //health == maxHealth is true since we checked all damages above
			current.obj_integrity = min(current.obj_integrity + 0.1, current.max_integrity)

	if(!transformed && energy <= 0)
		var/datum/action/gargoyle/transform/T = locate() in H.actions
		if (!T)
			T = new
			T.Grant(H)
		cooldown = 0
		T?.Trigger()

/datum/quirk/gargoyle/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if (!H)
		return ..()
	var/datum/action/gargoyle/transform/T = locate() in H.actions
	var/datum/action/gargoyle/check/C = locate() in H.actions
	var/datum/action/gargoyle/pause/P = locate() in H.actions
	T?.Remove(H)
	C?.Remove(H)
	P?.Remove(H)
	. = ..()

/datum/quirk/nudist
	// Mostly derived from masked_mook.
	// Spawning with a gear harness is preferable, but failed during testing.
	name = "Nudist"
	desc = "Wearing most types of clothing unnerves you. Bring a gear harness!"
	gain_text = span_notice("You feel spiritually connected to your natural form.")
	lose_text = span_notice("It feels like clothing could fit you comfortably.")
	medical_record_text = "Patient expresses a psychological need to remain unclothed."
	value = 0
	mood_quirk = TRUE
	processing_quirk = TRUE
	var/mood_category = "nudist_mood"

/datum/quirk/nudist/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	// Checking torso exposure appears to be a robust method.
	if( ( H.is_chest_exposed() && H.is_groin_exposed() ) )
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, mood_category, /datum/mood_event/nudist_positive)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, mood_category, /datum/mood_event/nudist_negative)

/datum/quirk/nudist/on_spawn()
	. = ..()
	// Spawn a Rapid Disrobe Implant
	var/obj/item/implant/disrobe/quirk_implant = new

	// Implant into quirk holder
	quirk_implant.implant(quirk_holder, null, TRUE, TRUE)

/datum/quirk/masked_mook
	name = "Bane Syndrome"
	desc = "For some reason you don't feel... right without wearing some kind of gas mask."
	gain_text = span_danger("You start feeling unwell without any gas mask on.")
	lose_text = span_notice("You no longer have a need to wear some gas mask.")
	value = 0
	mood_quirk = TRUE
	medical_record_text = "Patient feels more secure when wearing a gas mask."
	processing_quirk = TRUE
	var/mood_category = "masked_mook"

/datum/quirk/masked_mook/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/mask/gas/gasmask = H.get_item_by_slot(ITEM_SLOT_MASK)
	if(istype(gasmask))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, mood_category, /datum/mood_event/masked_mook)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, mood_category, /datum/mood_event/masked_mook_incomplete)

/datum/quirk/masked_mook/on_spawn()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/mask/gas/cosmetic/gasmask = new(get_turf(quirk_holder)) // Uses a custom gas mask
	H.equip_to_slot(gasmask, ITEM_SLOT_MASK)
	H.regenerate_icons()
