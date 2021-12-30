/mob/living/simple_animal/hostile/deathclaw/funclaw
	name = "Funclaw"
	desc = "A massive, reptilian creature with powerful muscles, razor-sharp claws, and aggression to match. This one seems to have a strange look in its eyes.."
	var/change_target_hole_cooldown = 0
	var/chosen_hole
	var/voremode = FALSE // Fixes runtime when grabbing victim
	gold_core_spawnable = NO_SPAWN // Admin only
	deathclaw_mode = "rape"

/mob/living/simple_animal/hostile/deathclaw/funclaw/gentle
	name = "Gentle Deathclaw"
	desc = "A massive, reptilian creature with powerful muscles, razor-sharp claws, and aggression to match. This one has the bedroom eyes.."
	deathclaw_mode = "gentle"

/mob/living/simple_animal/hostile/deathclaw/funclaw/abomination
	name = "Exiled Deathclaw"
	desc = "A massive, reptilian creature with powerful muscles, razor-sharp claws, and aggression to match. This one has a strange smell for some reason.."
	deathclaw_mode = "abomination"

/mob/living/simple_animal/hostile/deathclaw/funclaw/AttackingTarget()
	var/mob/living/M = target

	// Gentleclaws do nothing if: on sex cooldown OR partner has no consented
	if (deathclaw_mode == "gentle" && get_refraction_dif() > 0 || deathclaw_mode == "gentle" && M.client.prefs.nonconpref != "Yes")
		return

	// We do NOT lewd and instead ATTACK if:
	// Do not lewd animals
	// Do not lewd players which aren't playing
	// Do not lewd non-consenting players
	// If in rape mode, hurt the victim first
	// If in abomination mode, hurt the victim first
	if(!ishuman(M) || !M.client || M.client.prefs.nonconpref != "Yes" || (deathclaw_mode == "rape" && M.health > 60) || (deathclaw_mode == "abomination" && M.health > 60))
		..() // Normal murderous mode
		return

	if(!M.pulledby)
		start_pulling(M, supress_message = TRUE)
		log_combat(src, M, "grabbed")
		M.visible_message("<span class='warning'>[src] violently grabs [M]!</span>", \
			"<span class='userdanger'>[src] violently grabs you!</span>")
		setGrabState(GRAB_NECK) //Instant neck grab

		if(!M.buckled && !M.density)
			M.Move(get_turf(src))

		return

	if(get_refraction_dif() > 0)
		..()
		return

	if(change_target_hole_cooldown < world.time)
		chosen_hole = null
		while (chosen_hole == null)
			pickNewHole(M)
		change_target_hole_cooldown = world.time + 100

	do_lewd_action(M)
	sleep(rand(8, 12))
	do_lewd_action(M)

/mob/living/simple_animal/hostile/deathclaw/funclaw/proc/pickNewHole(mob/living/M)
	switch(rand(2))
		if(0)
			chosen_hole = CUM_TARGET_ANUS
		if(1)
			if(M.has_vagina())
				chosen_hole = CUM_TARGET_VAGINA
			else
				chosen_hole = CUM_TARGET_ANUS
		if(2)
			chosen_hole = CUM_TARGET_THROAT

/mob/living/simple_animal/hostile/deathclaw/funclaw/proc/do_lewd_action(mob/living/M)
	if(get_refraction_dif() > 0)
		return

	switch(chosen_hole)
		if(CUM_TARGET_ANUS)
			if(tearSlot(M, SLOT_WEAR_SUIT))
				return
			if(tearSlot(M, SLOT_W_UNIFORM))
				return

			// Abomination deathclaws do other stuff instead
			if(deathclaw_mode == "abomination" && M.client.prefs.unholypref == "Yes")
				if(prob(1))
					do_grindmouth(M)
				else
					do_grindface(M)
				handle_post_sex(25, null, M)
			else
				do_anal(M)

		if(CUM_TARGET_VAGINA)
			if(tearSlot(M, SLOT_WEAR_SUIT))
				return
			if(tearSlot(M, SLOT_W_UNIFORM))
				return

			// Abomination deathclaws do other stuff instead
			if(deathclaw_mode == "abomination" && M.client.prefs.unholypref == "Yes")
				do_footjob_v(M)
				handle_post_sex(10, null, M)
			else
				do_vaginal(M)

		if(CUM_TARGET_THROAT)
			if(tearSlot(M, SLOT_HEAD))
				return
			if(tearSlot(M, SLOT_WEAR_MASK))
				return

			// Abomination deathclaws do other stuff instead
			if(deathclaw_mode == "abomination" && M.client.prefs.unholypref == "Yes")
				if(prob(1))
					do_faceshit(M)
				else
					do_facefart(M)
				handle_post_sex(25, null, M)
				shake_camera(M, 6, 1)
			else
				do_throatfuck(M)

/mob/living/simple_animal/hostile/deathclaw/funclaw/cum(mob/living/M)

	if(get_refraction_dif() > 0)
		return

	var/message

	if(!istype(M))
		chosen_hole = null

	switch(chosen_hole)
		if(CUM_TARGET_THROAT)
			if(M.has_mouth() && M.mouth_is_free())
				message = "shoves their fat reptillian cock deep down \the [M]'s throat and cums."
			else
				message = "cums on \the [M]'s face."
		if(CUM_TARGET_VAGINA)
			if(M.is_bottomless() && M.has_vagina())
				message = "rams its meaty cock into \the [M]'s pussy and fills it with sperm."
			else
				message = "cums on \the [M]'s belly."
		if(CUM_TARGET_ANUS)
			if(M.is_bottomless() && M.has_anus())
				message = "hilts its knot into \the [M]'s ass and floods it with Deathclaw jizz."
			else
				message = "cums on \the [M]'s backside."
		else
			message = "cums on the floor!"

	if(deathclaw_mode == "abomination" && M.client.prefs.unholypref == "Yes")
		message = "cums all over [M]'s body"

	playsound(loc, "modular_splurt/sound/lewd/deathclaw[rand(1, 2)].ogg", 70, 1, -1)
	visible_message("<font color=purple><b>\The [src]</b> [message]</font>")
	shake_camera(M, 6, 1)
	set_is_fucking(null ,null)


	refractory_period = world.time + rand(150, 250) // Sex cooldown
	set_lust(100) // Nuts at 400

	sleep(20)
	playsound(loc, "modular_sand/sound/interactions/slap.ogg", 70, 1, -1)
	visible_message("<span class='danger'>\The [src]</b> slaps \the [M] right on the ass!</span>", \
			"<span class='userdanger'>\The [src]</b> slaps \the [M] right on the ass!</span>", null, COMBAT_MESSAGE_RANGE)

/mob/living/simple_animal/hostile/deathclaw/funclaw/proc/tearSlot(mob/living/M, slot)
	var/obj/item/W = M.get_item_by_slot(slot)
	if(W)
		M.dropItemToGround(W)
		playsound(loc, "sound/items/poster_ripped.ogg", 70, 1, -1)
		visible_message("<span class='danger'>\The [src]</b> tears off \the [M]'s clothes!</span>", \
				"<span class='userdanger'>\The [src]</b> tears off \the [M]'s clothes!</span>", null, COMBAT_MESSAGE_RANGE)
		return TRUE
	return FALSE
