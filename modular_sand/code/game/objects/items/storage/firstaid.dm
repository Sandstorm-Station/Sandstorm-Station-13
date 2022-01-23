/obj/item/storage/pill_bottle/belly_inflation
	name = "Super Bubble Pills"
	desc = "Are you ready to become a blimp?"

/obj/item/storage/pill_bottle/belly_inflation/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/reagent_containers/pill/belly_inflation(src)

/obj/item/storage/hypospraykit/enlarge/PopulateContents()
	if(empty)
		return

	new /obj/item/reagent_containers/glass/bottle/vial/small/bellyreduction(src)
	new /obj/item/reagent_containers/glass/bottle/vial/small/bellyreduction(src)
	new /obj/item/reagent_containers/glass/bottle/vial/small/bellyreduction(src)

	. = ..()
