/obj/structure/bed/dogbed/shadow
	icon = 'modular_eros/icons/obj/objects.dmi'
	icon_state = "dogbed_shadow"
	buildstacktype = /obj/item/stack/sheet/mineral/wood/shadow

/obj/structure/bed/dogbed/mushroom
	icon = 'modular_eros/icons/obj/objects.dmi'
	icon_state = "dogbed_mushwood"
	buildstacktype = /obj/item/stack/sheet/mineral/wood/mushroom

/obj/structure/bed/matress
	name = "matress"
	desc = "This is used to lie in, sleep in or strap on."
	icon_state = "mattress0"

/obj/structure/bed/matress/New()
	..()
	icon_state = "mattress[rand(0,6)]"
