/obj/machinery/research_table
	name = "Sex Research Rack"
	desc = "The rack with silicone padding and plenty of straps for subject restraining.\
	\nA lot of sensors are connected to this device that record the state of the body during orgasm. Well, you know... For scientific purposes..."
	icon = 'modular_splurt/icons/obj/research_rack.dmi'
	icon_state = "rack"
	can_buckle = TRUE
	density = TRUE
	buckle_lying = TRUE
	layer = TABLE_LAYER
	obj_flags = CAN_BE_HIT|SHOVABLE_ONTO
	pass_flags = LETPASSTHROW //You can throw objects over this, despite it's density.")
	circuit = /obj/item/circuitboard/machine/research_table
	var/self_unbuckle_time = 3 MINUTES
	var/static/list/users = list()
	var/tier = 1
	var/multiplier = 100
	var/configured = FALSE

/obj/machinery/research_table/examine(mob/user)
	. = ..()
	if(!configured)
		. += "<span class='notice'>It's not configured yet, you could use a <b>multitool</b> to configure it.</span>"

/obj/machinery/research_table/multitool_act(mob/living/user, obj/item/I)
	if(user.a_intent == INTENT_HELP)
		if(do_after(user, 5 SECONDS, TRUE, src))
			configured = !configured
			to_chat(user, "<span class='notice'>The research table is now [configured ? "configured" : "not configured"].</span>")
		else
			to_chat(user, "<span class='warning'>You need to stand still and uninterrupted for 5 seconds!</span>")
		return STOP_ATTACK_PROC_CHAIN
	. = ..()

/obj/machinery/research_table/MouseDrop_T(mob/living/M, mob/living/user)
	if(get_turf(M) != get_turf(src) && Adjacent(M) && Adjacent(user) && user.stat == CONSCIOUS)
		var/message = M == user ? "[M] climbs on the [src]." : "[user] puts [M] on the [src]."
		var/self_message = M == user ? "You climb on the [src]." : "You put [M] on the [src]."
		visible_message(message, self_message)
		M.forceMove(get_turf(src))
	. = ..()

/obj/machinery/research_table/user_unbuckle_mob(mob/living/buckled_mob, mob/user)
	if(!handle_unbuckling(buckled_mob, user))
		if(buckled_mob == user)
			to_chat(user, "<span class='warning'>You fail to unbuckle yourself.</span>")
		else
			to_chat(user, "<span class='warning'>You fail to unbuckle [buckled_mob].</span>")
		return
	UnregisterSignal(buckled_mob, COMSIG_MOB_CAME)
	say("User left, resetting scanners.")
	return ..()

/obj/machinery/research_table/proc/handle_unbuckling(mob/living/buckled_mob, user)
	if(buckled_mob == user)
		if(do_after(user, self_unbuckle_time, FALSE, src))
			return TRUE
		else
			return FALSE
	return TRUE

/obj/machinery/research_table/buckle_mob(mob/living/buckled_mob, force, check_loc)
	RegisterSignal(buckled_mob, COMSIG_MOB_CAME, .proc/on_cum)
	say("New user detected, tracking data.")
	. = ..()

/obj/machinery/research_table/RefreshParts()
	var/parts = 0
	tier = 0
	for(var/obj/item/stock_parts/part in component_parts)
		tier += part.rating
		parts++
	tier /= parts

/obj/machinery/research_table/proc/on_cum(mob/living/carbon/buckled_mob, obj/item/organ/genital/target_orifice, mob/living/partner)
	if(!configured)
		say("Failed to get any data, the table is not configured!")
		return
	if(!istype(buckled_mob))
		say("Failed to get any data from the subject, it is not a human.")
		return
	if(buckled_mob.last_partner == buckled_mob)
		say("Failed to get any data from the subject, two are needed for the experiment!")
		return
	if(users[buckled_mob.name] > 5)
		say("There is already too much data from this subject.")
		return
	users[buckled_mob.name] += 1
	var/points_awarded = 0
	for(var/obj/item/organ/genital/genital in buckled_mob.internal_organs)
		if(istype(genital, /obj/item/organ/genital/breasts))
			var/obj/item/organ/genital/breasts/breasts = genital
			points_awarded += breasts.fluid_rate + breasts.breast_values[breasts.size] // Breasts use letters instead of numbers!
			continue
		points_awarded += genital.fluid_rate + genital.size
	points_awarded *= tier
	points_awarded *= multiplier
	SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = points_awarded))
	say("Obtained [points_awarded] point\s from the session.")
