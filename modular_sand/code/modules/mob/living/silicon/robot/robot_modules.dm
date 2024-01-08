/obj/item/robot_module/engineering/Initialize(mapload)
	basic_modules += /obj/item/pen
	basic_modules += /obj/item/stack/sheet/plasmaglass/cyborg
	basic_modules += /obj/item/stack/sheet/plasmarglass/cyborg
	basic_modules += /obj/item/stack/sheet/plasteel/cyborg
	basic_modules += /obj/item/stack/sheet/mineral/plasma/cyborg
	. = ..()

/obj/item/robot_module/butler/Initialize(mapload)
	basic_modules -= /obj/item/reagent_containers/borghypo/borgshaker
	basic_modules += /obj/item/reagent_containers/borghypo/borgshaker/beershaker
	basic_modules += /obj/item/reagent_containers/borghypo/borgshaker/juiceshaker
	basic_modules += /obj/item/reagent_containers/borghypo/borgshaker/sodashaker
	basic_modules += /obj/item/reagent_containers/borghypo/borgshaker/miscshaker
	. = ..()

/datum/robot_energy_storage/plasma
	name = "Plasma Buffer Container"
	recharge_rate = 0

/obj/item/robot_module/syndicatejack
	name = "Syndicate"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/borg/sight/thermal,
		/obj/item/extinguisher,
		/obj/item/weldingtool/experimental,
		/obj/item/screwdriver/nuke,
		/obj/item/wrench/cyborg,
		/obj/item/crowbar/cyborg,
		/obj/item/wirecutters/cyborg,
		/obj/item/multitool/cyborg,
		/obj/item/gripper,
		/obj/item/cyborg_clamp,
		/obj/item/lightreplacer/cyborg,
		/obj/item/stack/sheet/metal/cyborg,
		/obj/item/stack/sheet/glass/cyborg,
		/obj/item/stack/sheet/rglass/cyborg,
		/obj/item/stack/rods/cyborg,
		/obj/item/stack/tile/plasteel/cyborg,
		/obj/item/destTagger/borg,
		/obj/item/stack/cable_coil/cyborg,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/stack/medical/gauze/cyborg,
		/obj/item/shockpaddles/cyborg,
		/obj/item/healthanalyzer/advanced,
		/obj/item/surgical_drapes/advanced,
		/obj/item/retractor/advanced,
		/obj/item/surgicaldrill/advanced,
		/obj/item/scalpel/advanced,
		/obj/item/gun/medbeam,
		/obj/item/reagent_containers/borghypo/syndicate,
		/obj/item/borg/lollipop,
		/obj/item/holosign_creator/cyborg,
		/obj/item/stamp/chameleon,
		/obj/item/borg_shapeshifter
		)

	ratvar_modules = list(
	/obj/item/clockwork/slab/cyborg/medical,
	/obj/item/clockwork/slab/cyborg/engineer,
	/obj/item/clockwork/replica_fabricator/cyborg)

	cyborg_base_icon = "synd_engi"
	moduleselect_icon = "malf"
	magpulsing = TRUE
	hat_offset = INFINITY
	canDispose = TRUE

/obj/item/robot_module/syndicatejack/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/syndicatejack_icons = sort_list(list(
		"Saboteur" = image(icon = 'icons/mob/robots.dmi', icon_state = "synd_engi"),
		"Medical" = image(icon = 'icons/mob/robots.dmi', icon_state = "synd_medical"),
		"Assault" = image(icon = 'icons/mob/robots.dmi', icon_state = "synd_sec"),
		))
	var/syndiejack_icon = show_radial_menu(R, R , syndicatejack_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
	switch(syndiejack_icon)
		if("Saboteur")
			cyborg_base_icon = "synd_engi"
			cyborg_icon_override = 'icons/mob/robots.dmi'
		if("Medical")
			cyborg_base_icon = "synd_medical"
			cyborg_icon_override = 'icons/mob/robots.dmi'
		if("Assault")
			cyborg_base_icon = "synd_sec"
			cyborg_icon_override = 'icons/mob/robots.dmi'
		else
			return FALSE
	return ..()

/obj/item/robot_module/syndicatejack/rebuild_modules()
    ..()
    var/mob/living/silicon/robot/syndicatejack = loc
    syndicatejack.scrambledcodes = TRUE // We're rouge now

/obj/item/robot_module/syndicatejack/remove_module(obj/item/I, delete_after)
    ..()
    var/mob/living/silicon/robot/syndicatejack = loc
    syndicatejack.scrambledcodes = FALSE // Friends with the AI again

/obj/item/robot_module/roleplay
	name = "Roleplay"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/extinguisher/mini,
		/obj/item/weldingtool/largetank/cyborg,
		/obj/item/screwdriver/cyborg,
		/obj/item/wrench/cyborg,
		/obj/item/crowbar/cyborg,
		/obj/item/wirecutters/cyborg,
		/obj/item/multitool/cyborg,
		/obj/item/stack/sheet/metal/cyborg,
		/obj/item/stack/sheet/glass/cyborg,
		/obj/item/stack/sheet/rglass/cyborg,
		/obj/item/stack/rods/cyborg,
		/obj/item/stack/tile/plasteel/cyborg,
		/obj/item/stack/cable_coil/cyborg,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/rsf/cyborg,
		/obj/item/reagent_containers/food/drinks/drinkingglass,
		/obj/item/reagent_containers/borghypo/borgshaker/beershaker,
		/obj/item/reagent_containers/borghypo/borgshaker/juiceshaker,
		/obj/item/reagent_containers/borghypo/borgshaker/sodashaker,
		/obj/item/reagent_containers/borghypo/borgshaker/miscshaker,
		/obj/item/soap/nanotrasen,
		/obj/item/borg/cyborghug,
		/obj/item/dogborg_nose,
		/obj/item/dogborg_tongue,
		/obj/item/borg_shapeshifter/stable)
	moduleselect_icon = "standard"
	hat_offset = -3

/obj/item/robot_module/Initialize(mapload)
	basic_modules += /obj/item/dildo/custom
	. = ..()
