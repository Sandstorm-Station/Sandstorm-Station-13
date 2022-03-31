/datum/blackmarket_item/syndi/clothing/ds_hardsuit
	price = 0
	stock = 0
	availability_prob = 0	//Zeroing this out so it can't be used at all
//normal

/datum/blackmarket_item/clothing/stalker
	name = "S.T.A.L.K.E.R. mask"
	desc = "Smells like reactor four."
	item = /obj/item/clothing/mask/gas/stalker
	price_min = 400
	price_max = 800
	stock_min = 1
	stock_max = 3
	availability_prob = 45

/datum/blackmarket_item/clothing/military
	name = "Military Gas Mask"
	desc = "A rare PMC gas mask, one of the very expensive kinds. The inside looks comfortable to wear for a while. The blood red eyes however seem to stare back at you. Creepy."
	item = /obj/item/clothing/mask/gas/military
	price_min = 400
	price_max = 800
	stock_min = 1
	stock_max = 3
	availability_prob = 55

//syndis

/datum/blackmarket_item/syndi/clothing/tactical
	name = "Tactical turtleneck"
	desc = "A non-descript and slightly suspicious looking turtleneck with digital camouflage cargo pants."
	item = /obj/item/clothing/under/syndicate
	price = 50000
	stock_min = 1
	stock_max = 10
	availability_prob = 95

/datum/blackmarket_item/syndi/clothing/tacticalskirt
	name = "Tactical skirtleneck"
	desc = "A non-descript and slightly suspicious looking skirtleneck."
	item = /obj/item/clothing/under/syndicate/tacticool
	price = 50000
	stock_min = 1
	stock_max = 10
	availability_prob = 95
