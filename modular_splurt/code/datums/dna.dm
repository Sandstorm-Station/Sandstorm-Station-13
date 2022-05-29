/datum/dna
	var/last_capped_size //For some reason this feels dirty... I suppose it should go somewhere else

/datum/dna/update_body_size(old_size)
	if(!holder || features["body_size"] == old_size)
		return ..()

	holder.remove_movespeed_modifier(/datum/movespeed_modifier/small_stride) //Remove our own modifier

	. = ..()

	//Handle the small icon
	if(!holder.small_sprite)
		holder.small_sprite = new(holder)

	if(get_size(holder) >= (RESIZE_A_BIGNORMAL + RESIZE_NORMAL) / 2)
		holder.small_sprite.Grant(holder)
	else
		holder.small_sprite.Remove(holder)

	if(!iscarbon(holder))
		return

	//Bigger bits
	var/mob/living/carbon/C = holder
	for(var/obj/item/organ/genital/cocc in C.internal_organs)
		if(istype(cocc))
			cocc.update()

	///Penalties start
	if(CONFIG_GET(flag/old_size_penalties))
		return

	//Undo the cit penalties
	var/penalty_threshold = CONFIG_GET(number/threshold_body_size_penalty)
	if(features["body_size"] < penalty_threshold && old_size >= penalty_threshold)
		C.maxHealth  += 10
		holder.remove_movespeed_modifier(/datum/movespeed_modifier/small_stride)
	else if(old_size < penalty_threshold && features["body_size"] >= penalty_threshold)
		C.maxHealth -= 10

	//Calculate new slowdown
	var/new_slowdown = (abs(get_size(holder) - 1) * CONFIG_GET(number/body_size_slowdown_multiplier))
	holder.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/small_stride, TRUE, new_slowdown)

	//New health
	var/size_cap = CONFIG_GET(number/macro_health_cap)
	if((size_cap > 0) && (get_size(holder) > size_cap))
		last_capped_size = (last_capped_size ? last_capped_size : old_size)
		return
	if(last_capped_size)
		old_size = last_capped_size
		last_capped_size = null
	var/healthmod_old = ((old_size * 75) - 75) //Get the old value to see what we must change.
	var/healthmod_new = ((get_size(holder) * 75) - 75) //A size of one would be zero. Big boys get health, small ones lose health.
	var/healthchange = healthmod_new - healthmod_old //Get ready to apply the new value, and subtract the old one. (Negative values become positive)
	holder.maxHealth += healthchange
	holder.health += healthchange
