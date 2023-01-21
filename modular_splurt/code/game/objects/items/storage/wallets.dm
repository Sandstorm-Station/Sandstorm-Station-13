// Bluespace wallet
/obj/item/storage/wallet/bluespace
	name = "\improper wallet of holding"
	desc = "A testament to science's hubris. It holds thrice as many stolen ID cards."
	icon = 'modular_splurt/icons/obj/storage.dmi'
	icon_state = "wallet_bluespace"

	// Copied from bag of holding
	resistance_flags = FIRE_PROOF
	item_flags = NO_MAT_REDEMPTION
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/storage/wallet/bluespace/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 12

/obj/item/storage/wallet/bluespace/update_icon_state()
	// Don't update icons
	return
