/datum/crafting_recipe/rnd_board
	name = "RnD Console Board"
	result = /obj/item/circuitboard/computer/rdconsole
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/sheet/mineral/gold = 2,
				/obj/item/stack/sheet/mineral/uranium = 1,
				/obj/item/stack/sheet/mineral/plasma = 1,
				/obj/item/stack/cable_coil = 5)
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER, TOOL_WELDER)
	time = 40
	subcategory = CAT_TOOL
	category = CAT_MISC

/datum/crafting_recipe/protolathe
	name = "Protolathe Board"
	result = /obj/item/circuitboard/machine/protolathe
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/sheet/mineral/gold = 2,
				/obj/item/stack/sheet/mineral/uranium = 1,
				/obj/item/stack/cable_coil = 5)
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER, TOOL_WELDER)
	time = 20
	subcategory = CAT_TOOL
	category = CAT_MISC

/datum/crafting_recipe/circuit_imprinter
	name = "Circuit Imprinter"
	result = /obj/item/circuitboard/machine/circuit_imprinter
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/sheet/mineral/gold = 2,
				/obj/item/stack/sheet/mineral/uranium = 1,
				/obj/item/stack/cable_coil = 5)
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER, TOOL_WELDER)
	time = 20
	subcategory = CAT_TOOL
	category = CAT_MISC

/datum/crafting_recipe/autolathe
	name = "Autolathe Board"
	result = /obj/item/circuitboard/machine/autolathe
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/sheet/mineral/gold = 1,
				/obj/item/stack/cable_coil = 20)
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER, TOOL_WELDER)
	time = 20
	subcategory = CAT_TOOL
	category = CAT_MISC

/datum/crafting_recipe/crowbar
	name = "Crowbar"
	result = /obj/item/crowbar
	reqs = list(/obj/item/stack/rods = 1)
	time = 40
	subcategory = CAT_TOOL
	category = CAT_MISC

/datum/crafting_recipe/screwdriver
	name = "Screwdriver"
	result = /obj/item/screwdriver
	reqs = list(/obj/item/stack/rods = 1)
	tools = list(TOOL_CROWBAR)
	time = 20
	subcategory = CAT_TOOL
	category = CAT_MISC

/datum/crafting_recipe/wirecutters
	name = "Wirecutters"
	result = /obj/item/wirecutters
	reqs = list(/obj/item/stack/rods = 2,
				/obj/item/stack/cable_coil = 5)
	tools = list(TOOL_CROWBAR, TOOL_SCREWDRIVER)
	time = 50
	subcategory = CAT_TOOL
	category = CAT_MISC

/datum/crafting_recipe/wrench
	name = "Wrench"
	result = /obj/item/wrench
	reqs = list(/obj/item/stack/rods = 1,
				/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_CROWBAR, TOOL_SCREWDRIVER)
	time = 30
	subcategory = CAT_TOOL
	category = CAT_MISC

/datum/crafting_recipe/emergency_welder
	name = "Emergency Welding Tool"
	result = /obj/item/weldingtool/mini
	reqs = list(/obj/item/stack/rods = 1,
				/obj/item/stack/sheet/mineral/wood= 1,
				/obj/item/stack/cable_coil = 5)
	tools = list(TOOL_CROWBAR, TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	time = 30
	subcategory = CAT_TOOL
	category = CAT_MISC

/datum/crafting_recipe/toolbox
	name = "Toolbox"
	result = /obj/item/storage/toolbox/greyscale
	reqs = list(/obj/item/stack/rods = 3,
				/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/cable_coil = 5)
	tools = list(TOOL_CROWBAR, TOOL_SCREWDRIVER, TOOL_WIRECUTTER, TOOL_WELDER)
	time = 70
	subcategory = CAT_TOOL
	category = CAT_MISC