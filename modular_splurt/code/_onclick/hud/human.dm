/datum/hud/human/New(mob/living/carbon/human/owner)
	. = ..()
	var/atom/movable/screen/using

	using = new/atom/movable/screen/navigate
	using.icon = ui_style_splurt(ui_style)
	using.hud = src
	static_inventory += using
