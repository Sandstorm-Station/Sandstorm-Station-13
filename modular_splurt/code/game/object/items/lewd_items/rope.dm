#define ROPE_STATE_UNTIED 0
#define ROPE_STATE_DECIDING_OBJECT 1
#define ROPE_STATE_TIED 2

#define ROPE_TARGET_LEGS 0
#define ROPE_TARGET_HANDS 1
#define ROPE_TARGET_LEGS_OBJECT 2
#define ROPE_TARGET_HANDS_OBJECT 3

#define ROPE_OBJECT_IMMOVABLE 0
#define ROPE_OBJECT_MOVABLE 1

#define ROPE_MAX_DISTANCE_OBJECT 1
#define ROPE_MAX_DISTANCE_MASTER 2
#define ROPE_MAX_DISTANCE_SNAP 4
#define ROPE_OBJECT_IMMOVABLE_SLOWDOWN 32
#define ROPE_SELF_APPLY_INSTANT 0

GLOBAL_LIST_INIT(bondage_rope_targets, list(
	"Legs"				= ROPE_TARGET_LEGS,
	"Hands"				= ROPE_TARGET_HANDS,
	"Legs (to object)"	= ROPE_TARGET_LEGS_OBJECT,
	"Hands (to object)"	= ROPE_TARGET_HANDS_OBJECT
	))
GLOBAL_LIST_INIT(bondage_rope_objects, list(
	/obj/structure/chair = ROPE_OBJECT_MOVABLE,
	/obj/structure/table = ROPE_OBJECT_MOVABLE,
	/obj/structure/bed = ROPE_OBJECT_IMMOVABLE,
	/obj/machinery/portable_atmospherics/canister = ROPE_OBJECT_IMMOVABLE,
	/obj/machinery/atmospherics/pipe = ROPE_OBJECT_IMMOVABLE,
	/obj/structure/reagent_dispensers/watertank = ROPE_OBJECT_IMMOVABLE,
	/obj/structure/reagent_dispensers/fueltank = ROPE_OBJECT_IMMOVABLE,
	/obj/structure/flora/tree = ROPE_OBJECT_IMMOVABLE
))
GLOBAL_LIST_INIT(bondage_rope_slowdowns, list(
	/obj/structure/chair = 8,
	/obj/structure/table = 16,
	/obj/structure/bed = ROPE_OBJECT_IMMOVABLE_SLOWDOWN,
	/obj/machinery/portable_atmospherics/canister = ROPE_OBJECT_IMMOVABLE_SLOWDOWN,
	/obj/machinery/atmospherics/pipe = ROPE_OBJECT_IMMOVABLE_SLOWDOWN,
	/obj/structure/reagent_dispensers/watertank = ROPE_OBJECT_IMMOVABLE_SLOWDOWN,
	/obj/structure/reagent_dispensers/fueltank = ROPE_OBJECT_IMMOVABLE_SLOWDOWN,
	/obj/structure/flora/tree = ROPE_OBJECT_IMMOVABLE_SLOWDOWN
))

/obj/item/restraints/bondage_rope
	name = "bondage rope"
	desc = "A rope designed to not cut into one's skin, the perfect thing for tying someone up."
	icon = 'modular_splurt/icons/obj/rope.dmi'
	icon_state = "rope"
	item_state = "rope"
	color = "#db74c5"
	w_class = WEIGHT_CLASS_SMALL
	breakouttime = 600 //Deciseconds = 60s = 1 minute
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 50, ACID = 50)
	// TODO: change sound
	var/cuffsound = 'sound/weapons/handcuffs.ogg'
	var/rope_target = ROPE_TARGET_HANDS
	var/rope_state = ROPE_STATE_UNTIED
	var/mob/living/carbon/roped_master = null
	var/mob/living/carbon/roped_mob = null
	var/obj/roped_object = null
	var/roped_object_type = null

