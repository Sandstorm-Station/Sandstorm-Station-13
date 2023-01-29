/obj/structure/statue/boney //wow thanks so much, it's almost like no one would ever make bone statues
	name = "statue of an ashwalker"
	icon = 'modular_splurt/icons/obj/structures/statue.dmi'
	icon_state = "ashie"
	max_integrity = 300
	desc = "This is a suprisingly-well done statue made out of bone."
	impressiveness = 10
	custom_materials = list(/datum/material/bone = MINERAL_MATERIAL_AMOUNT*5)
	abstract_type = /obj/structure/statue/bone

/obj/structure/statue/boney/ashwalker
	icon_state = "bone"
	desc = "A statue honoring Owia-Akeshi, a brave ashwalker that perished while defending the nest from a wild ash drake. May his soul rest in peace."
	impressiveness = 25

/obj/structure/statue/gargoyle
	name = "statue"
	desc = "An incredibly intricate statue, which... almost seems alive!"
	icon = 'modular_splurt/icons/obj/structures/statue.dmi'
	icon_state = "gargoyle" //empty sprite because it's supposed to copy over the overlays anyway, and otherwise, you end up with a white human male underlay beneath the statue.
	density = TRUE
	anchored = TRUE
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1
	max_integrity = 200
	var/mob/living/petrified_mob
	var/old_max_health
	var/old_size
	var/was_tilted
	var/was_lying
	var/was_lying_prev
	var/deconstructed = FALSE

/obj/structure/statue/gargoyle/Initialize(mapload, mob/living/L)
	. = ..()
	if(L)
		petrified_mob = L
		if(L.buckled)
			L.buckled.unbuckle_mob(L,force=1)
		L.visible_message(span_warning("[L]'s skin rapidly turns to stone!"), span_warning("Your skin abruptly hardens as you turn to stone once more!"))
		dir = L.dir
		transform = L.transform
		pixel_x = L.pixel_x
		pixel_y = L.pixel_y
		layer = L.layer
		was_tilted = L.is_tilted
		was_lying = L.lying
		was_lying_prev = L.lying_prev
		L.forceMove(src)
		ADD_TRAIT(L, TRAIT_MUTE, STATUE_TRAIT)
		ADD_TRAIT(L, TRAIT_MOBILITY_NOMOVE, STATUE_TRAIT)
		ADD_TRAIT(L, TRAIT_MOBILITY_NOPICKUP, STATUE_TRAIT)
		ADD_TRAIT(L, TRAIT_MOBILITY_NOUSE, STATUE_TRAIT)
		ADD_TRAIT(L, TRAIT_NOBREATH, STATUE_TRAIT)
		ADD_TRAIT(L, TRAIT_NOHUNGER, STATUE_TRAIT)
		ADD_TRAIT(L, TRAIT_NOTHIRST, STATUE_TRAIT)
		ADD_TRAIT(L, TRAIT_NOFIRE, STATUE_TRAIT) //OH GOD HELP I'M ON FIRE INSIDE THE STATUE I CAN'T MOVE AND I CAN'T STOP IT HAAAAALP - person who experienced this
		L.click_intercept = src
		L.faction += "mimic" //Stops mimics from instaqdeling people in statues
		L.status_flags |= GODMODE
		old_max_health = L.maxHealth
		old_size = get_size(L)
		obj_integrity = L.health + 100 //stoning damaged mobs will result in easier to shatter statues
		max_integrity = obj_integrity

/obj/structure/statue/gargoyle/proc/InterceptClickOn(mob/living/caller, params, atom/A) //technically could be bypassed by doing something that also uses click intercept but shrug
	var/atom/movable/screen/movable/action_button/ab = A
	if (istype(ab))
		if (istype(ab.linked_action, /datum/action/gargoyle))
			return FALSE
	var/list/modifiers = params2list(params)
	if (modifiers["shift"] && !modifiers["ctrl"] && !modifiers["middle"])
		return FALSE
	return TRUE

