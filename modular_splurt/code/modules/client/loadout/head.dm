// removes resricted role for D.A.B. helmets. RIP N.E.E.T. gear as exclusive for assistants (2019-2021).
/datum/gear/head/neethelm
	subcategory = LOADOUT_SUBCATEGORY_SUIT_GENERAL
	restricted_roles = list()

// Updates restrictions to accomodate new jobs (mostly trekkie stuff)
/datum/gear/head/brodie
	restricted_roles = list("Security Officer", "Warden", "Head of Security", "Brig Physician", "Blueshield")

/datum/gear/head/trekcapcap
	restricted_roles = list("Captain","Head of Personnel","Blueshield")

/datum/gear/head/trekcapmedisci
	restricted_roles = list("Chief Medical Officer","Medical Doctor","Chemist","Virologist","Paramedic","Geneticist","Research Director","Scientist", "Roboticist", "Brig Physician")

/datum/gear/head/trekcapsec
	restricted_roles = list("Head of Security","Captain","Head of Personnel","Chief Engineer","Research Director","Chief Medical Officer","Quartermaster","Warden","Detective","Security Officer","Brig Physician","Blueshield","Bridge Officer")

/datum/gear/head/orvkepicom
	restricted_roles = list("Head of Security", "Captain", "Head of Personnel", "Chief Engineer", "Research Director", "Chief Medical Officer", "Quartermaster", "Bridge Officer")

/datum/gear/head/orvkepisec
	restricted_roles = list("Warden", "Detective", "Security Officer", "Head of Security", "Brig Physician", "Blueshield")

/datum/gear/head/orvkepimedsci
	restricted_roles = list("Chief Medical Officer", "Medical Doctor", "Chemist", "Virologist", "Paramedic", "Geneticist", "Research Director", "Scientist", "Roboticist", "Brig Physician")

/datum/gear/head/cowboyhat/sec
	restricted_roles = list("Warden","Detective","Security Officer","Head of Security", "Brig Physician", "Blueshield")

// Polychrome GWTB
/datum/gear/head/gonerhelm
	name = "polychromic trencher helmet"
	cost = 2
	path = /obj/item/clothing/head/helmet/goner/fake/poly
	loadout_flags = LOADOUT_CAN_NAME | LOADOUT_CAN_DESCRIPTION | LOADOUT_CAN_COLOR_POLYCHROMIC
	loadout_initial_colors = list("#D9D9D9")

/datum/gear/head/goneroffcap
	name = "polychromic trencher officer cap"
	cost = 2
	path = /obj/item/clothing/head/helmet/goner/officer/fake/poly
	loadout_flags = LOADOUT_CAN_NAME | LOADOUT_CAN_DESCRIPTION | LOADOUT_CAN_COLOR_POLYCHROMIC
	loadout_initial_colors = list("#F2F2F2")
