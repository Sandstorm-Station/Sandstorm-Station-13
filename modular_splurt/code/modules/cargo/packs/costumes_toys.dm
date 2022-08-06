/datum/supply_pack/costumes_toys/randomised/toys/New()
	var/list/extra_contains = list(
		/obj/item/toy/prize/savannahivanov
	)
	LAZYADD(contains, extra_contains)
	. = ..()

