/datum/hud
	/// Extra inventory slots visible?
	var/extra_shown = FALSE
	/// Equipped item screens that don't show up even if using the initial toggle
	var/list/extra_inventory = list()

	/// UI element for hunger
	var/atom/movable/screen/hunger
	/// UI element for thirst
	var/atom/movable/screen/thirst

/proc/ui_style_modular(ui_style, variant = "base")
	var/static/cache = list()

	var/check = LAZYACCESSASSOC(cache, ui_style, variant)
	if(check)
		return check

	switch(ui_style)
		if('icons/mob/screen_plasmafire.dmi')
			. = "modular_sand/icons/hud/screen_plasmafire/"
		if('icons/mob/screen_slimecore.dmi')
			. = "modular_sand/icons/hud/screen_slimecore/"
		if('icons/mob/screen_operative.dmi')
			. = "modular_sand/icons/hud/screen_operative/"
		if('icons/mob/screen_clockwork.dmi')
			. = "modular_sand/icons/hud/screen_clockwork/"
		if('icons/mob/screen_glass.dmi')
			. = "modular_sand/icons/hud/screen_glass/"
		if('icons/mob/screen_trasenknox.dmi')
			. = "modular_sand/icons/hud/screen_trasenknox/"
		if('icons/mob/screen_detective.dmi')
			. = "modular_sand/icons/hud/screen_detective/"
		if('modular_sand/icons/hud/screen_liteweb/base.dmi')
			. = "modular_sand/icons/hud/screen_liteweb/"
		if('modular_sand/icons/hud/screen_corru/base.dmi')
			. = "modular_sand/icons/hud/screen_corru/"
		else
			. = "modular_sand/icons/hud/screen_midnight/"

	. = file("[.][variant].dmi")
	LAZYADDASSOC(cache, ui_style, variant)
	cache[ui_style][variant] = .

// Called after updating extra inventory
/datum/hud/proc/extra_inventory_update()
	return
