#define ui_hunger_thirst "EAST-1:28,CENTER+1:51"

/obj/screen/hunger
	name = "hunger"
	icon = 'modular_sand/icons/mob/screen_gen.dmi'
	icon_state = "nutrition0"
	screen_loc = ui_hunger_thirst

/obj/screen/thirst
	name = "thirst"
	icon = 'modular_sand/icons/mob/screen_gen.dmi'
	icon_state = "hydration0"
	screen_loc = ui_hunger_thirst

/obj/screen/healthdoll/Click(location, control, params)
	var/mob/living/L = usr
	usr.Click(L, control, params)
	return FALSE	//The health doll doesn't really do anything on it's own, change this if you need to
