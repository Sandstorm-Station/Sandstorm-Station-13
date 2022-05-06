/*
/mob/living/update_size(new_size)
	. = ..()
	if(!small_sprite)
		small_sprite = new(src)

	if(new_size >= (RESIZE_A_BIGNORMAL + RESIZE_NORMAL) / 2)
		small_sprite.Grant(src)
	else
		small_sprite.Remove(src)
*/
