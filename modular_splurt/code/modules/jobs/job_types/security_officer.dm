/datum/outfit/job/security/New()
    . = ..()
    backpack_contents += list(/obj/item/choice_beacon/copgun=1, /obj/item/device/hailer, /obj/item/clothing/accessory/badge)

/datum/outfit/job/detective/New()
    . = ..()
    backpack_contents += list(/obj/item/device/hailer, /obj/item/clothing/accessory/badge)

/datum/outfit/job/warden/New()
    . = ..()
    backpack_contents += list(/obj/item/device/hailer, /obj/item/clothing/accessory/badge)

/datum/outfit/job/hos/New()
    . = ..()
    backpack_contents += list(/obj/item/device/hailer, /obj/item/clothing/accessory/badge)
