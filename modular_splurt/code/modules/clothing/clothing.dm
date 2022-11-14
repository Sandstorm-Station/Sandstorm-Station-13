/obj/item/reagent_containers/food/snacks/clothing
	name = "oops"
	desc = "If you're reading this it means I messed up. This is related to moths eating clothes and I didn't know a better way to do it than making a new food object."
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	tastes = list("dust" = 1, "lint" = 1)
/*
/obj/item/clothing/attack(mob/M, mob/user, def_zone)
	if(user.a_intent != INTENT_HARM && (isinsect(M)||HAS_TRAIT(M,TRAIT_CLOTH_EATER)))
		var/obj/item/reagent_containers/food/snacks/clothing/clothing_as_food = new
		clothing_as_food.name = name
		var/mob/living/carbon/human/H = M
		if(HAS_TRAIT(M,TRAIT_CLOTH_EATER))
			to_chat(user, "We should be damaging clothes")
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "cloth_consumed", /datum/mood_event/cloth_eaten, src)
			take_damage(15, sound_effect=FALSE)
		qdel(clothing_as_food)
	else
		return ..()
*/
