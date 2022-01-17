/obj/machinery/shower/wash_obj(obj/O)
	. = ..()
	if(!O)
		return
	. = O.wash_cum()

/obj/machinery/shower/wash_mob(mob/living/L)
	L.wash_cum()
	. = ..()
