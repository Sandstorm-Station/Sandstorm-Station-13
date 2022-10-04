/obj/machinery/vending/snack/Initialize(mapload)
	var/list/extra_products = list(
		/obj/item/storage/fancy/jellybean_bowl = 5
	)
	LAZYADD(products, extra_products)
	. = ..()
