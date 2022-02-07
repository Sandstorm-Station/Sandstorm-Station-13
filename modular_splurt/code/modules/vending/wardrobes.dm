/obj/machinery/vending/wardrobe/bar_wardrobe/Initialize(mapload)
	var/list/extra_products = list(
		/obj/item/clothing/neck/petcollar/handmade = 3
	)
	LAZYADD(products, extra_products)
	. = ..()

