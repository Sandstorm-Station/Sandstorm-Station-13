/obj/structure/stairs/Initialize(mapload)
	GLOB.stairs += src
	. = ..()

/obj/structure/stairs/Destroy()
	GLOB.stairs -= src
	. = ..()
