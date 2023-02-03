// Unimplemented
/datum/species/proc/randomize(mob/living/carbon/human/H)
	H.gender = pick(MALE, FEMALE)
	H.real_name = random_unique_name(H.gender)
	H.name = H.real_name
	H.underwear = random_underwear(H.gender)
	H.undie_color = random_short_color()
	H.undershirt = random_undershirt(H.gender)
	H.shirt_color = random_short_color()
	H.dna.skin_tone_override = null
	H.skin_tone = random_skin_tone()
	H.hair_style = random_hair_style(H.gender)
	H.facial_hair_style = random_facial_hair_style(H.gender)
	H.hair_color = random_short_color()
	H.facial_hair_color = H.hair_color
	var/random_eye_color = random_eye_color()
	H.left_eye_color = random_eye_color
	H.right_eye_color = random_eye_color
	H.dna.blood_type = random_blood_type()
	H.saved_underwear = H.underwear
	H.saved_undershirt = H.undershirt
	H.saved_socks = H.socks

	H.dna.features["legs"] = "Plantigrade"
	H.dna.features["body_model"] = H.gender
	H.dna.features["flavor_text"] = "" //Oh no.

	H.dna.features["genitals_use_skintone"] = TRUE
	var/butt_size
	if(H.gender == MALE)
		H.dna.features["has_cock"] = TRUE
		H.dna.features["has_balls"] = TRUE
		H.dna.features["cock_girth"] = 0.78 + (0.02 * rand(-4, prob(10) ? 5 : 1)) //chance for a bigger pleasure
		H.dna.features["cock_shape"] = "Human"
		H.dna.features["cock_length"] = 0.5 + rand(4, prob(10) ? 9 : 6) + rand()
		H.dna.features["balls_shape"] = "Single"
		butt_size = pickweight(list("1" = 65, "2" = 20, "3" = 7, "4" = 5, "5" = 3))
	else
		H.dna.features["has_vag"] = TRUE
		H.dna.features["has_womb"] = TRUE
		H.dna.features["has_breasts"] = TRUE
		H.dna.features["vag_shape"] = "Human"
		butt_size = pickweight(list("1" = 30, "2" = 40, "3" = 20, "4" = 7, "5" = 3))
	H.dna.features["has_butt"] = TRUE
	H.dna.features["butt_size"] = text2num(butt_size)

	H.set_bark(pick(GLOB.bark_random_list))
	H.vocal_pitch = BARK_PITCH_RAND(H.gender)
	H.vocal_pitch_range = BARK_VARIANCE_RAND

/proc/prepare_markings(mob/living/carbon/human/user, selected_limb = "All", selected_marking, marking_type = "mam_body_markings", color1, color2, color3)
	if(!istype(user))
		return
	var/datum/dna/dna = user.dna

	var/list/marking_list = GLOB.mam_body_markings_list
	for(var/path in marking_list)
		var/datum/sprite_accessory/S = marking_list[path]
		if(istype(S))
			if(istype(S, /datum/sprite_accessory/mam_body_markings))
				var/datum/sprite_accessory/mam_body_markings/marking = S
				if(!(selected_limb in marking.covered_limbs) && selected_limb != "All")
					continue

	var/datum/sprite_accessory/mam_body_markings/S = marking_list[selected_marking]
	for(var/limb in S.covered_limbs)
		var/limb_value = text2num(GLOB.bodypart_values[limb])
		dna.features[marking_type] += list(list(limb_value, selected_marking, list(color1, color2, color3)))
