/obj/machinery/vending/clothing/New(loc, ...)
	. = ..()
	products[/obj/item/clothing/head/wig] = 5
	for(var/datum/gear/G in typesof(/datum/gear/underwear))
		products[initial(G.path)] = 5
	for(var/datum/gear/G in typesof(/datum/gear/shirt))
		products[initial(G.path)] = 5
	for(var/datum/gear/G in typesof(/datum/gear/socks))
		products[initial(G.path)] = 5
