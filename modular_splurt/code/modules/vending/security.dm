/obj/machinery/vending/security/Initialize()
	var/list/extra_products = list(
		/obj/item/ammo_box/magazine/m45/taser = 10,
		/obj/item/ammo_box/magazine/e45/taser = 10,
		/obj/item/device/hailer = 10
	)
	LAZYADD(products, extra_products)
	. = ..()

/obj/machinery/vending/wardrobe/sec_wardrobe/Initialize()
	var/list/extra_products = list(
		/obj/item/clothing/under/rank/security/skirt/slut = 5,
		/obj/item/clothing/under/rank/security/skirt/slut/pink = 5,
		/obj/item/clothing/under/rank/security/stripper = 5
	)
	LAZYADD(products, extra_products)
	. = ..()
