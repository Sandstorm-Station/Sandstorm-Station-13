/obj/item/gun/ballistic/automatic/pistol/m1911
	can_flashlight = 1
	flight_x_offset = 19
	flight_y_offset = 15

/obj/item/gun/ballistic/automatic/pistol/m1911/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"


/obj/item/gun/ballistic/automatic/pistol/Enforcer
	name = "\improper Mk. 58 Enforcer"
	desc = "A polymer frame pistol made by Nanotreason. Won't show up on Space port X-rays and cost more then you make in a month."
	icon = 'modular_splurt/icons/obj/guns/projectile.dmi'
	icon_state = "enforcer_black"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/e45
	can_suppress = TRUE
	can_flashlight = 1
	flight_x_offset = 18
	flight_y_offset = 14

/obj/item/gun/ballistic/automatic/pistol/Enforcer/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/pistol/Enforcer/nomag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/Enforcer/red
	name = "\improper HOS's Mk. 58 Enforcer"
	desc = "A polymer frame pistol made by Nanotreason. Won't show up on Space port X-rays and cost more then you make in a month. Respect mah Authorita!"
	icon = 'modular_splurt/icons/obj/guns/projectile.dmi'
	icon_state = "enforcer_red"

/obj/item/gun/ballistic/automatic/pistol/Enforcer/gold
	name = "\improper Gold Mk. 58 Enforcer"
	desc = "A titianium gold plated Enfocer. A vulger display of power. A show of force in a public execution."
	icon = 'modular_splurt/icons/obj/guns/projectile.dmi'
	icon_state = "enforcer_gold"

