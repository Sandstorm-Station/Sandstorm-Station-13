/datum/disease/qarbliss
	name = "Unnatural Wasting"
	max_stages = 5
	stage_prob = 10
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	cure_text = "Holy water or Semen or extensive rest."
	spread_text = "A burst of pink unholy energy"
	cures = list("holywater", "semen")
	agent = "Unholy Forces"
	viable_mobtypes = list(/mob/living/carbon/human)
	disease_flags = CURABLE
	permeability_mod = 1
	severity = DISEASE_SEVERITY_POSITIVE
	var/finalstage = FALSE //Because we're spawning off the cure in the final stage, we need to check if we've done the final stage's effects.
	var/bliss = FALSE

/datum/disease/qarbliss/cure()
	if(affected_mob)
		affected_mob.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, "#1d2953")
		if(affected_mob.dna && affected_mob.dna.species)
			affected_mob.dna.species.handle_mutant_bodyparts(affected_mob)
			affected_mob.dna.species.handle_hair(affected_mob)
		SEND_SIGNAL(affected_mob, COMSIG_CLEAR_MOOD_EVENT, "qar_bliss")
	..()

/datum/disease/qarbliss/stage_act()
	if(!finalstage)
		if(affected_mob.lying && prob(stage*4))
			to_chat(affected_mob, "<span class='notice'>The warmth in your nethers fades.</span>")
			cure()
			return
		if(prob(stage*3))
			to_chat(affected_mob, "<span class='revennotice'>You suddenly feel [pick("hot and bothered", "horny", "lusty", "like you're in a rut", "the need to breed", "breedable")]...</span>")
			affected_mob.confused += 8
			affected_mob.adjustStaminaLoss(8)
			new /obj/effect/temp_visual/revenant(affected_mob.loc)
		if(prob(45))
			affected_mob.adjustStaminaLoss(stage)
	..() //So we don't increase a stage before applying the stage damage.
	switch(stage)
		if(2)
			if(prob(5))
				affected_mob.emote("blush")
		if(3)
			if(!bliss)
				SEND_SIGNAL(affected_mob, COMSIG_ADD_MOOD_EVENT, "qar_bliss", /datum/mood_event/qareen_bliss)
				bliss = TRUE
			SEND_SIGNAL(affected_mob, COMSIG_MODIFY_SANITY, 0.12, SANITY_CRAZY)
			if(prob(10))
				affected_mob.emote(pick("blush","drool"))
		if(4)
			SEND_SIGNAL(affected_mob, COMSIG_MODIFY_SANITY, 0.18, SANITY_CRAZY)
			if(prob(15))
				affected_mob.emote(pick("blush","drool","moan"))
		if(5)
			if(!finalstage)
				finalstage = TRUE
				to_chat(affected_mob, "<span class='revenbignotice'>You feel a pink haze clouding your mind. [pick("Everyone needs to be bred.", "You need to breed.", "You need sex.", "They're all nothing but whores.")].</span>")
				affected_mob.adjustStaminaLoss(45)
				if(affected_mob.dna?.species)
					affected_mob.dna.species.handle_mutant_bodyparts(affected_mob,"#fff0ff")
					affected_mob.dna.species.handle_hair(affected_mob,"#da6eda")
				affected_mob.add_quirk(/datum/quirk/cum_plus)
				affected_mob.visible_message("<span class='warning'>[affected_mob] looks terrifyingly horny...</span>", "<span class='revennotice'>You suddenly feel like your skin is <i>tingling</i>...</span>")
				affected_mob.add_atom_colour("#ffdaf3", TEMPORARY_COLOUR_PRIORITY)
				new /obj/effect/temp_visual/revenant(affected_mob.loc)
				addtimer(CALLBACK(src, .proc/blessings), 150)

/datum/disease/qarbliss/proc/blessings()
	if(QDELETED(affected_mob))
		return
	affected_mob.playsound_local(affected_mob, 'sound/effects/gib_step.ogg', 40, 1, -1)
	to_chat(affected_mob, "<span class='revendanger'>You sense the curse of a lustful ghost befall you...</span>")
	cure()
