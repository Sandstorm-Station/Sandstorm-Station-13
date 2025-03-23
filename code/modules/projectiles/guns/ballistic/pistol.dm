/obj/item/gun/ballistic/automatic/pistol
	name = "stechkin pistol"
	desc = "A small, easily concealable 10mm handgun. Has a threaded barrel for suppressors."
	icon_state = "pistol"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/m10mm
	can_suppress = TRUE
	burst_size = 1
	fire_delay = 0
	fire_select_modes = list(SELECT_SEMI_AUTOMATIC)
	automatic_burst_overlay = FALSE

/obj/item/gun/ballistic/automatic/pistol/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"][suppressed ? "-suppressed" : ""]"

/obj/item/gun/ballistic/automatic/pistol/suppressed/Initialize(mapload)
	. = ..()
	var/obj/item/suppressor/S = new(src)
	install_suppressor(S)

//(reskinnable stetchkin)
/obj/item/gun/ballistic/automatic/pistol/modular
	name = "modular pistol"
	desc = "A small, easily concealable 10mm handgun. Has a threaded barrel for suppressors."
	icon = 'modular_citadel/icons/obj/guns/cit_guns.dmi'
	icon_state = "cde"
	can_unsuppress = TRUE
	automatic_burst_overlay = FALSE
	obj_flags = UNIQUE_RENAME
	unique_reskin = list(
		"Default" = list("icon_state" = "cde"),
		"N-99" = list("icon_state" = "n99"),
		"Stealth" = list("icon_state" = "stealthpistol"),
		"HKVP-78" = list("icon_state" = "vp78"),
		"Luger" = list("icon_state" = "p08b"),
		"Mk.58" = list("icon_state" = "secguncomp"),
		"PX4 Storm" = list("icon_state" = "px4")
	)

/obj/item/gun/ballistic/automatic/pistol/modular/update_icon_state()
	if(current_skin)
		icon_state = "[unique_reskin[current_skin]["icon_state"]][chambered ? "" : "-e"][suppressed ? "-suppressed" : ""]"
	else
		icon_state = "[initial(icon_state)][chambered ? "" : "-e"][suppressed ? "-suppressed" : ""]"

/obj/item/gun/ballistic/automatic/pistol/modular/update_overlays()
	. = ..()
	if(magazine && suppressed)
		. += "[unique_reskin[current_skin]["icon_state"]]-magazine-sup"	//Yes, this means the default iconstate can't have a magazine overlay
	else if (magazine)
		. += "[unique_reskin[current_skin]["icon_state"]]-magazine"

/obj/item/gun/ballistic/automatic/pistol/m1911
	name = "\improper M1911"
	desc = "A classic .45 handgun with a small magazine capacity. Has a threaded barrel for suppressors."
	icon_state = "m1911"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/m45

/obj/item/gun/ballistic/automatic/pistol/m1911/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/m1911/kitchengun
	name = "\improper Kitchen Gun (TM)"
	desc = "Say goodbye to dirt with Kitchen Gun (TM)! Laser sight and night vision accessories sold separately."
	icon_state = "kitchengun"
	can_suppress = FALSE
	mag_type = /obj/item/ammo_box/magazine/m45/kitchengun

/obj/item/gun/ballistic/automatic/pistol/deagle
	name = "\improper Desert Eagle"
	desc = "A robust .50 AE handgun."
	icon_state = "deagle"
	force = 14
	mag_type = /obj/item/ammo_box/magazine/m50
	can_suppress = FALSE
	automatic_burst_overlay = FALSE

/obj/item/gun/ballistic/automatic/pistol/deagle/update_overlays()
	. = ..()
	if(magazine)
		. += "deagle_magazine"

/obj/item/gun/ballistic/automatic/pistol/deagle/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/pistol/deagle/gold
	desc = "A gold plated Desert Eagle folded over a million times by superior martian gunsmiths. Uses .50 AE ammo."
	icon_state = "deagleg"
	item_state = "deagleg"

