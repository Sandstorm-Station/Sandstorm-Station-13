/datum/gear/neck/boatcloakpoly
	name = "Polychromatic Boatcloak"
	path = /obj/item/clothing/neck/cloak/alt/boatcloak/polychromic
	loadout_flags = LOADOUT_CAN_NAME | LOADOUT_CAN_DESCRIPTION | LOADOUT_CAN_COLOR_POLYCHROMIC
	loadout_initial_colors = list("#FCFCFC", "#454F5C", "#CCCEE2")

/datum/gear/neck/boatcloakcomm
	name = "Command Boatcloak"
	path = /obj/item/clothing/neck/cloak/alt/boatcloak/command
	loadout_flags = LOADOUT_CAN_NAME | LOADOUT_CAN_DESCRIPTION
	restricted_desc = "Heads of Staff"
	restricted_roles = list("Head of Security","Captain","Head of Personnel","Chief Engineer","Research Director","Chief Medical Officer","Quartermaster")
