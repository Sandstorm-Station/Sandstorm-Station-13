/obj/item/reagent_containers/food/snacks/clothing
	name = "oops"
	desc = "If you're reading this it means I messed up. This is related to moths eating clothes and I didn't know a better way to do it than making a new food object."
	list_reagents = list(/datum/reagent/consumable/nutriment = 8) //Cloth eaters get some nutrients.
	tastes = list("dust" = 1, "lint" = 1)

//A call on attemp_forcefeed() without async to properly know if it worked or not. In theory this shouldn't cause any issues as only a small part of the population should ever run this.VS normal eating.
/obj/item/reagent_containers/food/snacks/clothing/attack(mob/living/M, mob/living/user, attackchain_flags = NONE, damage_multiplier = 1)
	if(user.a_intent == INTENT_HARM)
		return ..()
	if(attempt_forcefeed(M, user) == 1)
		return TRUE
	else
		return FALSE

//As a bonus for having the Cloth Eater trait. You gain extra mood from eatin clothes, but damage them at the same time.
/obj/item/clothing/attack(mob/M, mob/user, def_zone)
	if(user.a_intent != INTENT_HARM)
		if(HAS_TRAIT(M,TRAIT_CLOTH_EATER))
			var/obj/item/reagent_containers/food/snacks/clothing/clothing_as_food = new
			clothing_as_food.name = name
			var/mob/living/H = M
			if(clothing_as_food.attack(M, user, def_zone)) //I need to check a player can MAWNCH clothes before I run this. Doing them at the same time lets insects eat for free.
				SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "cloth_consumed", /datum/mood_event/cloth_eaten, src)
				take_damage(20, sound_effect=FALSE)
				qdel(clothing_as_food)
			return TRUE
		if((isinsect(M)))
			//Let insects chew on clothes without damaging them. This only sends out a message and does nothing.
			user.visible_message("<span class='notice'>[user] pointlessly [pick("nibbles on","chews on","bites")] the [name].")
			return TRUE
	.=..()