// Handles initial rope checks and then calls process_knot
/obj/item/restraints/bondage_rope/attack(mob/living/carbon/C, mob/living/user)
	if(!istype(C))
		return
	if(rope_state == ROPE_STATE_DECIDING_OBJECT)
		reset_rope_state()
		forceMove(user.loc)

	switch(rope_target)
		if(ROPE_TARGET_HANDS, ROPE_TARGET_HANDS_OBJECT)
			if(C.handcuffed)
				to_chat(user, "<span class='warning'>[C] is already handcuffed...</span>")
				return
			if(C.get_num_arms(FALSE) < 2 && !C.get_arm_ignore())
				to_chat(user, "<span class='warning'>[C] doesn't have two hands...</span>")
				return
			C.visible_message("<span class='danger'>[user] is trying to tie [C]'s hands!</span>", \
								"<span class='userdanger'>[user] is trying to tie [C]'s hands!</span>")
			process_knot(C, user)
			
		if(ROPE_TARGET_LEGS, ROPE_TARGET_LEGS_OBJECT)
			if(C.legcuffed)
				to_chat(user, "<span class='warning'>[C] is already legcuffed...</span>")
				return
			if(C.get_num_legs(FALSE) < 2 && !C.get_leg_ignore())
				to_chat(user, "<span class='warning'>[C] doesn't have two legs...</span>")
				return
			C.visible_message("<span class='danger'>[user] is trying to tie [C]'s legs!</span>", \
								"<span class='userdanger'>[user] is trying to tie [C]'s legs!</span>")
			process_knot(C, user)

// Handles deciding objects in ROPE_STATE_DECIDING_OBJECT state
// If rope is attached to an object calls finish_knot_object
/obj/item/restraints/bondage_rope/attack_obj(obj/O, mob/user)
	if((rope_target != ROPE_TARGET_LEGS_OBJECT && rope_target != ROPE_TARGET_HANDS_OBJECT))
		return
	if(rope_state == ROPE_STATE_TIED)
		to_chat(user, "<span class='notice'>The rope is already tied to somebody.</span>")
		return
	if(roped_mob == null)
		to_chat(user, "<span class='notice'>You need to attach the rope to somebody first.</span>")
		return
	// Might be reduntant, since the roped mob gets pulled, but meh
	var/distance = get_dist(user, roped_mob)
	if(distance > ROPE_MAX_DISTANCE_MASTER)
		to_chat(user, "<span class='warning'>The rope isn't long enough to tie a knot.</span>")
		return
	
	// TODO: make this work with tables (right now rope just gets put on top)
	// either set rope as abstract or AfterPutItemOnTable patch or idk
	for(var/type in GLOB.bondage_rope_objects)
		if(istype(O, type))
			finish_knot_object(O, type)

// Handles the initial knot on the target (including the timeout) and calls after_process_knot
/obj/item/restraints/bondage_rope/proc/process_knot(mob/living/carbon/C, mob/living/user)
	switch(rope_target)
		if(ROPE_TARGET_HANDS, ROPE_TARGET_HANDS_OBJECT)
			if(do_mob(user, C, 30) && (C.get_num_arms(FALSE) >= 2 || C.get_arm_ignore()))
				playsound(loc, cuffsound, 30, 1, -2)
				to_chat(user, "<span class='notice'>You tie [C]'s hands.</span>")
				SSblackbox.record_feedback("tally", "handcuffs", 1, type)
				log_combat(user, C, "handcuffed")
				after_process_knot(C, user)
			else
				to_chat(user, "<span class='warning'>You fail to tie [C]'s hands!</span>")
		if(ROPE_TARGET_LEGS, ROPE_TARGET_LEGS_OBJECT)
			if(do_mob(user, C, 30) && (C.get_num_legs(FALSE) >= 2 || C.get_leg_ignore()))
				playsound(loc, cuffsound, 30, 1, -2)
				to_chat(user, "<span class='notice'>You tie [C]'s legs.</span>")
				SSblackbox.record_feedback("tally", "handcuffs", 1, type)
				log_combat(user, C, "handcuffed")
				after_process_knot(C, user)
			else
				to_chat(user, "<span class='warning'>You fail to tie [C]'s legs!</span>")

