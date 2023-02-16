#define ETHANOL_GFLUID_POWER_LIMIT 80

/datum/preferences
	max_save_slots = DEFAULT_SAVE_SLOTS
	var/unholypref = "No" //Goin 2 hell fo dis one
	var/list/gfluid_blacklist = list() //Stuff you don't want people to cum into you

/datum/preferences/New(client/C)
	if(!GLOB.genital_fluids_list)
		build_genital_fluids_list() //I DON'T KNOW where else to put it, ok??

	//Extra saves for donators
	max_save_slots = CONFIG_GET(number/base_save_slots)
	if(istype(C))
		var/extra_slots = (IS_CKEY_DONATOR_GROUP(C.key, DONATOR_GROUP_TIER_1) + IS_CKEY_DONATOR_GROUP(C.key, DONATOR_GROUP_TIER_2) + IS_CKEY_DONATOR_GROUP(C.key, DONATOR_GROUP_TIER_3)) * 10
		max_save_slots += extra_slots

	. = ..()

/proc/build_genital_fluids_list()
	// Define disallowed reagents
	var/list/blacklisted = list(
		// Base ethanol
		/datum/reagent/consumable/ethanol,

		//
		// Effect drinks
		//

		// Tints the user green
		/datum/reagent/consumable/ethanol/beer/green,

		// Removes dizziness, drowsiness, and sleeping
		/datum/reagent/consumable/ethanol/kahlua,

		// Can cause organ loss and death
		/datum/reagent/consumable/ethanol/thirteenloko,

		// Heals radiation
		/datum/reagent/consumable/ethanol/vodka,

		// Heals brute loss
		/datum/reagent/consumable/ethanol/bilk,

		// Drugs the user
		/datum/reagent/consumable/ethanol/threemileisland,

		// Causes hallucinations
		/datum/reagent/consumable/ethanol/absinthe,

		// Heals body parts for assistants
		/datum/reagent/consumable/ethanol/hooch,

		// Heals revolutionary antagonists
		/datum/reagent/consumable/ethanol/cuba_libre,

		// Heals radiation for engineers
		/datum/reagent/consumable/ethanol/screwdrivercocktail,

		// Restores blood volume
		/datum/reagent/consumable/ethanol/bloody_mary,

		// Causes the user to emit light
		/datum/reagent/consumable/ethanol/tequila_sunrise,

		// Increases body temperature
		/datum/reagent/consumable/ethanol/toxins_special,

		// Causes hallucinations
		/datum/reagent/consumable/ethanol/beepsky_smash,

		// Heals brute and burn damage for dwarfs
		/datum/reagent/consumable/ethanol/manly_dorf,

		// Drugs the user
		/datum/reagent/consumable/ethanol/manhattan_proj,

		// Increases body temperature
		/datum/reagent/consumable/ethanol/antifreeze,

		// Heals brute damage
		/datum/reagent/consumable/ethanol/barefoot,

		// Increases body temperature
		/datum/reagent/consumable/ethanol/sbiten,

		// Reduces body temperature
		/datum/reagent/consumable/ethanol/iced_beer,

		// Grants points for changeling antagonist
		/datum/reagent/consumable/ethanol/changelingsting,

		// Plays an explosion sound effect
		/datum/reagent/consumable/ethanol/syndicatebomb,

		// Heals body parts for clowns
		/datum/reagent/consumable/ethanol/bananahonk,

		// Heals body parts for mimes
		/datum/reagent/consumable/ethanol/silencer,

		// Attracts nearby ores
		/datum/reagent/consumable/ethanol/fetching_fizz,

		// Heals critical health users 'extremely quickly'
		/datum/reagent/consumable/ethanol/hearty_punch,

		// Causes confusion, dizziness, slurring, sleep, and toxin damage
		/datum/reagent/consumable/ethanol/atomicbomb,

		// Causes dizziness, slurring, confusion, drugging, and toxin damage
		/datum/reagent/consumable/ethanol/gargle_blaster,

		// Causes brain damage, drugging, and dizziness
		/datum/reagent/consumable/ethanol/neurotoxin,

		// Causes brain damage
		/datum/reagent/consumable/ethanol/neuroweak,

		// Causes slurring, dizziness, drugging, jittering, and toxin damage
		/datum/reagent/consumable/ethanol/hippies_delight,

		// Causes cult sluttering and stuttering
		/datum/reagent/consumable/ethanol/narsour,

		// Causes clock cult slurring and stuttering
		/datum/reagent/consumable/ethanol/cogchamp,

		// Heals body part and brute damage for some mobs
		/datum/reagent/consumable/ethanol/pinotmort,

		// Heals body part and brute damage for security
		/datum/reagent/consumable/ethanol/quadruple_sec,

		// Heals body part, brute, suffocation, burn, and toxin damage for security
		/datum/reagent/consumable/ethanol/quintuple_sec,

		// Heals brute, burn, toxin, suffocation, and stamina damage
		/datum/reagent/consumable/ethanol/bastion_bourbon,

		// Grants nutrition
		/datum/reagent/consumable/ethanol/squirt_cider,

		// Grants nutrition
		/datum/reagent/consumable/ethanol/sugar_rush,

		// Grants soothed throat effect and increases temperature
		/datum/reagent/consumable/ethanol/peppermint_patty,

		// Removes mighty shield reagent
		/datum/reagent/consumable/ethanol/alexander,

		// Heals brute and burn damage for sleeping users
		/datum/reagent/consumable/ethanol/between_the_sheets,

		// Removes nutrition and causes toxin damage
		/datum/reagent/consumable/ethanol/fernet,

		// Removes nutrition and causes toxin damage
		/datum/reagent/consumable/ethanol/fernet_cola,

		// Removes nutrition and clears overeating duration
		/datum/reagent/consumable/ethanol/fanciulli,

		// Reduces body temperature
		/datum/reagent/consumable/ethanol/branca_menta,

		// Heals body part damage for mimes
		/datum/reagent/consumable/ethanol/blank_paper,

		// Heals body part, suffocation, and toxin damage for wizards
		/datum/reagent/consumable/ethanol/wizz_fizz,

		// Causes toxin damage to insects
		/datum/reagent/consumable/ethanol/bug_spray,

		// Reduces stamina
		/datum/reagent/consumable/ethanol/turbo,

		// Increases age, changes hair color, causes nearsightedness, causes a beard
		/datum/reagent/consumable/ethanol/old_timer,

		// Heals burn damage, removes jittering, and removes stuttering for Chaplain
		/datum/reagent/consumable/ethanol/trappist,

		// Teleports the user
		/datum/reagent/consumable/ethanol/blazaam,

		// Increases temperature, and can cause ignition
		/datum/reagent/consumable/ethanol/mauna_loa,

		// Heals body part, brute, suffocation, fire, foxin, and radiation for the Captain
		/datum/reagent/consumable/ethanol/commander_and_chief,

		// Displays a chat message
		// /datum/reagent/consumable/ethanol/gunfire,

		// Increases temperature
		/datum/reagent/consumable/ethanol/hellfire,

		// Causes drugging and stamina loss
		/datum/reagent/consumable/ethanol/hotlime_miami,

		//
		// SPLURT effect drinks
		//

		// Causes clothing loss
		/datum/reagent/consumable/ethanol/panty_dropper,

		// Causes brain damage
		/datum/reagent/consumable/ethanol/lean,

		// Contains morphine
		/datum/reagent/consumable/ethanol/isloation_cell/morphine,

		// Contains hexacrocin, morphine, and enthrall
		/datum/reagent/consumable/ethanol/chemical_ex,

		// Captain drink
		/datum/reagent/consumable/ethanol/heart_of_gold,

		// Captain drink
		/datum/reagent/consumable/ethanol/moth_in_chief,

		// Replaces the tongue
		/datum/reagent/consumable/ethanol/skullfucker_deluxe,

		// End of special drinks

		// Drink reagents
		/datum/reagent/consumable/laughter,
		/datum/reagent/consumable/superlaughter,
		/datum/reagent/consumable/soymilk,
		/datum/reagent/consumable/soy_latte,

		// Normal reagents
		/datum/reagent/consumable/capsaicin,
		/datum/reagent/consumable/frostoil,
		/datum/reagent/consumable/condensedcapsaicin,
		/datum/reagent/consumable/garlic,
		/datum/reagent/consumable/sprinkles,
		/datum/reagent/consumable/enzyme,
		/datum/reagent/consumable/hot_ramen,
		/datum/reagent/consumable/hell_ramen,
		/datum/reagent/consumable/tearjuice,
		/datum/reagent/consumable/entpoly,
		/datum/reagent/consumable/vitfro,
		/datum/reagent/consumable/liquidelectricity,
		/datum/reagent/consumable/char,
		/datum/reagent/consumable/laughsyrup,
		/datum/reagent/consumable/honey,
	)

	// Define base list
	var/list/consumable_list = subtypesof(/datum/reagent/consumable)

	// Define additional allowed reagents
	LAZYADD(consumable_list, list(
		/datum/reagent/water,
		/datum/reagent/drug/aphrodisiac,
		/datum/reagent/drug/copium,
		/datum/reagent/blood
	))

	// Define final list
	var/list/reagent_list

	for(var/reagent in consumable_list)
		// Define reagent
		var/datum/reagent/instance = find_reagent_object_from_type(reagent)

		// Check if reagent exists
		if(!instance)
			continue

		// Check if reagent is non-liquid
		if(instance.reagent_state != LIQUID)
			// Ignore reagent
			continue

		// Check if reagent is blacklisted
		if(reagent in blacklisted)
			// Ignore reagent
			continue

		// Check if reagent is an ethanol sub-type
		if(istype(instance, /datum/reagent/consumable/ethanol))
			// Define ethanol reagent
			var/datum/reagent/consumable/ethanol/drink = instance

			// Check if booze power exceeds the defined limit
			if(drink.boozepwr > ETHANOL_GFLUID_POWER_LIMIT)
				// Ignore reagent
				continue

		// Add reagent to final list
		LAZYADD(reagent_list, instance)

	// Define GLOB from final list
	GLOB.genital_fluids_list = reagent_list

/proc/allowed_gfluid_paths()
	if(!GLOB.genital_fluids_list)
		build_genital_fluids_list()

	var/list/allowed
	for(var/datum/reagent/fluid in GLOB.genital_fluids_list)
		LAZYADD(allowed, fluid.type)

	return allowed
