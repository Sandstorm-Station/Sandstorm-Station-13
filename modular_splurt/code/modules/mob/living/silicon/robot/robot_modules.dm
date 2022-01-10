/obj/item/robot_module/standard/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/stand_icons
	if(!stand_icons)
		stand_icons = list(
			"Standard" = image(icon = 'icons/mob/robots.dmi', icon_state = "robot"),
			"BootyF" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "bootystandard"),
			"BootyM" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "bootystandardM"),
			"BootyS" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "bootystandardS")
		)
		stand_icons = sortList(stand_icons)
	var/stand_borg_icon = show_radial_menu(R, R , stand_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
	if(!stand_borg_icon)
		return
	switch(stand_borg_icon)
		if("Standard")
			cyborg_base_icon = "robot"
		if("BootyF")
			cyborg_base_icon = "bootystandard"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyM")
			cyborg_base_icon = "bootystandardM"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyS")
			cyborg_base_icon = "bootystandardS"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
	return ..()

/obj/item/robot_module/clown/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/clown_icons
	if(!clown_icons)
		clown_icons = list(
			"Standard" = image(icon = 'icons/mob/robots.dmi', icon_state = "clown"),
			"BootyF" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "bootystandard"),
			"BootyM" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "bootystandardM"),
			"BootyS" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "bootystandardS")
		)
		clown_icons = sortList(clown_icons)
	var/clown_borg_icon = show_radial_menu(R, R , clown_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
	if(!clown_borg_icon)
		return
	switch(clown_borg_icon)
		if("Standard")
			cyborg_base_icon = "clown"
		if("BootyF")
			cyborg_base_icon = "bootyclown"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyM")
			cyborg_base_icon = "bootyclownM"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyS")
			cyborg_base_icon = "bootyclownS"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
	return ..()
