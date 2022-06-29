//Main code edits
/datum/supply_pack/organic/randomized/candy/New()
	var/extra_contains = list(
		/obj/item/storage/fancy/jellybean_bowl
	)
	LAZYADD(contains, extra_contains)
	. = ..()
