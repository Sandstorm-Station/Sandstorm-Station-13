/obj/item/storage/box/slaver_teleport
	name = "boxed emergency teleport implant (with injector)"

/obj/item/storage/box/slaver_teleport/PopulateContents()
	var/obj/item/implanter/O = new(src)
	O.imp = new /obj/item/implant/slaver(O)
	O.update_icon()
