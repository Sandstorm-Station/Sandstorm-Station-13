// removes resricted role for D.A.B. suits. RIP N.E.E.T. gear as exclusive for assistants (2019-2021).
/datum/gear/suit/neetsuit
	subcategory = LOADOUT_SUBCATEGORY_SUIT_GENERAL
	restricted_roles = list()

// Suggestion #148
/datum/gear/suit/techpriest
	name ="Techpriest robes"
	path = /obj/item/clothing/suit/hooded/techpriest
	restricted_roles = list("Chief Engineer","Research Director","Scientist", "Roboticist","Atmospheric Technician","Station Engineer")

// Suggestion #183
/datum/gear/suit/dracula
	name = "dracula coat"
	path = /obj/item/clothing/suit/dracula
