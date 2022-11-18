/obj/item/clothing
	var/last_bites = 3 //Once clothes is shredded,

/obj/item/reagent_containers/food/snacks/clothing
	name = "oops"
	desc = "If you're reading this it means I messed up. This is related to moths eating clothes and I didn't know a better way to do it than making a new food object."
	list_reagents = list(/datum/reagent/consumable/nutriment = 8) //Cloth eaters get some nutrients.
	tastes = list("dust" = 1, "lint" = 1)

//A call on attemp_forcefeed() without async to properly know if it worked or not. In theory this shouldn't cause any issues as only a small part of the population should ever run this.VS normal eating.
/obj/item/reagent_containers/food/snacks/clothing/attack(mob/living/M, mob/living/user, attackchain_flags = NONE, damage_multiplier = 1)
	if(user.a_intent == INTENT_HARM)
		return ..()
	return attempt_forcefeed(M, user)


//As a bonus for having the Cloth Eater trait. You gain extra mood from eatin clothes, but damage them at the same time.
/obj/item/clothing/attack(mob/M, mob/user, def_zone)
	if(user.a_intent != INTENT_HARM)
		if(HAS_TRAIT(M,TRAIT_CLOTH_EATER))
			var/obj/item/reagent_containers/food/snacks/clothing/clothing_as_food = new
			clothing_as_food.name = name
			var/mob/living/H = M
			if(clothing_as_food.attack(M, user, def_zone)) //I need to check a player can MAWNCH clothes before I run this. Doing them at the same time lets insects eat for free.
				if(damaged_clothes == CLOTHING_SHREDDED) //Check if we need to start breaking clothes
					last_bites -= 1
					to_chat(M, "<span class='warning'>There isn't much left to eat.")
				SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "cloth_consumed", /datum/mood_event/cloth_eaten, src)
				take_damage(20, sound_effect=FALSE)
				qdel(clothing_as_food)
			if(last_bites <= 0)
				user.visible_message("<span class='notice'>[user] finishes eating the [name].")
				src.Destroy()
			return TRUE
		if((isinsect(M)))
			//Let insects chew on clothes without damaging them. This only sends out a message and does nothing.
			user.visible_message("<span class='notice'>[user] pointlessly [pick("nibbles on","chews on","bites")] the [name].")
			return TRUE
	return ..()

// Set the clothing's integrity back to 100%, remove all damage to bodyparts, and generally fix it up
/obj/item/clothing/proc/repair(mob/user, params)
	update_clothes_damaged_state(CLOTHING_PRISTINE)
	obj_integrity = max_integrity
	name = initial(name) // remove "tattered" or "shredded" if there's a prefix
	if(upgrade_prefix)
		name = upgrade_prefix + " " + initial(name)
	body_parts_covered = initial(body_parts_covered)
	slot_flags = initial(slot_flags)
	last_bites = 3
	damage_by_parts = null
	if(user)
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		to_chat(user, "<span class='notice'>You fix the damage on [src].</span>")
