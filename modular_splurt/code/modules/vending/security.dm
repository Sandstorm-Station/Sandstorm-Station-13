/obj/machinery/vending/security/Initialize()
	var/list/extra_products = list(
		/obj/item/ammo_box/magazine/m45/taser = 10,
		/obj/item/ammo_box/magazine/e45/taser = 10,
		/obj/item/device/hailer = 10
	)
	LAZYADD(products, extra_products)
	. = ..()

/obj/machinery/vending/wardrobe/sec_wardrobe/Initialize()
	var/list/extra_products = list(
		/obj/item/clothing/under/rank/security/skirt/slut = 5,
		/obj/item/clothing/under/rank/security/skirt/slut/pink = 5,
		/obj/item/clothing/under/rank/security/stripper = 5
	)
	LAZYADD(products, extra_products)
	. = ..()

/obj/structure/closet/secure_closet/brigdoc
	name = "brig physician's locker"
	req_access = list(ACCESS_MEDICAL)
	icon_state = "med_secure"

/obj/structure/closet/secure_closet/brigdoc/PopulateContents()
	..()
	new /obj/item/clothing/under/rank/brigdoc(src)
	new /obj/item/clothing/under/rank/brigdoc/skirt(src)
	new /obj/item/radio/headset/headset_brigdoc(src)
	new /obj/item/radio/headset/headset_brigdoc/alt(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/clothing/head/brigdoc(src)

/obj/structure/closet/secure_closet/blueshield
	name = "blueshield's locker"
	req_access = list(ACCESS_HEADS)
	icon_state = "tac"

/obj/structure/closet/secure_closet/blueshield/PopulateContents()
	..()
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/clothing/head/helmet/sec(src)
	new /obj/item/radio/headset/headset_blueshield(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/clothing/under/rank/blueshield(src)
	new /obj/item/clothing/under/rank/blueshield/skirt(src)
	new /obj/item/clothing/head/helmet/blueshirt(src)
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/clothing/mask/gas/sechailer/swat(src)
	new /obj/item/clothing/head/blueshield(src)
