/obj/item/clothing/under
	is_edible = 1 //Most jumpsuits are  made of cloth so this is a safe bet.

/obj/item/clothing/under/Destroy()
	QDEL_LIST(attached_accessories)
	return ..()
