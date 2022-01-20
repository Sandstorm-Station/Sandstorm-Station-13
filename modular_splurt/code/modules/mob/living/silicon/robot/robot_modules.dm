/obj/item/robot_module/standard/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/stand_icons
	if(!stand_icons)
		stand_icons = list(
			"Standard" = image(icon = 'icons/mob/robots.dmi', icon_state = "robot"),
			"MissM" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "missm_sd"),
			"Protectron" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "protectron_standard"),
			"Zoomba" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "zoomba_standard"),
			"Marina" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "marinasd"),
			"Heavy" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "heavysd"),
			"Eyebot" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "eyebotsd"),
			"RoboMaid" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "robomaid_sd"),
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
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
		if("MissM")
			cyborg_base_icon = "missm_sd"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
		if("Protectron")
			cyborg_base_icon = "protectron_standard"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
		if("Zoomba")
			cyborg_base_icon = "zoomba_standard"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
		if("Marina")
			cyborg_base_icon = "marinasd"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
		if("Heavy")
			cyborg_base_icon = "heavysd"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
		if("Eyebot")
			cyborg_base_icon = "eyebotsd"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
		if("RoboMaid")
			cyborg_base_icon = "robomaid_sd"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
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
			"ClownMan" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "clownman"),
			"ClownBot" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "clownbot"),
			"Garish" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "garish"),
			"Clowne" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "clownkeep"),
			"Marina" = image(icon = 'modular_splurt/icons/mob/robots.dmi', icon_state = "marina_mommy"),
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
		if("ClownMan")
			cyborg_base_icon = "clownman"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
		if("ClownBot")
			cyborg_base_icon = "clownbot"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
		if("Garish")
			cyborg_base_icon = "garish"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
		if("Clowne")
			cyborg_base_icon = "clownkeep"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
		if("Marina")
			cyborg_base_icon = "marina_mommy"
			cyborg_icon_override = 'modular_splurt/icons/mob/robots.dmi'
			hat_offset = 3
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
