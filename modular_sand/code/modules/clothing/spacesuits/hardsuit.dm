//Power armor
/obj/item/clothing/head/helmet/space/hardsuit/powerarmor
	name = "Power Armor Helmet MK. I"
	desc = "An advanced helmet attached to a powered exoskeleton suit. Protects well against most forms of harm, but struggles against exotic hazards."
	icon = 'modular_sand/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_sand/icons/mob/clothing/head_muzzled.dmi'
	icon_state = "hardsuit0-powerarmor-1"
	item_state = "hardsuit0-powerarmor-1"
	hardsuit_type = "powerarmor"
	clothing_flags = THICKMATERIAL //Ouchie oofie my bones
	armor = list("melee" = 40, "bullet" = 35, "laser" = 30, "energy" = 20, "bomb" = 40, "bio" = 100, "rad" = 5, "fire" = 75, "acid" = 100)
	resistance_flags = ACID_PROOF
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/head/helmet/space/hardsuit/powerarmor/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	update_icon()

/obj/item/clothing/head/helmet/space/hardsuit/powerarmor/update_overlays()
	. = ..()
	var/mutable_appearance/glass_overlay = mutable_appearance(icon, "hardsuit0-powerarmor-2")
	if(icon_state == "hardsuit1-powerarmor-1")
		glass_overlay = mutable_appearance(icon, "hardsuit1-powerarmor-2")
		var/mutable_appearance/flight_overlay = mutable_appearance(icon, "hardsuit1-powerarmor-3")
		flight_overlay.appearance_flags = RESET_COLOR
		. += flight_overlay
	glass_overlay.appearance_flags = RESET_COLOR
	. += glass_overlay