// > Using normal rope, calls finish_knot_normal
// > Using object rope, handles the handcuffed effect (unless instant self apply is disabled) and sets state to ROPE_STATE_DECIDING_OBJECT
/obj/item/restraints/bondage_rope/proc/after_process_knot(mob/living/carbon/C, mob/living/user)
	switch(rope_target)
		if(ROPE_TARGET_HANDS, ROPE_TARGET_LEGS)
			finish_knot_normal(C, user)
			return
		if(ROPE_TARGET_HANDS_OBJECT)
			if(C != user || ROPE_SELF_APPLY_INSTANT)
				apply_hands(C)
		if(ROPE_TARGET_LEGS_OBJECT)
			if(C != user || ROPE_SELF_APPLY_INSTANT)
				apply_legs(C)
	
	rope_state = ROPE_STATE_DECIDING_OBJECT
	set_roped_mob(C)
	set_roped_master(user)
	to_chat(roped_master, "<span class='notice'>Attach the rope to an object to finish the knot.</span>")
	while(1)
		sleep(2)
		if(rope_state == ROPE_STATE_UNTIED)
			break
		if(!check_rope_state())
			break

// Sets state to ROPE_STATE_TIED, applies handcuffed effect and deletes rope
/obj/item/restraints/bondage_rope/proc/finish_knot_normal(mob/living/carbon/target, mob/living/carbon/user)
	rope_state = ROPE_STATE_TIED
	if(!user.temporarilyRemoveItemFromInventory(src))
		reset_rope_state()
		return
	switch(rope_target)
		if(ROPE_TARGET_HANDS)
			apply_hands(target)
		if(ROPE_TARGET_LEGS)
			apply_legs(target)
	forceMove(target)
	
// Sets state to ROPE_STATE_TIED, applies handcuffed effect (if needed) and deletes rope
/obj/item/restraints/bondage_rope/proc/finish_knot_object(obj/O, O_type)
	rope_state = ROPE_STATE_TIED
	if(!roped_master.temporarilyRemoveItemFromInventory(src))
		reset_rope_state()
		return
	if(roped_master == roped_mob && !ROPE_SELF_APPLY_INSTANT)
		switch(rope_target)
			if(ROPE_TARGET_HANDS_OBJECT)
				apply_hands(roped_mob)
			if(ROPE_TARGET_LEGS_OBJECT)
				apply_legs(roped_mob)
	forceMove(roped_mob)

	set_roped_master(null)
	set_roped_object(O, O_type)
	to_chat(roped_mob, "<span class='warning'>You are tied to [O].</span>")
	to_chat(roped_master, "<span class='notice'>You tie the rope to [O].</span>")
	apply_tug_mob_to_object(roped_mob, roped_object, ROPE_MAX_DISTANCE_OBJECT)

// Handles a number of edge cases, if something goes wrong resets the rope state and returns false
/obj/item/restraints/bondage_rope/proc/check_rope_state()
	if(rope_state == ROPE_STATE_UNTIED)
		return TRUE
	
	if(roped_mob == null)
		if(roped_master != null)
			to_chat(roped_master, "<span class='warning'>Seems like whoever you were roping... Is gone?</span>")
		reset_rope_state()
		return FALSE
	if(rope_state == ROPE_STATE_TIED || (roped_master != roped_mob || ROPE_SELF_APPLY_INSTANT))
		if(rope_target == ROPE_TARGET_HANDS_OBJECT && !roped_mob.handcuffed)
			if(roped_master != null)
				to_chat(roped_master, "<span class='warning'>[roped_mob] got out of your rope.</span>")
			reset_rope_state()
			return FALSE
		if(rope_target == ROPE_TARGET_LEGS_OBJECT && !roped_mob.legcuffed)
			if(roped_master != null)
				to_chat(roped_master, "<span class='warning'>[roped_mob] got out of your rope.</span>")
			reset_rope_state()
			return FALSE

	switch(rope_state)
		if(ROPE_STATE_TIED)
			if(roped_object == null)
				to_chat(roped_mob, "<span class='warning'>The thing you were tied to... Is gone?</span>")
				reset_rope_state()
				return FALSE
	
	return TRUE

// Restores the rope into the initial state
/obj/item/restraints/bondage_rope/proc/reset_rope_state()
	rope_state = ROPE_STATE_UNTIED
	set_roped_master(null)
	set_roped_mob(null)
	set_roped_object(null)

// Handles whenever roped master moves, tugging their tied mob to them (isn't called whenever roped master is roped mob!)
/obj/item/restraints/bondage_rope/proc/on_master_move()
	if(!check_rope_state())
		return
	var/distance = get_dist(roped_mob.loc, roped_master.loc)
	if(distance > ROPE_MAX_DISTANCE_MASTER)
		apply_tug_mob_to_mob(roped_mob, roped_master, ROPE_MAX_DISTANCE_MASTER)
		roped_mob.apply_effect(20, EFFECT_KNOCKDOWN, 0)
	if(distance > ROPE_MAX_DISTANCE_SNAP)
		snap_rope()

