/datum/crafting_recipe/crowbar
	name = "Makeshift Crowbar"
	result = /obj/item/crowbar/makeshift
	reqs = list(/obj/item/stack/rods = 1)
	time = 40
	subcategory = CAT_TOOL
	category = CAT_MISCELLANEOUS

/datum/crafting_recipe/screwdriver
	name = "Makeshift Screwdriver"
	result = /obj/item/screwdriver/makeshift
	reqs = list(/obj/item/stack/rods = 1)
	tools = list(TOOL_CROWBAR)
	time = 20
	subcategory = CAT_TOOL
	category = CAT_MISCELLANEOUS

/datum/crafting_recipe/wirecutters
	name = "Wirecutters"
	result = /obj/item/wirecutters/makeshift
	reqs = list(/obj/item/stack/rods = 2,
				/obj/item/stack/cable_coil = 5)
	tools = list(TOOL_CROWBAR, TOOL_SCREWDRIVER)
	time = 50
	subcategory = CAT_TOOL
	category = CAT_MISCELLANEOUS

/datum/crafting_recipe/wrench
	name = "Wrench"
	result = /obj/item/wrench/makeshift
	reqs = list(/obj/item/stack/rods = 1,
				/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_CROWBAR, TOOL_SCREWDRIVER)
	time = 30
	subcategory = CAT_TOOL
	category = CAT_MISCELLANEOUS

/datum/crafting_recipe/emergency_welder
	name = "Makeshift Welder"
	result = /obj/item/weldingtool/makeshift
	reqs = list(/obj/item/stack/rods = 1,
				/obj/item/assembly/igniter = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/cable_coil = 5)
	tools = list(TOOL_CROWBAR, TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	time = 30
	subcategory = CAT_TOOL
	category = CAT_MISCELLANEOUS

/datum/crafting_recipe/toolbox
	name = "Toolbox"
	result = /obj/item/storage/toolbox/greyscale
	reqs = list(/obj/item/stack/rods = 3,
				/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/cable_coil = 5)
	tools = list(TOOL_CROWBAR, TOOL_SCREWDRIVER, TOOL_WIRECUTTER, TOOL_WELDER)
	time = 70
	subcategory = CAT_TOOL
	category = CAT_MISCELLANEOUS

/datum/crafting_recipe/bin
	name = "Makeshift Matter Bin"
	result = /obj/item/stock_parts/matter_bin/makeshift
	reqs = list(/obj/item/stack/sheet/metal = 3)
	tools = list(TOOL_WIRECUTTER, TOOL_WELDER)
	time = 70
	subcategory = CAT_TOOL
	category = CAT_MISCELLANEOUS

/datum/crafting_recipe/makeshift_manipulator
	name = "Makeshift Manipulator"
	result = /obj/item/stock_parts/manipulator/makeshift
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/cable_coil = 5)
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER, TOOL_WELDER)
	time = 70
	subcategory = CAT_TOOL
	category = CAT_MISCELLANEOUS

/datum/crafting_recipe/slime_core
	name = "Slime Core"
	result = /obj/item/slime_extract/grey
	reqs = list(/datum/reagent/toxin/slimejelly = 100,
				/datum/reagent/toxin/plasma = 20)
	tools = list(TOOL_WELDER)
	time = 100
	subcategory = CAT_TOOL
	category = CAT_MISCELLANEOUS

//Milking machines
/datum/crafting_recipe/milking_machine
	name = "Milking Machine"
	result = /obj/item/milking_machine
	reqs = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stack/rods = 2,
		/obj/item/stack/sheet/cardboard = 1,
		/obj/item/reagent_containers/glass/beaker = 2,
		/obj/item/stock_parts/manipulator = 1
	)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISCELLANEOUS

/datum/crafting_recipe/milking_machine/penis
	name = "Cock Milker"
	result = /obj/item/milking_machine/penis
	reqs = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stack/rods = 1,
		/obj/item/stack/sheet/cardboard = 1,
		/obj/item/reagent_containers/glass/beaker/large = 1,
		/obj/item/stock_parts/manipulator = 1
	)

//Bouquets
/datum/crafting_recipe/mixedbouquet
	name = "Mixed bouquet"
	result = /obj/item/bouquet
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/poppy/lily =2,
				/obj/item/grown/sunflower = 2,
				/obj/item/reagent_containers/food/snacks/grown/poppy/geranium = 2)
	category = CAT_MISCELLANEOUS
	subcategory = CAT_MISCELLANEOUS

/datum/crafting_recipe/sunbouquet
	name = "Sunflower bouquet"
	result = /obj/item/bouquet/sunflower
	reqs = list(/obj/item/grown/sunflower = 6)
	category = CAT_MISCELLANEOUS
	subcategory = CAT_MISCELLANEOUS

/datum/crafting_recipe/poppybouquet
	name = "Poppy bouquet"
	result = /obj/item/bouquet/poppy
	reqs = list (/obj/item/reagent_containers/food/snacks/grown/poppy = 6)
	category = CAT_MISCELLANEOUS
	subcategory = CAT_MISCELLANEOUS

/datum/crafting_recipe/rosebouquet
	name = "Rose bouquet"
	result = /obj/item/bouquet/rose
	reqs = list(/obj/item/grown/rose = 6)
	category = CAT_MISCELLANEOUS
	subcategory = CAT_MISCELLANEOUS
