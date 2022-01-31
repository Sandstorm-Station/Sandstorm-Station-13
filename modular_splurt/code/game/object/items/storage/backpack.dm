/obj/item/storage/backpack/duffelbag/syndie/med/sleeperbundle
	desc = "A large duffel bag containing various knockout chemicals, a handheld chem sprayer, tear gas grenade, a Donksoft assault rifle, box of riot grade darts, a dart pistol, and a box of syringes."

/obj/item/storage/backpack/duffelbag/syndie/med/sleeperbundle/PopulateContents()
	new /obj/item/reagent_containers/spray/chemsprayer/sleeper(src)
	new /obj/item/storage/box/syndie_kit/sleeper(src)
	new /obj/item/gun/syringe/syndicate(src)
	new /obj/item/storage/box/syringes(src)
	new /obj/item/grenade/chem_grenade/teargas(src)
	new /obj/item/grenade/chem_grenade/teargas(src)
	new /obj/item/grenade/chem_grenade/teargas(src)
