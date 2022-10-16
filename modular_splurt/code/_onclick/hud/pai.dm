/datum/hud/pai/New(mob/owner)
	. = ..()
	var/atom/movable/screen/using

	// Navigation
	using = new /atom/movable/screen/navigate
	static_inventory += using