/obj/item/clothing/head/helmet/space/hardsuit/powerarmor/worn_overlays(isinhands, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(!isinhands)
		var/mutable_appearance/M1 = mutable_appearance(icon_file, "hardsuit0-powerarmor-2")
		if(icon_state == "hardsuit1-powerarmor-1")
			M1 = mutable_appearance(icon_file, "hardsuit1-powerarmor-2")
			var/mutable_appearance/M2 = mutable_appearance(icon, "hardsuit1-powerarmor-3")
			M2.appearance_flags = RESET_COLOR
			. += M2
		M1.appearance_flags = RESET_COLOR
		. += M1

/obj/item/clothing/head/helmet/space/hardsuit/powerarmor/equipped(mob/living/carbon/human/user, slot)
	..()
	if (slot == ITEM_SLOT_HEAD)
		var/datum/atom_hud/DHUD = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
		DHUD.add_hud_to(user)

/obj/item/clothing/head/helmet/space/hardsuit/powerarmor/dropped(mob/living/carbon/human/user)
	..()
	if (user.head == src)
		var/datum/atom_hud/DHUD = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
		DHUD.remove_hud_from(user)

/obj/item/clothing/suit/space/hardsuit/powerarmor
	name = "Power Armor MK. I"
	desc = "A self-powered exoskeleton suit comprised of flexible Plasteel sheets and advanced components, designed to offer excellent protection while still allowing mobility. Does not protect against Space, and struggles against more exotic hazards."
	icon = 'modular_sand/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_sand/icons/mob/clothing/suit_digi.dmi'
	icon_state = "hardsuit-powerarmor-1"
	item_state = "hardsuit-powerarmor-1"
	slowdown = -0.1
	clothing_flags = THICKMATERIAL //Not spaceproof. No, it isn't Spaceproof in Rimworld either.
	armor = list("melee" = 40, "bullet" = 35, "laser" = 30, "energy" = 20, "bomb" = 40, "bio" = 100, "rad" = 5, "fire" = 75, "acid" = 100) //I was asked to buff this again. Here, fine.
	resistance_flags = ACID_PROOF
	var/explodioprobemp = 1
	var/stamdamageemp = 200
	var/brutedamageemp = 20
	var/rebootdelay
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/powerarmor
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/space/hardsuit/powerarmor/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	update_icon()

/obj/item/clothing/suit/space/hardsuit/powerarmor/update_overlays()
	. = ..()
	var/mutable_appearance/black_overlay = mutable_appearance(icon, "hardsuit-powerarmor-2")
	black_overlay.appearance_flags = RESET_COLOR
	var/mutable_appearance/bluecore_overlay = mutable_appearance(icon, "hardsuit-powerarmor-3")
	bluecore_overlay.appearance_flags = RESET_COLOR
	. += black_overlay
	. += bluecore_overlay

/obj/item/clothing/suit/space/hardsuit/powerarmor/worn_overlays(isinhands, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(!isinhands)
		var/mutable_appearance/M1 = mutable_appearance(icon_file, "hardsuit-powerarmor-2")
		M1.appearance_flags = RESET_COLOR
		var/mutable_appearance/M2 = mutable_appearance(icon_file, "hardsuit-powerarmor-3")
		M2.appearance_flags = RESET_COLOR
		. += M1
		. += M2

/obj/item/clothing/suit/space/hardsuit/powerarmor/emp_act()
	. = ..()
	var/mob/living/carbon/human/user = src.loc
	playsound(src.loc, 'modular_sand/sound/misc/suitmalf.ogg', 60, 1, 10)
	if (ishuman(user) && (user.wear_suit == src))
		to_chat(user, span_danger("The motors on your armor cease to function, causing the full weight of the suit to weigh on you all at once!"))
		user.emote("scream")
		user.adjustStaminaLoss(stamdamageemp)
		user.adjustBruteLoss(brutedamageemp)
	if(prob(explodioprobemp))
		playsound(src.loc, 'sound/effects/fuse.ogg', 60, 1, 10)
		visible_message("<span class ='warning'>The power module on the [src] begins to smoke, glowing with an alarming warmth! Get away from it, now!")
		addtimer(CALLBACK(src, PROC_REF(detonate)),50)
	else
		addtimer(CALLBACK(src, PROC_REF(revivemessage)), rebootdelay)
		return

/obj/item/clothing/suit/space/hardsuit/powerarmor/proc/revivemessage() //we use this proc to add a timer, so we can have it take a while to boot
	visible_message("<span class ='warning'>The power module on the [src] briefly flickers, before humming to life once more.</span>") //without causing any problems
	return //that sleep() would

/obj/item/clothing/suit/space/hardsuit/powerarmor/proc/detonate()
	visible_message("<span class ='danger'>The power module of the [src] overheats, causing it to destabilize and explode!")
	explosion(src.loc,0,0,3,flame_range = 3)
	qdel(src)
	return

/obj/item/clothing/suit/space/hardsuit/mining
	unique_reskin = list(
		"Default" = list(
			"name" = "mining hardsuit",
			"desc" = "A special suit that protects against hazardous, low pressure environments. Has reinforced plating for wildlife encounters.",
			"icon" = 'icons/obj/clothing/suits.dmi',
			"icon_state" = "hardsuit-mining",
			"mob_overlay_icon" = null,
			"anthro_mob_worn_overlay" = null
		),
		"Conscript" = list(
			"name" = "Conscript suit",
			"desc" = "<span style=\"font-family:Lucida Console;font-size:85%\">..and so he left, with new orders and new questions.</span>",
			"icon" = 'modular_sand/icons/obj/clothing/suits.dmi',
			"icon_state" = "commando-armor",
			"mob_overlay_icon" = 'modular_sand/icons/mob/clothing/suit.dmi',
			"anthro_mob_worn_overlay" = 'modular_sand/icons/mob/clothing/suit_digi.dmi'
		)
	)

/obj/item/clothing/suit/space/hardsuit/mining/Move(atom/newloc, direct, glide_size_override)
	. = ..()
	setDir(SOUTH)

/obj/item/clothing/suit/space/hardsuit/mining/equipped(mob/user, slot)
	. = ..()
	switch(current_skin)
		if("Conscript")
			var/datum/component/armor_plate/armor_comp = GetComponent(/datum/component/armor_plate)
			var/armor_level = 0
			var/armor_max = 0
			if(armor_comp)
				armor_level = armor_comp.amount
				armor_max = armor_comp.maxamount

			upgrade_icon(amount = armor_level, maxamount = armor_max)

		else
			return

/obj/item/clothing/suit/space/hardsuit/mining/reskin_obj(mob/M)
	. = ..()
	var/datum/component/armor_plate/armor_comp = GetComponent(/datum/component/armor_plate)
	var/armor_level = 0
	var/armor_max = 0
	if(armor_comp)
		armor_level = armor_comp.amount
		armor_max = armor_comp.maxamount

	var/obj/item/clothing/head/helmet/space/hardsuit/mining/mining_helmet
	if(istype(helmet))
		mining_helmet = helmet

	/// h suffix for helmet
	var/datum/component/armor_plate/armor_comp_h = mining_helmet.GetComponent(/datum/component/armor_plate)
	var/armor_level_h = 0
	var/armor_max_h = 0
	if(armor_comp_h)
		armor_level_h = armor_comp_h.amount
		armor_max_h = armor_comp_h.maxamount

	switch(current_skin)
		if("Default")
			upgrade_icon(amount = armor_level, maxamount = armor_max)

			if(mining_helmet)
				mining_helmet.name = initial(mining_helmet.name)
				mining_helmet.desc = initial(mining_helmet.desc)
				mining_helmet.icon = initial(mining_helmet.icon)
				mining_helmet.icon_state = initial(mining_helmet.icon_state)
				mining_helmet.upgrade_icon(amount = armor_level_h, maxamount = armor_max_h)
				mining_helmet.mob_overlay_icon = initial(mining_helmet.mob_overlay_icon)
				mining_helmet.anthro_mob_worn_overlay = initial(mining_helmet.anthro_mob_worn_overlay)

		/// Sprited by Dexxiol#3462 :)
		if("Conscript")
			upgrade_icon(amount = armor_level, maxamount = armor_max)

			if(mining_helmet)
				mining_helmet.name = "Conscript helmet"
				mining_helmet.desc = "It shines briefly, full of life."
				mining_helmet.icon = 'modular_sand/icons/obj/clothing/hats.dmi'
				mining_helmet.icon_state = "commando-helmet"
				mining_helmet.upgrade_icon(amount = armor_level_h, maxamount = armor_max_h)
				mining_helmet.mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'
				mining_helmet.anthro_mob_worn_overlay = 'modular_sand/icons/mob/clothing/head_muzzled.dmi'

/obj/item/clothing/head/helmet/space/hardsuit/mining/update_icon_state()
	switch(suit.current_skin)
		if("Conscript")
			return
		else
			. = ..()

/obj/item/clothing/head/helmet/space/hardsuit/mining/upgrade_icon(datum/source, amount, maxamount)
	switch(suit.current_skin)
		if("Conscript")
			hardsuit_type = "-helmet"
			if(amount)
				name = "reinforced Conscript helmet"
				desc = "It glows weakly, signs of uncertainty."
				hardsuit_type = "2-helmet"
				if(amount == maxamount)
					desc = "It glows violently, martyr to chaos."
					hardsuit_type = "3-helmet"
			icon_state = "commando[hardsuit_type]"
			if(ishuman(loc))
				var/mob/living/carbon/human/wearer = loc
				if(istype(wearer) && (wearer.head == src))
					wearer.update_inv_head()
		else
			. = ..()

/obj/item/clothing/suit/space/hardsuit/mining/upgrade_icon(datum/source, amount, maxamount)
	switch(current_skin)
		if("Conscript")
			hardsuit_type = "-armor"
			if(amount)
				name = "reinforced Conscript suit"
				hardsuit_type = "2-armor"
				if(amount == maxamount)
					hardsuit_type = "3-armor"
			icon_state = "commando[hardsuit_type][current_equipped_slot != ITEM_SLOT_OCLOTHING ? "-inhand" : ""]"
			if(ishuman(loc))
				var/mob/living/carbon/human/wearer = loc
				if(istype(wearer) && (wearer.wear_suit == src))
					wearer.update_inv_wear_suit()
		else
			. = ..()


//Main code edits
/obj/item/clothing/suit/space/hardsuit/Initialize()
	. = ..()
	if(type == /obj/item/clothing/suit/space/hardsuit)
		icon = 'modular_sand/icons/obj/clothing/suits.dmi'
		mob_overlay_icon = 'modular_sand/icons/mob/clothing/suit.dmi'
		anthro_mob_worn_overlay = 'modular_sand/icons/mob/clothing/suit_digi.dmi'

/obj/item/clothing/suit/space/hardsuit/engine
	icon = 'modular_sand/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_sand/icons/mob/clothing/suit_digi.dmi'

/obj/item/clothing/head/helmet/space/hardsuit/Initialize()
	. = ..()
	if(type == /obj/item/clothing/head/helmet/space/hardsuit)
		mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'

/obj/item/clothing/head/helmet/space/hardsuit/engine
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'

//Own stuff
/obj/item/clothing/head/helmet/space/hardsuit/rd/hev
	name = "HEV Suit helmet"
	desc = "A Hazardous Environment Helmet. It fits snug over the suit and has a heads-up display for researchers. The flashlight seems broken, fitting considering this was made before the start of the millennium."
	icon = 'modular_sand/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_sand/icons/mob/clothing/head_muzzled.dmi'
	icon_state = "hev"
	item_state = "hev"
	resistance_flags = ACID_PROOF | FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	armor = list("melee" = 30, "bullet" = 10, "laser" = 10, "energy" = 5, "bomb" = 80, "bio" = 100, "rad" = 100, "fire" = 60, "acid" = 60)
	actions_types = list(/datum/action/item_action/toggle_research_scanner)

/obj/item/clothing/head/helmet/space/hardsuit/rd/hev/no_scanner
	actions_types = list()

/obj/item/clothing/suit/space/hardsuit/rd/hev
	name = "HEV Suit"
	desc = "The hazard suit. It was designed to protect scientists from the blunt trauma, radiation, energy discharge that hazardous materials might produce or entail. Fits you like a glove. The automatic medical system seems broken... They're waiting for you, Gordon. In the test chamber."
	icon = 'modular_sand/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_sand/icons/mob/clothing/suit_digi.dmi'
	icon_state = "hev"
	item_state = "hev"
	resistance_flags = ACID_PROOF | FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT //Same as an emergency firesuit. Not ideal for extended exposure.
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/gun/energy/wormhole_projector,
	/obj/item/hand_tele, /obj/item/aicard)
	armor = list("melee" = 30, "bullet" = 10, "laser" = 10, "energy" = 5, "bomb" = 80, "bio" = 100, "rad" = 100, "fire" = 60, "acid" = 60)
	mutantrace_variation = STYLE_DIGITIGRADE
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/rd/hev
	var/firstpickup = TRUE
	var/pickupsound = TRUE

/obj/item/clothing/suit/space/hardsuit/rd/hev/no_sound
	pickupsound = FALSE

/obj/item/clothing/suit/space/hardsuit/rd/hev/equipped(mob/user, slot)
	. = ..()
	if(!pickupsound)
		return
	if(!ishuman(user))
		return
	if(slot == ITEM_SLOT_OCLOTHING)
		if(!firstpickup)
			SEND_SOUND(user, sound('modular_sand/sound/halflife/hevsuit_pickup.ogg', volume = 50))
		else
			firstpickup = FALSE
			SEND_SOUND(user, sound('modular_sand/sound/halflife/hevsuit_firstpickup.ogg', volume = 50))
			SEND_SOUND(user, sound('modular_sand/sound/halflife/anomalous_materials.ogg', volume = 50))
	return

/obj/item/clothing/suit/space/hardsuit/shielded/goldenpa
	name = "Nanotrasen Power Armor"
	desc = "An advanced armor with built in energy shielding, developed by Nanotrasen via unknown means. It belongs by only few exclusive members of the corporation."
	icon = 'modular_sand/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_sand/icons/mob/clothing/suit_digi.dmi'
	icon_state = "golden_pa"
	item_state = "golden_pa"
	max_charges = 4
	current_charges = 4
	recharge_delay = 15
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	strip_delay = 130
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/transforming/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/shielded/goldenpa
	mutantrace_variation = STYLE_MUZZLE | STYLE_ALL_TAURIC
	slowdown = 0

/obj/item/clothing/suit/space/hardsuit/shielded/goldenpa/Initialize()
	jetpack = new /obj/item/tank/jetpack/suit(src)
	. = ..()

/obj/item/clothing/head/helmet/space/hardsuit/shielded/goldenpa
	name = "Nanotrasen Power Helmet"
	desc = "An advanced armor helmet with built in energy shielding, developed by Nanotrasen via unknown means. It belongs by only few exclusive members of the corporation."
	icon = 'modular_sand/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_sand/icons/mob/clothing/head_muzzled.dmi'
	icon_state = "hardsuit0-goldenpa"
	item_state = "hardsuit0-goldenpa"
	hardsuit_type = "goldenpa"
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	strip_delay = 130
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT

/obj/item/clothing/suit/space/hardsuit/teslapa
	name = "Tesla Power Armor"
	desc = "An advanced power armor, with built-in tesla technology. You're sure this will fry whoever dares attack in close quarters."
	icon = 'modular_sand/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_sand/icons/mob/clothing/suit_digi.dmi'
	icon_state = "tesla_pa"
	item_state = "tesla_pa"
	armor = list("melee" = 70, "bullet" = 70, "laser" = 90, "energy" = 90, "bomb" = 70, "bio" = 100, "rad" = 40, "fire" = 100, "acid" = 100)
	strip_delay = 300
	equip_delay_self = 300
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/transforming/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/teslapahelmet
	slowdown = 1
	siemens_coefficient = -1
	blood_overlay_type = "armor"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/hit_reaction_chance = 50
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	var/teslapa_cooldown = 20
	var/teslapa_cooldown_duration = 10
	var/tesla_power = 20000
	var/tesla_range = 4
	var/tesla_flags = ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE
	var/legacy = FALSE
	var/legacy_dmg = 35

/obj/item/clothing/suit/space/hardsuit/teslapa/Initialize()
	jetpack = new /obj/item/tank/jetpack/suit(src)
	. = ..()

/obj/item/clothing/suit/space/hardsuit/teslapa/dropped(mob/user)
	..()
	if(istype(user))
		REMOVE_TRAIT(user, TRAIT_TESLA_SHOCKIMMUNE, "reactive_teslapa_armor")

/obj/item/clothing/suit/space/hardsuit/teslapa/equipped(mob/user, slot)
	..()
	if(slot_flags & slot) //Was equipped to a valid slot for this item?
		ADD_TRAIT(user, TRAIT_TESLA_SHOCKIMMUNE, "reactive_teslapa_armor")

/obj/item/clothing/suit/space/hardsuit/teslapa/run_block(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = ATTACK_TYPE_MELEE)
	if(prob(hit_reaction_chance))
		if(world.time < teslapa_cooldown_duration)
			var/datum/effect_system/spark_spread/sparks = new /datum/effect_system/spark_spread
			sparks.set_up(1, 1, src)
			sparks.start()
			owner.visible_message(span_danger("The tesla capacitors on [owner]'s Tesla Power Armor are still recharging! The armor merely emits some sparks."))
			return
		owner.visible_message(span_danger("[src] blocks [attack_text], sending out arcs of lightning!"))
		if(!legacy)
			tesla_zap(owner, tesla_range, tesla_power, tesla_flags)
		else
			for(var/mob/living/M in view(2, owner))
				if(M == owner)
					continue
				owner.Beam(M,icon_state="purple_lightning",icon='icons/effects/effects.dmi',time=5)
				M.adjustFireLoss(legacy_dmg)
				playsound(M, 'sound/machines/defib_zap.ogg', 50, 1, -1)
		teslapa_cooldown = world.time + teslapa_cooldown_duration
		return TRUE

/obj/item/clothing/head/helmet/space/hardsuit/teslapahelmet
	name = "Tesla Power Armor Helmet"
	desc = "An advanced power armor, with built-in tesla technology. You're sure this will fry whoever dares attack in close quarters."
	icon = 'modular_sand/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_sand/icons/mob/clothing/head_muzzled.dmi'
	icon_state = "teslaup"
	item_state = "teslaup"
	armor = list("melee" = 70, "bullet" = 70, "laser" = 90, "energy" = 90, "bomb" = 70, "bio" = 100, "rad" = 10, "fire" = 100, "acid" = 100)
	strip_delay = 130
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT

/obj/item/clothing/suit/space/hardsuit/advancedpa
	name = "Advanced Power Armor"
	desc = "An advanced power armor. You're sure this is near to impossible to penetrate in close quarters."
	icon = 'modular_sand/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_sand/icons/mob/clothing/suit_digi.dmi'
	icon_state = "advanced_pa"
	item_state = "advanced_pa"
	armor = list("melee" = 95, "bullet" = 95, "laser" = 70, "energy" = 80, "bomb" = 70, "bio" = 100, "rad" = 40, "fire" = 100, "acid" = 100)
	strip_delay = 300 //chonky armor means chonky strip
	equip_delay_self = 300
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/transforming/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/advancedpahelmet
	slowdown = 0
	blood_overlay_type = "armor"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/clothing/suit/space/hardsuit/advancedpa/Initialize()
	jetpack = new /obj/item/tank/jetpack/suit(src)
	. = ..()

/obj/item/clothing/head/helmet/space/hardsuit/advancedpahelmet
	name = "Advanced Power Armor Helmet"
	desc = "An advanced power armor. You're sure this is almost impenetrable in close quarters."
	icon = 'modular_sand/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_sand/icons/mob/clothing/head_muzzled.dmi'
	icon_state = "adv_pa"
	item_state = "adv_pa"
	armor = list("melee" = 95, "bullet" = 90, "laser" = 70, "energy" = 80, "bomb" = 70, "bio" = 100, "rad" = 40, "fire" = 100, "acid" = 100)
	strip_delay = 300
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT

/obj/item/clothing/head/helmet/space/hardsuit/corpus
	name = "Corpus Ranger Helmet"
	desc = "The helmet component of a Corpus Ranger hardsuit, has a flashlight!."
	icon = 'modular_sand/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'
	icon_state = "hardsuit0-corpus"
	item_state = "hardsuit0-corpus"
	armor = list(MELEE = 10, BULLET = 5, LASER = 10, ENERGY = 5, BOMB = 10, BIO = 100, RAD = 75, FIRE = 50, ACID = 75, WOUND = 10)
	strip_delay = 300
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	hardsuit_type = "corpus"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)

/obj/item/clothing/suit/space/hardsuit/corpus
	name = "Corpus Ranger Hardsuit"
	desc = "A specially designed Corpus hardsuit that protects against space. Has energy shielding, though the device has faltered slightly with age."
	icon = 'modular_sand/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/suit.dmi'
	icon_state = "hardsuit-corpus"
	item_state = "hardsuit-corpus"
	max_integrity = 300
	armor = list(MELEE = 15, BULLET = 10, LASER = 15, ENERGY = 10, BOMB = 10, BIO = 100, RAD = 100, FIRE = 50, ACID = 75, WOUND = 15)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/t_scanner, /obj/item/construction/rcd, /obj/item/pipe_dispenser)
	siemens_coefficient = 0
	actions_types = list(/datum/action/item_action/toggle_helmet)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/corpus