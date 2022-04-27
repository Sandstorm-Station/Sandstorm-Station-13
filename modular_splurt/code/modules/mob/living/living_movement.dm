/mob
	var/layer_priority

/mob/living/layershift_up()
	. = ..()
	src.layer_priority = FLOOR((layer - MOB_LAYER) * 100, 1)

/mob/living/layershift_down()
	. = ..()
	src.layer_priority = FLOOR((layer - MOB_LAYER) * 100, 1)