/obj/structure/statue/gargoyle/examine_more(mob/user) //something about the funny signals doesn't work here no matter how much I fucked around with it (ie registering to COMSIG_PARENT_EXAMINE_MORE doesn't do anything), so we have to overwrite the proc
	. = ..()
	if (petrified_mob)
		SEND_SIGNAL(petrified_mob, COMSIG_PARENT_EXAMINE, user, .)
		. -= span_notice("<i>You examine [src] closer, but find nothing of interest...</i>")

/obj/structure/statue/gargoyle/handle_atom_del(atom/A)
	if(A == petrified_mob)
		petrified_mob = null

/obj/structure/statue/gargoyle/Destroy()
	if(petrified_mob)
		petrified_mob.status_flags &= ~GODMODE
		petrified_mob.forceMove(loc)
		REMOVE_TRAIT(petrified_mob, TRAIT_MUTE, STATUE_TRAIT)
		REMOVE_TRAIT(petrified_mob, TRAIT_MOBILITY_NOMOVE, STATUE_TRAIT)
		REMOVE_TRAIT(petrified_mob, TRAIT_MOBILITY_NOPICKUP, STATUE_TRAIT)
		REMOVE_TRAIT(petrified_mob, TRAIT_MOBILITY_NOUSE, STATUE_TRAIT)
		REMOVE_TRAIT(petrified_mob, TRAIT_NOBREATH, STATUE_TRAIT)
		REMOVE_TRAIT(petrified_mob, TRAIT_NOHUNGER, STATUE_TRAIT)
		REMOVE_TRAIT(petrified_mob, TRAIT_NOTHIRST, STATUE_TRAIT)
		REMOVE_TRAIT(petrified_mob, TRAIT_NOFIRE, STATUE_TRAIT)
		petrified_mob.faction -= "mimic"
		petrified_mob.click_intercept = null
		petrified_mob.dir = dir
		petrified_mob.update_size(old_size)
		var/damage = deconstructed ? petrified_mob.health : petrified_mob.health*(old_max_health/petrified_mob.maxHealth) - obj_integrity + 100
		petrified_mob.take_overall_damage(damage) //any new damage the statue incurred is transfered to the mob
		petrified_mob.transform = transform
		petrified_mob.lying = was_lying
		petrified_mob.lying_prev = was_lying_prev
		petrified_mob.update_mobility()
		petrified_mob.pixel_x = pixel_x
		petrified_mob.pixel_y = pixel_y
		petrified_mob.layer = layer
		petrified_mob.is_shifted = TRUE //just prevents bad things tbh
		petrified_mob.is_tilted = was_tilted
		if (pulledby && pulledby.pulling == src) //gotta checked just in case
			pulledby.start_pulling(petrified_mob, supress_message = TRUE)
		var/datum/quirk/gargoyle/T = locate() in petrified_mob.roundstart_quirks
		if (T)
			T.transformed = 0
		petrified_mob = null
	return ..()

/obj/structure/statue/gargoyle/deconstruct(disassembled = TRUE)
	deconstructed = TRUE
	visible_message(span_danger("[src] shatters!"))
	qdel(src)

/obj/structure/statue/gargoyle/attackby(obj/item/W, mob/living/user, params)
	add_fingerprint(user)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(default_unfasten_wrench(user, W))
			return
		if(W.tool_behaviour == TOOL_WELDER)
			if(!W.tool_start_check(user, amount=0))
				return FALSE

			if (petrified_mob && alert(user, "You are slicing apart a gargoyle! Are you sure you want to continue? This will severely harm them, if not outright kill them.",, "Continue", "Cancel") == "Cancel")
				return

			user.visible_message(span_notice("[user] is slicing apart the [name]."), \
								span_notice("You are slicing apart the [name]..."))
			if (petrified_mob)
				to_chat(petrified_mob, span_userdanger("You are being sliced apart by [user]!"))
			if(W.use_tool(src, user, 40, volume=50))
				user.visible_message(span_notice("[user] slices apart the [name]."), \
									span_notice("You slice apart the [name]!"))
				deconstruct(TRUE)
			return
	return ..()
