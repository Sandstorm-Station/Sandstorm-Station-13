GLOBAL_LIST_INIT(skirt_peekable, list(
	/obj/item/clothing/under/rank/civilian/janitor/maid = TRUE /* This one hangs about because no skirt in path */
	))

/obj/item/clothing/under/Initialize(mapload)
	. = ..()
	if(!is_type_in_typecache(type, GLOB.skirt_peekable) && findlasttext("[type]", "skirt"))
		LAZYSET(GLOB.skirt_peekable, type, TRUE)
