// HYPERSTATION TRAITS

/datum/quirk/choke_slut
	name = "Choke Slut"
	desc = "You are aroused by suffocation."
	value = 0
	mob_trait = TRAIT_CHOKE_SLUT
	gain_text = "<span class='notice'>You feel like you want to feel fingers around your neck, choking you until you pass out or make a mess... Maybe both.</span>"
	lose_text = "<span class='notice'>Seems you don't have a kink for suffocation anymore.</span>"

/datum/quirk/pharmacokinesis //Supposed to prevent unwanted organ additions. But i don't think it's really working rn
	name = "Acute Hepatic Pharmacokinesis" //copypasting dumbo
	desc = "You have a genetic disorder that causes Incubus Draft and Succubus Milk to be absorbed by your liver instead."
	value = 0
	mob_trait = TRAIT_PHARMA
	lose_text = "<span class='notice'>Your liver feels... different, somehow.</span>"
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

/datum/quirk/cursed_blood
	name = "Cursed Blood"
	desc = "Your lineage is cursed with the paleblood curse. Best to stay away from holy water... Hell water, on the other hand..."
	value = 0
	mob_trait = TRAIT_CURSED_BLOOD
	gain_text = "<span class='notice'>A curse from a land where men return as beasts runs deep in your blood.</span>"
	lose_text = "<span class='notice'>You feel the weight of the curse in your blood finally gone.</span>"
	medical_record_text = "Patient suffers from an unknown type of aversion to holy reagents. Keep them away from a chaplain."

/datum/quirk/headpat_hater
	name = "Distant"
	desc = "You don't seem to show much care for being touched. Whether it's because you're reserved or due to self control, others touching your head won't make you wag your tail should you possess one, and the action may even attract your ire."
	mob_trait = TRAIT_DISTANT
	value = 0
	gain_text = "<span class='notice'>Others' touches begin to make your blood boil...</span>"
	lose_text = "<span class='notice'>Having your head pet doesn't sound so bad right about now...</span>"
	medical_record_text = "Patient cares little with or dislikes being touched."

/datum/quirk/headpat_slut
	name = "Headpat Slut"
	desc = "You love the feeling of others touching your head! Maybe a little too much, actually... Others patting your head will provide a bigger mood boost and cause aroused reactions."
	mob_trait = TRAIT_HEADPAT_SLUT
	value = 0
	gain_text = "<span class='notice'>You crave headpats immensely!</span>"
	lose_text = "<span class='notice'>Your headpats addiction wanes.</span>"
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
	gain_text = "<span class='notice'>You body burns with the desire to be bred.</span>"
	lose_text = "<span class='notice'>You feel more in control of your body and thoughts.</span>"

/datum/quirk/Hypnotic_gaze
	name = "Hypnotic Gaze"
	desc = "Be it through mysterious patterns, flickering colors, or some genetic oddity, prolonged eye contact with you will place the viewer into a highly-suggestible hypnotic trance."
	value = 0
	mob_trait = TRAIT_HYPNOTIC_GAZE
	gain_text = "<span class='notice'>Your eyes glimmer hypnotically...</span>"
	lose_text = "<span class='notice'>Your eyes return to normal.</span>"
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
	gain_text = "<span class='notice'>You feel your senses adjust, allowing a animalistic sense of others' fertility.</span>"
	lose_text = "<span class='notice'>You feel your sense of others' fertility fade.</span>"

/datum/quirk/overweight
	name = "Overweight"
	desc = "You're particularly fond of food, and join the shift being overweight."
	value = 0
	gain_text = "<span class='notice'>You feel a bit chubby!</span>"
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
	gain_text = "<span class='notice'>You feel repulsion at the idea of eating meat.</span>"
	lose_text = "<span class='notice'>You feel like eating meat isn't that bad.</span>"
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
	gain_text = "<span class='notice'>You feel pressure in your groin.</span>"
	lose_text = "<span class='notice'>You feel a weight lifted from your groin.</span>"
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
	gain_text = "<span class='notice'>You feel like being someone's pet...</span>"
	lose_text = "<span class='notice'>You no longer feel like being a pet...</span>"
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
	gain_text = "<span class='notice'>You hear two other voices inside of your head(s).</span>"
	lose_text = "<span class='danger'>All of your minds become singular.</span>"
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
	gain_text = "<span class='notice'>You begin sensing peculiar smells from people's bits...</span>"
	lose_text = "<span class='notice'>People's genitals start smelling all the same to you...</span>"
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

/datum/quirk/bloodfledge
	name = "Bloodsucker Fledgling"
	desc = "You are a fledgling belonging to ancient Bloodsucker bloodline. While the blessing has yet to fully convert you, some things have changed. Only blood will sate your hungers, and holy energies will cause your flesh to char. <b>This is NOT an antagonist role!</b>"
	value = 2
	medical_record_text = "Patient exhibits onset symptoms of a sanguine curse."
	mob_trait = TRAIT_BLOODFLEDGE
	gain_text = "<span class='notice'>You feel a sanguine thirst.</span>"
	lose_text = "<span class='notice'>You feel the sanguine thirst fade away.</span>"
	processing_quirk = TRUE

