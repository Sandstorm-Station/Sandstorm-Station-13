/mob/living/simple_animal/hostile/megafauna/king/Initialize(mapload)
	. = ..()
	internal = new /obj/item/gps/internal/king(src)

/obj/item/gps/internal/king
	icon_state = null
	gpstag = "Regal Signal"
	desc = "Must lead to a true king."
	invisibility = 100
