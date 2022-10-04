/obj/machinery/chem_dispenser/Initialize(mapload)
	. = ..()
	if(!mapload)
		message_admins("[src] has been created at [ADMIN_VERBOSEJMP(src)].")
