GLOBAL_LIST_INIT(pairless_panties, list(
	/obj/item/clothing/underwear/briefs/jockstrap = TRUE,
	/obj/item/clothing/underwear/briefs/panties/thong = TRUE,
	/obj/item/clothing/underwear/briefs/panties/thong/babydoll = TRUE,
	/obj/item/clothing/underwear/briefs/mankini = TRUE
))

/mob/living/carbon/human/examine(mob/user)
	. = ..()
	var/mob/living/living = user
	var/obj/item/clothing/under/worn_uniform = get_item_by_slot(ITEM_SLOT_ICLOTHING)
	if(worn_uniform && is_type_in_typecache(worn_uniform.type, GLOB.skirt_peekable) && (isobserver(user) || (isliving(user) && (user != src) && !(living.mobility_flags & MOBILITY_STAND) && (mobility_flags & MOBILITY_STAND) && (loc == living.loc) && (istype(worn_uniform)))))
		. += span_purple("[p_theyre(TRUE)] wearing a skirt! I can probably give it a little peek <b>looking closer</b>.")

/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_PARENT_EXAMINE_MORE, .proc/peek_skirt)

/mob/living/carbon/human/proc/peek_skirt(mob/examined, mob/examiner, list/examine_content)
	var/mob/living/living = examiner
	var/obj/item/clothing/under/worn_uniform = get_item_by_slot(ITEM_SLOT_ICLOTHING)
	if(worn_uniform && is_type_in_typecache(worn_uniform.type, GLOB.skirt_peekable) && (isobserver(examiner) || (isliving(examiner) && (examiner != src) && !(living.mobility_flags & MOBILITY_STAND) && (mobility_flags & MOBILITY_STAND) && (loc == living.loc) && (istype(worn_uniform)))))
		var/string = "Peeking under [src]'s [worn_uniform.name], you can see "
		var/obj/item/clothing/underwear/worn_underwear = get_item_by_slot(ITEM_SLOT_UNDERWEAR)
		if(worn_underwear)
			string += "a "
			if(!is_type_in_typecache(worn_underwear.type, GLOB.pairless_panties)) //a pair of thong
				string += "pair of "
			if(worn_underwear.color)
				string += "<font color='[worn_underwear.color]'>[worn_underwear.name]</font>."
			else
				string += "[worn_underwear.name]."

			var/obj/item/organ/genital/penis/penis = getorganslot(ORGAN_SLOT_PENIS)
			var/obj/item/organ/genital/vagina/vagina = getorganslot(ORGAN_SLOT_VAGINA)
			if(penis?.aroused_state)
				string += span_love(" There's a visible bulge on [p_their()] front.")
			else if(vagina?.aroused_state)
				string += span_love(" [p_theyre(TRUE)] wet with arousal.")

		else
			string += "[p_theyre()] not wearing anything!\n[p_their(TRUE)]"
			var/list/genitals = list()
			for(var/obj/item/organ/genital/genital in internal_organs)
				if(genital.genital_flags & (GENITAL_INTERNAL|GENITAL_HIDDEN))
					continue

				var/appended
				switch(genital.type)
					if(/obj/item/organ/genital/vagina)
						if(genital.aroused_state)
							appended += " wet"
						if(lowertext(genital.shape) != "human")
							appended += " [lowertext(genital.shape)]"
						if(lowertext(genital.shape) != "cloaca") //their wet cloaca vagina
							appended += " [lowertext(genital.name)]" // goodbye pussy

					if(/obj/item/organ/genital/testicles)
						var/obj/item/organ/genital/testicles/nuts = genital
						appended += " [lowertext(nuts.size_name)] [lowertext(nuts.name)]"
					if(/obj/item/organ/genital/penis)
						if(genital.aroused_state)
							appended += " fully erect"
						if(lowertext(genital.shape) != "human")
							appended += " [lowertext(genital.shape)]"
						appended += " [lowertext(genital.name)]" // Name it something funny, i dare you.
					if(/obj/item/organ/genital/butt)
						var/obj/item/organ/genital/butt/booty = genital
						appended += " [booty.size_name] [lowertext(booty.name)]" // Maybe " average butt pair" isn't the best for now
					else
						continue
				genitals += appended

			string += english_list(genitals, " featureless groin", " and", ",")
			string += " on full display."

		examine_content += span_purple(string)