// Handles whenever roped object moves, tugging their tied mob to it
/obj/item/restraints/bondage_rope/proc/on_object_move()
	if(!check_rope_state())
		return
	var/distance = get_dist(roped_mob.loc, roped_object.loc)
	if(distance > ROPE_MAX_DISTANCE_OBJECT)
		apply_tug_mob_to_object(roped_mob, roped_object, ROPE_MAX_DISTANCE_OBJECT)
		roped_mob.apply_effect(20, EFFECT_KNOCKDOWN, 0)
	if(distance > ROPE_MAX_DISTANCE_SNAP)
		snap_rope()

// Handles whenever roped mob moves, tugging them to their master, their object to them or them to their object
/obj/item/restraints/bondage_rope/proc/on_mob_move()
	if(!check_rope_state())
		return
	switch(rope_state)
		if(ROPE_STATE_DECIDING_OBJECT)
			if(roped_master != null)
				var/distance = get_dist(roped_mob.loc, roped_master.loc)
				if(distance > ROPE_MAX_DISTANCE_MASTER)
					to_chat(roped_mob, "<span class='warning'>The rope doesn't let you to go further.</span>")
					apply_tug_mob_to_mob(roped_mob, roped_master, ROPE_MAX_DISTANCE_MASTER)
					distance = get_dist(roped_mob.loc, roped_master.loc)

					// TODO: a chance to break free, tugging the rope away from the master, instead of getting tugged to the master
					// to_chat(roped_mob, "<span class='warning'>You tug the rope away from [roped_master].</span>")
					// to_chat(roped_master, "<span class='warning'>[roped_mob] tugs the rope away from you.</span>")
				if(distance > ROPE_MAX_DISTANCE_SNAP)
					snap_rope()
			else
				var/distance = get_dist(roped_mob.loc, src.loc)
				if(distance > ROPE_MAX_DISTANCE_MASTER)
					apply_tug_object_to_mob(src, roped_mob, ROPE_MAX_DISTANCE_MASTER)
					distance = get_dist(roped_mob.loc, src.loc)
				if(distance > ROPE_MAX_DISTANCE_SNAP)
					snap_rope()

		if(ROPE_STATE_TIED)
			var/can_move = can_move_object()
			var/distance = get_dist(roped_mob.loc, roped_object.loc)
			if(distance > ROPE_MAX_DISTANCE_OBJECT)
				if(can_move)
					apply_tug_object_to_mob(roped_object, roped_mob, ROPE_MAX_DISTANCE_OBJECT)
				else
					to_chat(roped_mob, "<span class='warning'>The rope doesn't let you to go further.</span>")
					apply_tug_mob_to_object(roped_mob, roped_object, ROPE_MAX_DISTANCE_OBJECT)
				distance = get_dist(roped_mob.loc, roped_object.loc)
			if(distance > ROPE_MAX_DISTANCE_SNAP)
				snap_rope()

/obj/item/restraints/bondage_rope/proc/snap_rope()
	var/loc = null
	if(roped_master != null)
		to_chat(roped_master, "<span class='warning'>The rope snaps.</span>")
		loc = roped_master.loc
	if(roped_mob != null)
		to_chat(roped_mob, "<span class='warning'>The rope snaps.</span>")
		loc = roped_mob.loc
	reset_rope_state()
	forceMove(loc)

/obj/item/restraints/bondage_rope/Destroy()
	reset_rope_state()
	return ..()

/obj/item/restraints/bondage_rope/dropped(mob/user, silent)
	if(rope_state == ROPE_STATE_DECIDING_OBJECT)
		set_roped_master(null)
	..()

/obj/item/restraints/bondage_rope/pickup(mob/user)
	if(rope_state == ROPE_STATE_DECIDING_OBJECT)
		set_roped_master(user)
	..()

// Taken from handcuffs code
/obj/item/restraints/bondage_rope/proc/apply_hands(mob/living/carbon/target)
	if(target == null || target.handcuffed != null)
		return
	target.handcuffed = src
	target.update_handcuffed()
	
