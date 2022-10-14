/datum/hud/robot/New(mob/owner)
	. = ..()
	var/atom/movable/screen/using

	// Navigation
	using = new /atom/movable/screen/navigate
	using.screen_loc = ui_borg_navigate_menu
	static_inventory += using
