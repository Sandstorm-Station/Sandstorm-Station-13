/mob/living/carbon/human
	var/nail_style = null
	var/nail_color = "white"
	var/cheesed //Handle cheesing lol

/mob/living/carbon/human/Initialize()
	LAZYADD(hud_possible, ANTAGTARGET_HUD)
	. = ..()