// Taken from handcuffs code
/obj/item/restraints/bondage_rope/proc/apply_legs(mob/living/carbon/target)
	if(target == null || target.legcuffed != null)
		return
	target.legcuffed = src
	target.update_equipment_speed_mods()
	target.update_inv_legcuffed()

// Handles differing breakout times and cuffbreak (hands free removes rope faster, wirecutters even better)
/obj/item/restraints/bondage_rope/proc/prepare_resist()
	switch(rope_target)
		if(ROPE_TARGET_HANDS, ROPE_TARGET_HANDS_OBJECT)
			breakouttime = 600
		if(ROPE_TARGET_LEGS, ROPE_TARGET_LEGS_OBJECT)
			breakouttime = roped_mob.handcuffed != null ? 600 : 300
	if(roped_mob.handcuffed == null && istype(roped_mob.get_active_held_item(), /obj/item/wirecutters))
		return FAST_CUFFBREAK

	return 0

// Handles changing between different rope targets
/obj/item/restraints/bondage_rope/AltClick(mob/living/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	customize_rope(user)
	return TRUE

/obj/item/restraints/bondage_rope/proc/customize_rope(mob/living/user)
	if(rope_state != ROPE_STATE_UNTIED)
		to_chat(user, "<span class='warning'>You cannot customize a tied rope.</span>")
		return

	if(src && !user.incapacitated() && in_range(user, src))
		var/target_choice = input(user,"Choose a target for your rope.", "Rope Target") as null|anything in GLOB.bondage_rope_targets
		if(src && target_choice && !user.incapacitated() && in_range(user,src))
			sanitize_inlist(target_choice, GLOB.bondage_rope_targets, "Legs")
			rope_target = GLOB.bondage_rope_targets[target_choice]
	
/obj/item/restraints/bondage_rope/proc/set_roped_mob(mob/living/carbon/new_mob)
	if(roped_mob != null)
		UnregisterSignal(roped_mob, COMSIG_MOVABLE_MOVED)
		if(roped_mob.handcuffed == src)
			roped_mob.clear_cuffs(roped_mob.handcuffed, 0)
		else if(roped_mob.legcuffed == src)
			roped_mob.clear_cuffs(roped_mob.legcuffed, 0)
	roped_mob = new_mob
	if(new_mob != null)
		RegisterSignal(roped_mob, COMSIG_MOVABLE_MOVED, .proc/on_mob_move)

/obj/item/restraints/bondage_rope/proc/set_roped_master(mob/living/carbon/new_master)
	if(roped_master != null && roped_mob != roped_master)
		UnregisterSignal(roped_master, COMSIG_MOVABLE_MOVED)
	roped_master = new_master
	if(roped_master != null && roped_mob != roped_master)
		RegisterSignal(roped_master, COMSIG_MOVABLE_MOVED, .proc/on_master_move)

/obj/item/restraints/bondage_rope/proc/set_roped_object(obj/new_object, new_object_type)
	if(roped_object != null)
		UnregisterSignal(roped_object, COMSIG_MOVABLE_MOVED)
	roped_object = new_object
	roped_object_type = new_object_type
	set_rope_slowdown()
	if(roped_object != null)
		RegisterSignal(roped_object, COMSIG_MOVABLE_MOVED, .proc/on_object_move)

// Returns true, if roped mob can tug their object behind them
/obj/item/restraints/bondage_rope/proc/can_move_object()
	if(roped_object == null)
		return FALSE
	switch(roped_object_type)
		if(/obj/structure/chair)
			// Might add more exceptions, not sure
			if(istype(roped_object, /obj/structure/chair/sofa) || istype(roped_object, /obj/structure/chair/pew))
				return FALSE
			return TRUE
		if(/obj/structure/table)
			var/obj/structure/table/table = roped_object
			var/list/tables = table.connected_floodfill(1)
			return LAZYLEN(tables) < 1

	return GLOB.bondage_rope_objects[roped_object_type] == ROPE_OBJECT_MOVABLE

// Handles changing slowdown based on roped object
/obj/item/restraints/bondage_rope/proc/set_rope_slowdown()
	if(roped_object == null)
		slowdown = 0
	else
		slowdown = GLOB.bondage_rope_slowdowns[roped_object_type]
	if(roped_mob != null)
		roped_mob.update_equipment_speed_mods()
