// Plushmium object reaction
/datum/reagent/fermi/plushmium/reaction_obj(obj/O, reac_volume)
	// Check for Headcoder plush
	if(istype(O, /obj/item/toy/plush/headcoder))
		// Warn in local chat
		O.loc.visible_message(span_warning("[src] is sprayed with a strange chemical, and vanishes in a puff of smoke!"))

		// Create an impostor plush
		new /obj/item/toy/plush/mammal(O.loc)

		// Create a smoke effect
		new /obj/effect/temp_visual/small_smoke(O.loc)

		// Send the real plush to a safe location
		O.forceMove(find_safe_turf())

		// Return without further effects
		return

	// Return normally
	. = ..()
