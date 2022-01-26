/datum/outfit/job/cmo/New()
	. = ..()
	accessory = /obj/item/clothing/accessory/permit/head

/datum/outfit/job/quartermaster/New()
	. = ..()
	accessory = /obj/item/clothing/accessory/permit/head

/datum/outfit/job/ce/New()
	. = ..()
	accessory = /obj/item/clothing/accessory/permit/head

/datum/outfit/job/hop/New()
	. = ..()
	backpack_contents += list(/obj/item/storage/secure/briefcase/permits)
	accessory += list(/obj/item/clothing/accessory/permit/head)

/datum/outfit/job/captain/New()
	. = ..()
	backpack_contents += list(/obj/item/storage/secure/briefcase/permits)

/datum/outfit/job/rd/New()
	. = ..()
	accessory = /obj/item/clothing/accessory/permit/head
