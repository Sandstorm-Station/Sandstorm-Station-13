/obj/item/clothing/under/Initialize(mapload)
	. = ..()
	if(!is_type_in_typecache(type, GLOB.skirt_peekable) && findlasttext("[type]", "skirt"))
		LAZYSET(GLOB.skirt_peekable, type, TRUE)
