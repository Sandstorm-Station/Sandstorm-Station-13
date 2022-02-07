// Pistol Magazines

/obj/item/ammo_box/magazine/m45
    name = "M1911 magazine (.45 Rubber)"
    desc = "A M1911 magazine. Loaded with rubber rounds."

/obj/item/ammo_box/magazine/m45/lethal
	name = "M1911 magazine (.45 Lethal)"
	desc = "A M1911 magazine. Loaded with lethal rounds."
	ammo_type = /obj/item/ammo_casing/c45/lethal

/obj/item/ammo_box/magazine/m45/hydra
	name = "M1911 magazine (.45 Hydra}"
	desc = "A M1911 magazine. Loaded with Hydra-shock."
	ammo_type = /obj/item/ammo_casing/c45/hydra

/obj/item/ammo_box/magazine/m45/taser
	name = "M1911 magazine (.45 Taser}"
	desc = "A M1911 magazine. Loaded with taser rounds."
	ammo_type = /obj/item/ammo_casing/c45/taser

/obj/item/ammo_box/magazine/m45/trac
	name = "M1911 magazine (.45 Tracking}"
	desc = "A M1911 magazine. Loaded with trac rounds."
	ammo_type = /obj/item/ammo_casing/c45/trac

/obj/item/ammo_box/magazine/m45/hotshot
	name = "M1911 magazine (.45 Hotshot}"
	desc = "A M911 magazine. Loaded with Hotshot rounds."
	ammo_type = /obj/item/ammo_casing/c45/hotshot

/obj/item/ammo_box/magazine/m45/ion
	name = "M1911 magazine (.45 Ion}"
	desc = "A M1911 magazine. Loaded with Ion rounds."
	ammo_type = /obj/item/ammo_casing/c45/ion

/obj/item/ammo_box/magazine/m45/laser
	name = "Enforcer magazine (.45 Laser}"
	desc = "A M1911 magazine. Loaded with Laser rounds."
	ammo_type = /obj/item/ammo_casing/c45/laser

/obj/item/ammo_box/magazine/m45/stun
	name = "M1911 magazine (.45 Stun}"
	desc = "A M1911 magazine. Loaded with Stun rounds."
	ammo_type = /obj/item/ammo_casing/c45/stun

/obj/item/ammo_box/magazine/e45
	name = "Enforcer magazine (.45 Rubber)"
	icon = 'modular_splurt/icons/obj/ammo.dmi'
	icon_state = "enforcer-8"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	desc = "A Mk. 58 magazine. Loaded with rubber rounds."
	max_ammo = 8

/obj/item/ammo_box/magazine/e45/laser
	name = "Enforcer magazine (.45 Laser}"
	desc = "A Mk. 58 magazine. Loaded with Laser rounds."
	ammo_type = /obj/item/ammo_casing/c45/laser

/obj/item/ammo_box/magazine/e45/stun
	name = "Enforcer magazine (.45 Stun}"
	desc = "A Mk. 58 magazine. Loaded with Stun rounds."
	ammo_type = /obj/item/ammo_casing/c45/stun

/obj/item/ammo_box/magazine/e45/update_icon()
	..()
	icon_state = "enforcer-[ammo_count() ? "8" : "0"]"

/obj/item/ammo_box/magazine/e45/lethal
	name = "Enforcer magazine (.45 Lethal)"
	desc = "A Mk. 58 magazine. Loaded with lethal rounds."
	ammo_type = /obj/item/ammo_casing/c45/lethal

/obj/item/ammo_box/magazine/e45/hydra
	name = "Enforcer magazine (.45 Hydra}"
	desc = "A Mk. 58 magazine. Loaded with Hydra-shock."
	ammo_type = /obj/item/ammo_casing/c45/hydra

/obj/item/ammo_box/magazine/e45/taser
	name = "Enforcer magazine (.45 Taser}"
	desc = "A Mk. 58 magazine. Loaded with taser rounds."
	ammo_type = /obj/item/ammo_casing/c45/taser

/obj/item/ammo_box/magazine/e45/trac
	name = "Enforcer magazine (.45 Tracking}"
	desc = "A Mk. 58 magazine. Loaded with trac rounds."
	ammo_type = /obj/item/ammo_casing/c45/trac

/obj/item/ammo_box/magazine/e45/hotshot
	name = "Enforcer magazine (.45 Hotshot}"
	desc = "A Mk. 58 magazine. Loaded with Hotshot rounds."
	ammo_type = /obj/item/ammo_casing/c45/hotshot

/obj/item/ammo_box/magazine/e45/ion
	name = "Enforcer magazine (.45 Ion}"
	desc = "A Mk. 58 magazine. Loaded with Ion rounds."
	ammo_type = /obj/item/ammo_casing/c45/ion

/obj/item/ammo_box/magazine/e45/laser
	name = "Enforcer magazine (.45 Laser}"
	desc = "A Mk. 58 magazine. Loaded with Laser rounds."
	ammo_type = /obj/item/ammo_casing/c45/laser

/obj/item/ammo_box/magazine/e45/stun
	name = "Enforcer magazine (.45 Stun}"
	desc = "A Mk. 58 magazine. Loaded with Stun rounds."
	ammo_type = /obj/item/ammo_casing/c45/stun

// Pistol Magazines for the Sec Tecfab, yes its just easier to put it here for my own Sanity - Radar

/datum/design/e45/e45ion
	name = "Enforcer magazine (.45 Ion)"
	desc = "A magazine of .45 Ion for the Mk. 58 Enforcer"
	id = "e45_ion"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1200, /datum/material/uranium = 50)
	build_path = /obj/item/ammo_box/magazine/e45/ion
	category = list("ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/m45/m45ion
	name = "M1911 magazine (.45 Ion)"
	desc = "A magazine of .45 Ion for the M1911."
	id = "m45_ion"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1200, /datum/material/uranium = 50)
	build_path = /obj/item/ammo_box/magazine/m45/ion
	category = list("ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/e45/e45stun
	name = "Enforcer magazine (.45 Stun)"
	desc = "A magazine of .45 Stun for the Mk. 58 Enforcer"
	id = "e45_stun"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1200, /datum/material/uranium = 50)
	build_path = /obj/item/ammo_box/magazine/e45/stun
	category = list("ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/m45/m45stun
	name = "M1911 magazine (.45 Stun)"
	desc = "A magazine of .45 Stun for the M1911."
	id = "m45_stun"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1200, /datum/material/uranium = 50)
	build_path = /obj/item/ammo_box/magazine/m45/stun
	category = list("ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/e45/e45laser
	name = "Enforcer magazine (.45 Laser)"
	desc = "A magazine of .45 Laser for the Mk. 58 Enforcer"
	id = "e45_laser"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1200, /datum/material/uranium = 50)
	build_path = /obj/item/ammo_box/magazine/e45/stun
	category = list("ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/m45/m45laser
	name = "M1911 magazine (.45 Laser)"
	desc = "A magazine of .45 Laser for the M1911."
	id = "m45_laser"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1200, /datum/material/uranium = 50)
	build_path = /obj/item/ammo_box/magazine/m45/stun
	category = list("ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