/obj/item/gun/ballistic/automatic/pistol/deagle/camo
	desc = "A Deagle brand Deagle for operators operating operationally. Uses .50 AE ammo."
	icon_state = "deaglecamo"
	item_state = "deagleg"

/obj/item/gun/ballistic/automatic/pistol/APS
	name = "stechkin APS pistol"
	desc = "The original Russian version of a widely used Syndicate sidearm. Uses 9mm ammo. Has a threaded barrel for suppressors."
	icon_state = "aps"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/pistolm9mm
	burst_size = 3
	fire_delay = 2
	fire_select_modes = list(SELECT_SEMI_AUTOMATIC, SELECT_BURST_SHOT, SELECT_FULLY_AUTOMATIC)

/obj/item/gun/ballistic/automatic/pistol/stickman
	name = "flat gun"
	desc = "A 2 dimensional gun.. what?"
	can_suppress = FALSE
	icon_state = "flatgun"

/obj/item/gun/ballistic/automatic/pistol/stickman/pickup(mob/living/user)
	. = ..()
	to_chat(user, "<span class='notice'>As you try to pick up [src], it slips out of your grip..</span>")
	if(prob(50))
		to_chat(user, "<span class='notice'>..and vanishes from your vision! Where the hell did it go?</span>")
		qdel(src)
		user.update_icons()
	else
		to_chat(user, "<span class='notice'>..and falls into view. Whew, that was a close one.</span>")
		user.dropItemToGround(src)

////////////Anti Tank Pistol////////////

/obj/item/gun/ballistic/automatic/pistol/antitank
	name = "Anti Tank Pistol"
	desc = "A massively impractical and silly monstrosity of a pistol that fires .50 calliber rounds. The recoil is likely to dislocate your wrist."
	icon = 'modular_citadel/icons/obj/guns/cit_guns.dmi'
	icon_state = "atp"
	item_state = "pistol"
	recoil = 4
	mag_type = /obj/item/ammo_box/magazine/sniper_rounds
	fire_delay = 50
	burst_size = 1
	can_suppress = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	fire_select_modes = list(SELECT_SEMI_AUTOMATIC)
	fire_sound = 'sound/weapons/noscope.ogg'
	spread = 20		//damn thing has no rifling.
	automatic_burst_overlay = FALSE

/obj/item/gun/ballistic/automatic/pistol/antitank/update_overlays()
	. = ..()
	if(magazine)
		. += "atp-mag"

/obj/item/gun/ballistic/automatic/pistol/antitank/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/pistol/antitank/syndicate
	name = "Syndicate Anti Tank Pistol"
	desc = "A massively impractical and silly monstrosity of a pistol that fires .50 calliber rounds. The recoil is likely to dislocate a variety of joints without proper bracing."
	pin = /obj/item/firing_pin/implant/pindicate

/obj/item/gun/ballistic/automatic/pistol/m1911
	icon = 'modular_sand/icons/obj/guns/projectile.dmi'
	can_flashlight = 1
	flight_x_offset = 19
	flight_y_offset = 15

/obj/item/gun/ballistic/automatic/pistol/m1911/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"


/obj/item/gun/ballistic/automatic/pistol/enforcer
	name = "\improper Mk. 58 Enforcer (.45)"
	desc = "A polymer frame pistol made by Nanotreason. Won't show up on Space port X-rays and cost more then you make in a month."
	icon = 'modular_sand/icons/obj/guns/projectile.dmi'
	icon_state = "enforcer_black"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/e45
	can_suppress = FALSE
	can_flashlight = 1
	flight_x_offset = 18
	flight_y_offset = 14
	obj_flags = UNIQUE_RENAME

	unique_reskin = list(
		"Default" = list("icon_state" = "enforcer_black"),
		"M2611 Enforcer" = list("icon_state" = "cde"),
		"M1911 Enforcer" = list("icon_state" = "m1911"),
		"VP78 Enforcer" = list("icon_state" = "vp78"),
		"USP Enforcer" = list("icon_state" = "usp-m")
	)

