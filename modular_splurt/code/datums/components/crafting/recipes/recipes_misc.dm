//Manly anvil
/datum/crafting_recipe/manlyanvil
	name = "Manly Anvil"
	result = /obj/structure/anvil/obtainable/dwarfvil
	time = 200
	reqs = list(/obj/item/clothing/accessory/skullcodpiece = 1,
	            /obj/item/stack/sheet/mineral/titanium = 25,
				/obj/item/organ/regenerative_core = 2,
				/obj/item/stack/sheet/mineral/wood = 10,
				/datum/reagent/consumable/ethanol/manly_dorf = 50)
	tools = list(TOOL_CROWBAR)
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISCELLANEOUS

/datum/crafting_recipe/trash_cannon
	name = "Trash Cannon"
	always_availible = FALSE
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	result = /obj/structure/cannon/trash
	reqs = list(
		/obj/item/melee/skateboard/improvised = 1,
		/obj/item/tank/internals/oxygen = 1,
		/datum/reagent/drug/maint/tar = 15,
		/obj/item/restraints/handcuffs/cable = 1,
		/obj/item/storage/toolbox = 1,
	)
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/trashball
	name = "Trashball"
	always_availible = FALSE
	result = /obj/item/stack/cannonball/trashball
	reqs = list(
		/obj/item/stack/sheet = 5,
		/datum/reagent/consumable/space_cola = 10,
	)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO
