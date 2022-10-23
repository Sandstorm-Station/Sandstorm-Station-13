/obj/machinery/vending/clothing/Initialize()
	var/list/extra_products = list(
		/obj/item/clothing/suit/assu_suit = 16,
		/obj/item/clothing/head/assu_helmet = 16,
		/obj/item/clothing/glasses/aviators = 10,
		/obj/item/clothing/glasses/sunglasses = 10,
		/obj/item/clothing/suit/toggle/rp_jacket = 3,
		/obj/item/clothing/suit/toggle/rp_jacket/orange = 3,
		/obj/item/clothing/suit/toggle/rp_jacket/purple = 3,
		/obj/item/clothing/suit/toggle/rp_jacket/red = 3,
		/obj/item/clothing/suit/toggle/rp_jacket/white = 3,
		/obj/item/clothing/under/goner/fake/poly = 10,
		/obj/item/clothing/suit/goner/fake/poly = 10,
		/obj/item/clothing/head/helmet/goner/fake/poly = 10,
		/obj/item/clothing/under/raccveralls = 3,
		/obj/item/clothing/under/officesexy = 3,
		/obj/item/clothing/suit/tunnelfox = 3,
		/obj/item/clothing/suit/tunnelfox_t = 3,
		/obj/item/clothing/under/performer = 2,
		/obj/item/clothing/under/bluedress = 3
	)
	var/list/extra_contraband = list(
		/obj/item/clothing/under/rank/civilian/lawyer/galaxy_red = 3,
		/obj/item/clothing/mask/gas/goner/basic = 10
	)
	var/list/extra_premium = list(
		/obj/item/clothing/under/rank/civilian/lawyer/galaxy_blue = 3,
		/obj/item/clothing/head/helmet/goner/officer/fake/poly = 10
	)
	LAZYADD(products, extra_products)
	LAZYADD(contraband, extra_contraband)
	LAZYADD(premium, extra_premium)
	. = ..()
