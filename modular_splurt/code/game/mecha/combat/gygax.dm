/obj/vehicle/sealed/mecha/combat/gygax/bluespace

/obj/vehicle/sealed/mecha/combat/gygax/bluespace/add_cell(obj/item/stock_parts/cell/C=null)
	if(C)
		C.forceMove(src)
		cell = C
		return
	cell = new /obj/item/stock_parts/cell/bluespace(src)
