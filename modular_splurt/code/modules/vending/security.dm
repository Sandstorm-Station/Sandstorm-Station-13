/obj/machinery/vending/security/Initialize()
	var/list/extra_products = list(
		/obj/item/ammo_box/magazine/m45/taser = 10,
		/obj/item/ammo_box/magazine/e45/taser = 10
	)
	LAZYADD(products, extra_products)
   . = ..()
