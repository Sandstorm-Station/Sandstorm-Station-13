/obj/vehicle/sealed/mecha/mob_try_enter(mob/M)
	if(HAS_TRAIT(M, TRAIT_PRIMITIVE)) //no lavalizards either.
		to_chat(M, span_warning("The knowledge to use this device eludes you!"))
		return
	. = ..()
