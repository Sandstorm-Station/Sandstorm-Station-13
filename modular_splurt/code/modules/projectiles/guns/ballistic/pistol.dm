/obj/item/gun/ballistic/automatic/pistol/m1911
	can_flashlight = 1
	flight_x_offset = 19
	flight_y_offset = 15

/obj/item/gun/ballistic/automatic/pistol/m1911/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"


/obj/item/gun/ballistic/automatic/pistol/enforcer
	name = "\improper Mk. 58 Enforcer"
	desc = "A polymer frame pistol made by Nanotreason. Won't show up on Space port X-rays and cost more then you make in a month."
	icon = 'modular_splurt/icons/obj/guns/projectile.dmi'
	icon_state = "enforcer_black"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/e45
	can_suppress = FALSE
	can_flashlight = 1
	flight_x_offset = 18
	flight_y_offset = 14
	obj_flags = UNIQUE_RENAME

	unique_reskin = list("Default" = "enforcer_black",
						"M2611 Enforcer" = "cde",
						"M1911 Enforcer" = "m1911",
						"VP78 Enforcer" = "vp78",
						"USP Enforcer" = "usp-m"
						)

/obj/item/gun/ballistic/automatic/pistol/enforcer/update_icon_state()
	if(current_skin)
		icon_state = "[unique_reskin[current_skin]][chambered ? "" : "-e"]"
	else
		icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/pistol/enforcer/nomag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/enforcerred
	name = "\improper HOS's Mk. 58 Enforcer"
	desc = "A polymer frame pistol made by Nanotreason. Won't show up on Space port X-rays and cost more then you make in a month. Respect mah Authorita!"
	icon = 'modular_splurt/icons/obj/guns/projectile.dmi'
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
	name = "\improper Gold Mk. 58 Enforcer"
	desc = "A titianium gold plated Enfocer. A vulger display of power. A show of force in a public execution."
	icon = 'modular_splurt/icons/obj/guns/projectile.dmi'
	icon_state = "enforcer_gold"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/e45
	can_suppress = FALSE
	can_flashlight = 1
	flight_x_offset = 18
	flight_y_offset = 14

/obj/item/gun/ballistic/automatic/pistol/enforcergold/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

