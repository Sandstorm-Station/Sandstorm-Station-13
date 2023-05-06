// Harmful nanites node
/datum/techweb_node/nanite_hazard/New()
	// Define designs to remove
	var/list/rem_designs = list(
		"spreading_nanites"
	)

	// Remove designs from the list
	LAZYREMOVE(design_ids, rem_designs)

	// Return
	. = ..()