/datum/quirk/bloodfledge/add()
	. = ..()

	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Add quirk traits
	ADD_TRAIT(quirk_mob,TRAIT_NO_PROCESS_FOOD,ROUNDSTART_TRAIT)
	ADD_TRAIT(quirk_mob,TRAIT_NOTHIRST,ROUNDSTART_TRAIT)

	// Set skin tone, if possible
	if(!quirk_mob.dna.skin_tone_override)
		quirk_mob.skin_tone = "albino"

	// Add quirk ability action datums
	var/datum/action/bloodfledge/bite/act_bite = new
	var/datum/action/bloodfledge/revive/act_revive = new
	act_bite.Grant(quirk_mob)
	act_revive.Grant(quirk_mob)

	// Add quirk language
	quirk_mob.grant_language(/datum/language/vampiric, TRUE, TRUE, LANGUAGE_BLOODSUCKER)

/datum/quirk/bloodfledge/on_process()
	. = ..()

	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Check if the quirk mob is NOT a chaplain
	if(quirk_mob.mind?.assigned_role != "Chaplain")
		// Get current area
		var/area/holder_area = get_area(quirk_mob)

		// Check if quirk mob's area is the chapel
		if(!istype(holder_area, /area/service/chapel))
			return

		// Run until stamina limit is reached
		// Hard-coded based on STAMINA_CRIT of 140
		if(quirk_mob.staminaloss < 120)
			// Apply penalty to stamina, nutrition, and disgust
			quirk_mob.adjustStaminaLoss(4, FALSE, TRUE)
			quirk_mob.adjust_nutrition(-0.5)
			quirk_mob.adjust_disgust(0.5)

	// Check if the current area is a coffin
	if(istype(quirk_mob.loc, /obj/structure/closet/crate/coffin))
		// Define initial health
		var/health_start = quirk_mob.health

		// Quirk mob must be injured
		if(quirk_mob.health >= quirk_mob.maxHealth)
			return

		// Nutrition (blood) level must be above STARVING
		if(quirk_mob.nutrition <= NUTRITION_LEVEL_STARVING)
			// Display a warning chat message (10% chance)
			if(prob(10))
				to_chat(quirk_mob, "<span class='warning'>I need more blood before I can regenerate!</span>")

			// Return without healing, due to lack of blood
			return

		// Heal brute and burn
		quirk_mob.heal_overall_damage(2,2)
		// Heal fire
		quirk_mob.adjustFireLoss(-2)
		// Heal oxygen
		quirk_mob.adjustOxyLoss(-2)
		// Heal clone
		quirk_mob.adjustCloneLoss(-2)

		// Check for slime race
		// NOT a slime
		if(!isslimeperson(quirk_mob))
			// Heal toxin
			quirk_mob.adjustToxLoss(-2)
		// IS a slime
		else
			// Grant toxin (heals slimes)
			quirk_mob.adjustToxLoss(2)

		// Determine healed amount
		var/health_restored = quirk_mob.health - health_start

		// Remove nutrition (blood) as compensation for healing
		// Amount is equal to 50% of healing done
		quirk_mob.adjust_nutrition(health_restored*-0.5)

		// Return
		return

/datum/quirk/bloodfledge/remove()
	. = ..()
	
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Remove quirk traits
	REMOVE_TRAIT(quirk_mob, TRAIT_NO_PROCESS_FOOD, ROUNDSTART_TRAIT)
	REMOVE_TRAIT(quirk_mob, TRAIT_NOTHIRST, ROUNDSTART_TRAIT)

	// Remove quirk ability action datums
	var/datum/action/bloodfledge/bite/act_bite = locate() in quirk_mob.actions
	var/datum/action/bloodfledge/revive/act_revive = locate() in quirk_mob.actions
	act_bite.Remove(quirk_mob)
	act_revive.Remove(quirk_mob)

	// Remove quirk language
	quirk_mob.remove_language(/datum/language/vampiric, TRUE, TRUE, LANGUAGE_BLOODSUCKER)

/datum/quirk/bloodfledge/on_spawn()
	. = ..()

	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Create vampire ID card
	var/obj/item/card/id/vampire/vcard = new /obj/item/card/id/vampire

	// Update name and description
	vcard.registered_name = quirk_mob.real_name
	vcard.update_label(addtext(vcard.registered_name, " the vampire"))

	// Add to backpack
	quirk_mob.equip_to_slot(vcard, ITEM_SLOT_BACKPACK)

	// Update sprites
	quirk_mob.regenerate_icons()


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
	gain_text = "<span class='notice'>You feel spiritually connected to your natural form.</span>"
	lose_text = "<span class='notice'>It feels like clothing could fit you comfortably.</span>"
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

/datum/quirk/masked_mook
	name = "Bane Syndrome"
	desc = "For some reason you don't feel... right without wearing some kind of gas mask."
	gain_text = "<span class='danger'>You start feeling unwell without any gas mask on.</span>"
	lose_text = "<span class='notice'>You no longer have a need to wear some gas mask.</span>"
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
