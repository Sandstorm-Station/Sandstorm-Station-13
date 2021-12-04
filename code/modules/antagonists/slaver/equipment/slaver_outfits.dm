/datum/outfit/slaver
	name = "Slave Trader - Basic"

	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/color/black
	back = /obj/item/storage/backpack/satchel
	ears = /obj/item/radio/headset/syndicate/alt
	id = /obj/item/card/id/slaver
	belt = /obj/item/gun/ballistic/automatic/pistol
	backpack_contents = list(/obj/item/storage/box/survival,\
		/obj/item/kitchen/knife/combat/survival)

/datum/outfit/slaver/leader
	name = "Slave Master - Basic"
	id = /obj/item/card/id/slaver
	gloves = /obj/item/clothing/gloves/krav_maga/combatglovesplus

/datum/outfit/slaver/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE, client/preference_source)
	var/obj/item/radio/R = H.ears
	R.set_frequency(FREQ_SYNDICATE)
	R.freqlock = TRUE

	var/obj/item/implant/weapons_auth/W = new
	W.implant(H)
	var/obj/item/implant/explosive/E = new
	E.implant(H)
	H.faction |= ROLE_SLAVER
	H.update_icons()
