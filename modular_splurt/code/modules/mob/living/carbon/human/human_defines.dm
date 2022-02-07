/mob/living/carbon/human
	var/nail_style = null
	var/nail_color = "white"

/mob/living/carbon/human/Initialize()
	LAZYADD(hud_possible, ANTAGTARGET_HUD)
	. = ..()
