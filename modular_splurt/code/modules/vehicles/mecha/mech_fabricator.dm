/obj/machinery/mecha_part_fabricator/Initialize(mapload)
	var/list/extra_part_sets = list(
		"Savannah-Ivanov"
	)
	LAZYADD(part_sets, extra_part_sets)
	. = ..()
