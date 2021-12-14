/mob/living/proc/pick_receiving_organ(mob/living/carbon/L, flag = CAN_CUM_INTO, title = "Climax", desc = "in what hole?")
	if (!istype(L))
		return
	var/list/receivers_list
	var/list/other_worn = L.get_equipped_items()
	for(var/obj/item/organ/genital/G in L.internal_organs)
		if((G.genital_flags & flag) && G.is_exposed(other_worn)) //filter out what you can't cum into
			LAZYADD(receivers_list, G)
	if(LAZYLEN(receivers_list))
		var/obj/item/organ/genital/ret_organ = input(src, desc, title, null) as null|obj in receivers_list
		return ret_organ

/mob/living/proc/receive_climax(mob/living/partner, obj/item/organ/genital/receiver = null, obj/item/organ/genital/source_gen, spill = TRUE)
	if(!ishuman(src))
		return
	var/mob/living/carbon/human/h_self = src
	var/mob/living/carbon/human/h_partner = null
	if(ishuman(partner))
		h_partner = partner

	if(istype(source_gen, /obj/item/organ/genital/penis))
		h_self.cumdrip_rate += rand(5,10)
		if(h_self.has_belly(REQUIRE_ANY) && (h_self.client?.prefs.cit_toggles & BELLY_INFLATION))
			var/obj/item/organ/genital/belly/midsection = h_self.getorganslot(ORGAN_SLOT_BELLY)
			to_chat(h_self, "<span class='userlove'> You can feel your belly bloat outwards as [h_partner] fills you up with [h_partner.p_their()] seed, sagging more distended in front of you")
			midsection.modify_size(1)
	if(receiver)
		switch(receiver.slot) //Feel free to add more options for other receiving genitals if you desire
			if(ORGAN_SLOT_VAGINA)
				var/obj/item/organ/genital/womb/W = h_self.getorganslot(ORGAN_SLOT_WOMB)
				if(W && h_partner && !spill && !HAS_TRAIT(h_self, TRAIT_INFERTILE) && istype(source_gen, /obj/item/organ/genital/penis))
					var/obj/item/organ/genital/penis/Sp = source_gen
					if(prob(30 + clamp((70*(rand() + (h_self.sexual_potency + h_partner.sexual_potency)/200)), 0, 70)) && !W.impregnated && !Sp.equipment[GENITAL_EQUIPEMENT_CONDOM])
						W.impregnated = TRUE
						log_game("Debug: [h_self] has been impregnated by [h_partner]")
						to_chat(src, "<span class='userlove'>You feel your hormones change, and a motherly instinct take over.</span>")
						var/obj/item/organ/genital/breasts/B = h_self.getorganslot(ORGAN_SLOT_BREASTS)
						if(B)
							B.fluid_rate *= 2

/mob/living/carbon/human/do_climax(datum/reagents/R, atom/target, obj/item/organ/genital/G, spill)
	if(!G)
		return

	if(istype(G, /obj/item/organ/genital/penis))
		var/obj/item/organ/genital/penis/bepis = G
		if(bepis.equipment[GENITAL_EQUIPMENT_SOUNDING])
			spill = TRUE
			to_chat(src, "<span class='userlove'>You feel your sounding rod being pushed out of your cockhole with the burst of jizz!</span>")
			bepis.equipment.Remove(GENITAL_EQUIPMENT_SOUNDING)
			new /obj/item/genital_equipment/sounding/used_sounding(loc)
	. = ..()