/obj/item/gun/ballistic/automatic/pistol/enforcer/update_icon_state()
	if(current_skin)
		icon_state = "[unique_reskin[current_skin]["icon_state"]][chambered ? "" : "-e"]"
	else
		icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/pistol/enforcer/nomag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/enforcerred
	name = "\improper HOS's Mk. 58 Enforcer (.45)"
	desc = "A polymer frame pistol made by Nanotreason. Won't show up on Space port X-rays and cost more then you make in a month. Respect mah Authorita!"
	icon = 'modular_sand/icons/obj/guns/projectile.dmi'
	icon_state = "enforcer_red"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/e45
	can_suppress = FALSE
	can_flashlight = 1
	flight_x_offset = 18
	flight_y_offset = 14

/obj/item/gun/ballistic/automatic/pistol/enforcerred/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"


/obj/item/gun/ballistic/automatic/pistol/enforcergold
	name = "\improper Gold Mk. 58 Enforcer (.45)"
	desc = "A titianium gold plated Enforcer. A vulger display of power. A show of force in a public execution."
	icon = 'modular_sand/icons/obj/guns/projectile.dmi'
	icon_state = "enforcer_gold"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/e45
	can_suppress = FALSE
	can_flashlight = 1
	flight_x_offset = 18
	flight_y_offset = 14

/obj/item/gun/ballistic/automatic/pistol/enforcergold/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/pistol/m9mmpistol
	name = "\improper Cheap 9mm Handgun"
	desc = "An extremly cheap 9mm handgun produced by M&A Firearms."
	icon = 'modular_sand/icons/obj/guns/projectile.dmi'
	icon_state = "ninemil"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/m9
	can_suppress = FALSE
	obj_flags = UNIQUE_RENAME
	unique_reskin = list(
		"Default" = list("icon_state" = "ninemil"),
		"Maria" = list("icon_state" = "maria")
	)

/obj/item/gun/ballistic/automatic/pistol/m9mmpistol/update_icon_state()
	if(current_skin)
		icon_state = "[unique_reskin[current_skin]["icon_state"]][chambered ? "" : "-e"]"
	else
		icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/pistol/m9mmpistol/nomag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/m22pistol
	name = "\improper Cheap .22 Handgun"
	desc = "An extremly cheap .22 handgun produced by a Martain weapons maker. Great for mouse hunting, not much else."
	icon = 'modular_sand/icons/obj/guns/projectile.dmi'
	icon_state = "silenced22"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/m22
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/pistol/m22pistol/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"


/obj/item/gun/ballistic/automatic/pistol/deagle
	name = "\improper Desert Eagle (.50 AE)"


/obj/item/gun/ballistic/automatic/pistol/deagle2
	name = "\improper Desert Eagle (.357)"
	desc = "A robust .357 Magnum handgun."
	icon_state = "deagle"
	force = 14
	mag_type = /obj/item/ammo_box/magazine/m357
	can_suppress = FALSE
	automatic_burst_overlay = FALSE
	obj_flags = UNIQUE_RENAME

	unique_reskin = list(
		"Default" = list("icon_state" = "deagle"),
		"Desert Eagle Gold" = list("icon_state" = "deagleg"),
		"Desert Eagle Camo" = list("icon_state" = "deaglecamo")
	)

/obj/item/gun/ballistic/automatic/pistol/deagle2/update_overlays()
	. = ..()
	if(magazine)
		. += "deagle_magazine"

/obj/item/gun/ballistic/automatic/pistol/deagle2/update_icon_state()
	if(current_skin)
		icon_state = "[unique_reskin[current_skin]["icon_state"]][chambered ? "" : "-e"]"
	else
		icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/pistol/deagle2/nomag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/luger/mag
	spawnwithmagazine = TRUE