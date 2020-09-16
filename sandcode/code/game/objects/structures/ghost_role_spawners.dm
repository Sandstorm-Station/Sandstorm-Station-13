/obj/effect/mob_spawn/robot
	mob_type = /mob/living/silicon/robot
	assignedrole = "Ghost Role"

/obj/effect/mob_spawn/robot/Initialize()
	. = ..()

/obj/effect/mob_spawn/robot/equip(mob/living/silicon/robot/R)
	. = ..()

/obj/effect/mob_spawn/robot/ghostcafe
	name = "Cafe Robotic Storage"
	uses = -1
	icon = 'sandcode/icons/obj/machines/robot_storage.dmi'
	icon_state = "robostorage"
	mob_name = "a cafe robot"
	roundstart = FALSE
	anchored = TRUE
	density = FALSE
	death = FALSE
	assignedrole = "Cafe Robot"
	short_desc = "You are a Cafe Robot!"
	flavour_text = "Who could have thought? This awesome local cafe accepts cyborgs too!"
	skip_reentry_check = TRUE
	banType = ROLE_GHOSTCAFE
	mob_type = /mob/living/silicon/robot/modules/roleplay

/obj/effect/mob_spawn/robot/ghostcafe/special(mob/living/silicon/robot/new_spawn)
	if(new_spawn.client)
		new_spawn.updatename(new_spawn.client)
		new_spawn.gender = NEUTER
		var/area/A = get_area(src)
		new_spawn.AddElement(/datum/element/ghost_role_eligibility, free_ghosting = TRUE)
		new_spawn.AddElement(/datum/element/dusts_on_catatonia)
		new_spawn.AddElement(/datum/element/dusts_on_leaving_area, list(A.type, /area/hilbertshotel))
		ADD_TRAIT(new_spawn, TRAIT_SIXTHSENSE, GHOSTROLE_TRAIT)
		ADD_TRAIT(new_spawn, TRAIT_EXEMPT_HEALTH_EVENTS, GHOSTROLE_TRAIT)
		ADD_TRAIT(new_spawn, TRAIT_NO_MIDROUND_ANTAG, GHOSTROLE_TRAIT) //The mob can't be made into a random antag, they are still eligible for ghost roles popups.
		to_chat(new_spawn,"<span class='boldwarning'>Ghosting is free!</span>")
		var/datum/action/toggle_dead_chat_mob/D = new(new_spawn)
		D.Grant(new_spawn)
