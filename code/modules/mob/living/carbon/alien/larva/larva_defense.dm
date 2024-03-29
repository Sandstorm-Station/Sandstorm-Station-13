

/mob/living/carbon/alien/larva/on_attack_hand(mob/living/carbon/human/M)
	. = ..()
	if(. || M.a_intent == INTENT_HELP || M.a_intent == INTENT_GRAB)
		return
	var/damage = rand(1, 9)
	if (prob(90))
		playsound(loc, "punch", 25, 1, -1)
		log_combat(M, src, "attacked")
		visible_message("<span class='danger'>[M] has kicked [src]!</span>", \
				"<span class='userdanger'>[M] has kicked [src]!</span>", null, COMBAT_MESSAGE_RANGE)
		if ((stat != DEAD) && (damage > 4.9))
			Unconscious(rand(100,200))

		var/obj/item/bodypart/affecting = get_bodypart(ran_zone(M.zone_selected))
		apply_damage(damage, BRUTE, affecting)
	else
		playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
		visible_message("<span class='danger'>[M] has attempted to kick [src]!</span>", \
				"<span class='userdanger'>[M] has attempted to kick [src]!</span>", null, COMBAT_MESSAGE_RANGE)

/mob/living/carbon/alien/larva/attack_hulk(mob/living/carbon/human/user, does_attack_animation = FALSE)
	if(user.a_intent == INTENT_HARM)
		. = ..(user, TRUE)
		if(.)
			return
		playsound(loc, "punch", 25, 1, -1)
		visible_message("<span class='danger'>[user] has pummeled [src]!</span>", \
		"<span class='userdanger'>[user] has pummeled [src]!</span>", null, COMBAT_MESSAGE_RANGE)
		adjustBruteLoss(5 + rand(1,9))
		new /datum/forced_movement(src, get_step_away(user,src, 30), 1)
		return TRUE

/mob/living/carbon/alien/larva/do_attack_animation(atom/A, visual_effect_icon, obj/item/used_item, no_effect)
	if(!no_effect && !visual_effect_icon)
		visual_effect_icon = ATTACK_EFFECT_BITE
	..()
