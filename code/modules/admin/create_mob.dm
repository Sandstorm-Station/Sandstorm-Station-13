
/datum/admins/proc/create_mob(mob/user)
	var/static/create_mob_html
	if (!create_mob_html)
		var/mobjs = null
		mobjs = jointext(typesof(/mob), ";")
		create_mob_html = file2text('html/create_object.html')
		create_mob_html = replacetext(create_mob_html, "Create Object", "Create Mob")
		create_mob_html = replacetext(create_mob_html, "null /* object types */", "\"[mobjs]\"")

	user << browse(create_panel_helper(create_mob_html), "window=create_mob;size=425x475")

/proc/randomize_human(mob/living/carbon/human/H)
	H.dna.species.randomize(H)
	H.dna.update_dna_identity()
	H.give_genitals(TRUE)

	SEND_SIGNAL(H, COMSIG_HUMAN_ON_RANDOMIZE)

	H.update_body(TRUE)
	H.update_hair()
	H.update_body_parts()
