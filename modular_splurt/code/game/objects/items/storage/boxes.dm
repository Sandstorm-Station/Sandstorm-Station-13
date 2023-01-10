/obj/item/storage/box/medipens/lewd
	name = "Lewd medipen box"
	icon = 'modular_splurt/icons/obj/storage.dmi'
	desc = "A box full of medipens meant to cause interesting effects on people. None of them with a close to medical application."
	illustration = "syringe_lewd"

/obj/item/storage/box/medipens/lewd/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/reagent_containers/hypospray/medipen/crocin(src)
		new /obj/item/reagent_containers/hypospray/medipen/crocin/plus(src)
		new /obj/item/reagent_containers/hypospray/medipen/breastgrowth(src)
		new /obj/item/reagent_containers/hypospray/medipen/penisgrowth(src)
		new /obj/item/reagent_containers/hypospray/medipen/buttgrowth(src)
		new /obj/item/reagent_containers/hypospray/medipen/bellygrowth(src)
		new /obj/item/reagent_containers/hypospray/medipen/prospacillin(src)
		new /obj/item/reagent_containers/hypospray/medipen/lewdbomb(src)

// Kinkmate listing for the rapid disrobe implant
/obj/item/storage/box/implant_disrobe
	name = "rapid disrobe implant box"
	desc = "Comes with an implanter and an implant case for quick application!"
	icon = 'modular_sand/icons/obj/fleshlight.dmi'
	icon_state = "box"

/obj/item/storage/box/implant_disrobe/ComponentInitialize()
	. = ..()
	var/datum/component/storage/str = GetComponent(/datum/component/storage)
	str.max_items = 2

/obj/item/storage/box/implant_disrobe/PopulateContents()
	new /obj/item/implanter(src)
	new /obj/item/implantcase/disrobe(src)
