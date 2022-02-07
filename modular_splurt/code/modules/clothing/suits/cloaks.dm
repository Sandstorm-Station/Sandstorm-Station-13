// Boatcloaks
/obj/item/clothing/neck/cloak/alt/boatcloak
	name = "boatcloak"
	desc = "A simple, short-ish boatcloak."
	icon = 'modular_splurt/icons/obj/clothing/neck.dmi'
	mob_overlay_icon = 'modular_splurt/icons/mob/clothing/neck.dmi'
	icon_state = "boatcloak"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/neck/cloak/alt/boatcloak/command
	name = "command boatcloak"
	desc = "A boatcloak with gold ribbon."
	icon_state = "boatcloak_com"
	body_parts_covered = CHEST|LEGS|ARMS

/obj/item/clothing/neck/cloak/alt/boatcloak/polychromic
	name = "polychromic boatcloak"
	desc = "A polychromic, short-ish boatcloak."
	icon_state = "boatcloak"
	var/list/poly_colors = list("#FCFCFC", "#454F5C", "#CCCEE2")

/obj/item/clothing/neck/cloak/alt/boatcloak/polychromic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, poly_colors, 3)
