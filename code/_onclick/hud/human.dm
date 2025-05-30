/atom/movable/screen/human
	icon = 'icons/mob/screen_midnight.dmi'

/atom/movable/screen/human/toggle
	name = "toggle"
	base_icon_state = "toggle"
	icon_state = "toggle"
	mouse_over_pointer = MOUSE_HAND_POINTER

/atom/movable/screen/human/toggle/Click()

	var/mob/targetmob = usr

	if(isobserver(usr))
		if(ishuman(usr.client.eye) && (usr.client.eye != usr))
			var/mob/M = usr.client.eye
			targetmob = M

	if(usr.hud_used.inventory_shown && targetmob.hud_used)
		usr.hud_used.inventory_shown = FALSE
		usr.client.screen -= targetmob.hud_used.toggleable_inventory
		// Sandstorm edit
		usr.client.screen -= targetmob.hud_used.extra_inventory
		// Sandstorm edit END
	else
		usr.hud_used.inventory_shown = TRUE
		usr.client.screen += targetmob.hud_used.toggleable_inventory
		// Sandstorm edit
		if(usr.hud_used.extra_shown)
			usr.client.screen += targetmob.hud_used.extra_inventory
		// Sandstorm edit END

	targetmob.hud_used.hidden_inventory_update(usr)
	// Sandstorm edit
	targetmob.hud_used.extra_inventory_update(usr)
	// Sandstorm edit END

	update_icon()

/atom/movable/screen/human/toggle/update_icon_state()
	. = ..()
	icon_state = check_on() ? "[base_icon_state]_on" : "[base_icon_state]"

/atom/movable/screen/human/toggle/proc/check_on()
	return hud.inventory_shown

// Sandstorm edit
/atom/movable/screen/human/toggle/extra
	name = "toggle extra"
	base_icon_state = "toggle_extra"
	icon_state = "toggle_extra"

/atom/movable/screen/human/toggle/extra/Click()

	var/mob/targetmob = usr

	if(isobserver(usr))
		if(ishuman(usr.client.eye) && (usr.client.eye != usr))
			var/mob/M = usr.client.eye
			targetmob = M

	if(usr.hud_used.extra_shown && targetmob.hud_used)
		usr.hud_used.extra_shown = FALSE
		usr.client.screen -= targetmob.hud_used.extra_inventory
	else
		usr.hud_used.extra_shown = TRUE
		usr.client.screen += targetmob.hud_used.extra_inventory

	targetmob.hud_used.extra_inventory_update(usr)

	update_icon()
//

/atom/movable/screen/human/toggle/extra/check_on()
	return hud.extra_shown

/atom/movable/screen/human/equip
	name = "equip"
	icon_state = "act_equip"
	mouse_over_pointer = MOUSE_HAND_POINTER

/atom/movable/screen/human/equip/Click()
	if(ismecha(usr.loc)) // stops inventory actions in a mech
		return TRUE
	var/mob/living/carbon/human/H = usr
	H.quick_equip()

/atom/movable/screen/devil
	invisibility = INVISIBILITY_ABSTRACT

/atom/movable/screen/devil/soul_counter
	icon = 'icons/mob/screen_gen.dmi'
	name = "souls owned"
	icon_state = "Devil-6"
	screen_loc = ui_devilsouldisplay

/atom/movable/screen/devil/soul_counter/proc/update_counter(souls = 0)
	invisibility = 0
	maptext = MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#FF0000'>[souls]</font></div>")
	switch(souls)
		if(0,null)
			icon_state = "Devil-1"
		if(1,2)
			icon_state = "Devil-2"
		if(3 to 5)
			icon_state = "Devil-3"
		if(6 to 8)
			icon_state = "Devil-4"
		if(9 to INFINITY)
			icon_state = "Devil-5"
		else
			icon_state = "Devil-6"

/atom/movable/screen/devil/soul_counter/proc/clear()
	invisibility = INVISIBILITY_ABSTRACT

/atom/movable/screen/ling
	invisibility = INVISIBILITY_ABSTRACT

/atom/movable/screen/ling/sting
	name = "current sting"
	screen_loc = ui_lingstingdisplay
	mouse_over_pointer = MOUSE_HAND_POINTER

/atom/movable/screen/ling/sting/Click()
	if(isobserver(usr))
		return
	var/mob/living/carbon/U = usr
	U.unset_sting()

/atom/movable/screen/ling/chems
	name = "chemical storage"
	icon_state = "power_display"
	screen_loc = ui_lingchemdisplay

#define ui_coolant_display "EAST,SOUTH+3:15"

/atom/movable/screen/synth
	invisibility = INVISIBILITY_ABSTRACT


/atom/movable/screen/synth/proc/clear()
	invisibility = INVISIBILITY_ABSTRACT

/atom/movable/screen/synth/proc/update_counter(mob/living/carbon/human/owner)
	invisibility = 0

/atom/movable/screen/synth/coolant_counter
	icon = 'icons/mob/screen_synth.dmi'
	name = "Coolant System Readout"
	icon_state = "coolant-3-1"
	screen_loc = ui_coolant_display
	var/jammed = 0

/atom/movable/screen/synth/coolant_counter/update_counter(mob/living/carbon/owner)
	..()
	var/valuecolor = "#ff2525"
	if(owner.stat == DEAD)
		maptext = MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='[valuecolor]'>ERR-0F</font></div>")
		icon_state = "coolant-3-1"
		return
	var/coolant_efficiency
	var/coolant
	if(!jammed)
		coolant_efficiency = owner.get_cooling_efficiency()
		coolant = owner.blood_volume
	else
		coolant_efficiency = rand(1, 15) / 10
		coolant = rand(1, 600)
		jammed--
	if(coolant > BLOOD_VOLUME_SAFE * owner.blood_ratio)	//I unfortunately have to use this else-if stack because switch doesn't support variables.
		valuecolor =  "#4bbd34"
	else if(coolant > BLOOD_VOLUME_OKAY * owner.blood_ratio)
		valuecolor = "#dabb0d"
	else if(coolant > BLOOD_VOLUME_BAD * owner.blood_ratio)
		valuecolor =  "#dd8109"
	else if(coolant > BLOOD_VOLUME_SURVIVE * owner.blood_ratio)
		valuecolor = "#e7520d"
	maptext = MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='[valuecolor]'>[round((coolant / (BLOOD_VOLUME_NORMAL * owner.blood_ratio)) * 100, 1)]</font></div>")

	var/efficiency_suffix
	var/state_suffix
	switch(coolant_efficiency)
		if(-INFINITY to 0.4)
			efficiency_suffix = "1"
		if(0.4 to 0.75)
			efficiency_suffix = "2"
		if(0.75 to 0.95)
			efficiency_suffix = "3"
		if(0.95 to 1.3)
			efficiency_suffix = "4"
		else
			efficiency_suffix = "5"
	var/obj/item/organ/lungs/ipc/L = owner.getorganslot(ORGAN_SLOT_LUNGS)
	if(istype(L) && L.is_cooling)
		state_suffix = "2"
	else
		state_suffix = "1"
	icon_state = "coolant-[efficiency_suffix]-[state_suffix]"

/atom/movable/screen/synth/coolant_counter/examine(mob/user)
	. = ..()
	var/mob/living/carbon/human/owner = hud.mymob
	if(owner.stat == DEAD)
		return
	var/coolant
	var/total_efficiency
	var/environ_efficiency
	var/suitlink_efficiency
	if(!jammed)
		coolant = owner.blood_volume
		total_efficiency = owner.get_cooling_efficiency()
		environ_efficiency = owner.get_environment_cooling_efficiency()
		suitlink_efficiency = owner.check_suitlinking()
	else
		coolant = rand(1, 600)
		total_efficiency = rand(1, 15) / 10
		environ_efficiency = rand(1, 20) / 10
	. += "<span class='notice'>Performing internal cooling system diagnostics:</span>"
	. += "<span class='notice'>Coolant level: [coolant] units, [round((coolant / (BLOOD_VOLUME_NORMAL * owner.blood_ratio)) * 100, 0.1)] percent</span>"
	. += "<span class='notice'>Current Cooling Efficiency: [round(total_efficiency * 100, 0.1)] percent, [suitlink_efficiency ? "<font color='green'>active suitlink detected</font>, guaranteeing <font color='green'>[suitlink_efficiency * 100]%</font> environmental cooling efficiency." : "environment viability: [round(environ_efficiency * 100, 0.1)] percent."]</span>"

/atom/movable/screen/synth/coolant_counter/proc/jam(amount, cap = 20)
	if(jammed > cap)	//Preserve previous more impactful event.
		return
	jammed = min(jammed + amount, cap)

/datum/hud/human/New(mob/living/carbon/human/owner)
	..()
	owner.overlay_fullscreen("see_through_darkness", /atom/movable/screen/fullscreen/special/see_through_darkness)

	var/widescreenlayout = FALSE //CIT CHANGE - adds support for different hud layouts depending on widescreen pref
	if(owner.client && owner.client.prefs && owner.client.prefs.widescreenpref) //CIT CHANGE - ditto
		widescreenlayout = TRUE // CIT CHANGE - ditto

	var/atom/movable/screen/using
	var/atom/movable/screen/inventory/inv_box

	using = new/atom/movable/screen/language_menu(null, src)
	using.icon = ui_style
	if(!widescreenlayout) // CIT CHANGE
		using.screen_loc = ui_boxlang // CIT CHANGE
	static_inventory += using

	using = new /atom/movable/screen/area_creator(null, src)
	using.icon = ui_style
	if(!widescreenlayout) // CIT CHANGE
		using.screen_loc = ui_boxarea // CIT CHANGE
	static_inventory += using

	using = new /atom/movable/screen/voretoggle(null, src) //We fancy Vore now
	using.icon = tg_ui_icon_to_cit_ui(ui_style)
	using.screen_loc = ui_voremode
	if(!widescreenlayout)
		using.screen_loc = ui_boxvore
	static_inventory += using

	action_intent = new /atom/movable/screen/act_intent/segmented(null, src)
	action_intent.icon = ui_style_modular(ui_style)
	action_intent.icon_state = "[action_intent.base_icon_state]_[mymob.a_intent]"
	static_inventory += action_intent

	assert_move_intent_ui(owner, TRUE)

	// clickdelay
	clickdelay = new(null, src)
	clickdelay.screen_loc = ui_clickdelay
	static_inventory += clickdelay

	// resistdelay
	resistdelay = new(null, src)
	resistdelay.screen_loc = ui_resistdelay
	static_inventory += resistdelay

	using = new /atom/movable/screen/drop(null, src)
	using.icon = ui_style
	using.screen_loc = ui_drop_throw
	static_inventory += using

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "uniform"
	inv_box.icon = ui_style
	inv_box.slot_id = ITEM_SLOT_ICLOTHING
	inv_box.icon_state = "uniform"
	inv_box.icon_full = "template"
	inv_box.screen_loc = ui_iclothing
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "suit"
	inv_box.icon = ui_style
	inv_box.slot_id = ITEM_SLOT_OCLOTHING
	inv_box.icon_state = "suit"
	inv_box.icon_full = "template"
	inv_box.screen_loc = ui_oclothing
	toggleable_inventory += inv_box

	build_hand_slots()

	using = new /atom/movable/screen/swap_hand(null, src)
	using.icon = ui_style
	using.icon_state = "swap_1"
	using.screen_loc = ui_swaphand_position(owner,1)
	static_inventory += using

	using = new /atom/movable/screen/swap_hand(null, src)
	using.icon = ui_style
	using.icon_state = "swap_2"
	using.screen_loc = ui_swaphand_position(owner,2)
	static_inventory += using

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "id"
	inv_box.icon = ui_style
	inv_box.icon_state = "id"
	inv_box.icon_full = "template_small"
	inv_box.screen_loc = ui_id
	inv_box.slot_id = ITEM_SLOT_ID
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "mask"
	inv_box.icon = ui_style
	inv_box.icon_state = "mask"
	inv_box.icon_full = "template"
	inv_box.screen_loc = ui_mask
	inv_box.slot_id = ITEM_SLOT_MASK
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "neck"
	inv_box.icon = ui_style
	inv_box.icon_state = "neck"
	inv_box.icon_full = "template"
	inv_box.screen_loc = ui_neck
	inv_box.slot_id = ITEM_SLOT_NECK
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "back"
	inv_box.icon = ui_style
	inv_box.icon_state = "back"
	inv_box.icon_full = "template"
	inv_box.screen_loc = ui_back
	inv_box.slot_id = ITEM_SLOT_BACK
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "left pocket"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.icon_full = "template_small"
	inv_box.screen_loc = ui_storage1
	inv_box.slot_id = ITEM_SLOT_LPOCKET
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "right pocket"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.icon_full = "template_small"
	inv_box.screen_loc = ui_storage2
	inv_box.slot_id = ITEM_SLOT_RPOCKET
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "suit storage"
	inv_box.icon = ui_style
	inv_box.icon_state = "suit_storage"
	inv_box.icon_full = "template"
	inv_box.screen_loc = ui_sstore1
	inv_box.slot_id = ITEM_SLOT_SUITSTORE
	static_inventory += inv_box

	using = new /atom/movable/screen/resist(null, src)
	using.icon = ui_style
	using.screen_loc = ui_overridden_resist // CIT CHANGE - changes this to overridden resist
	hotkeybuttons += using

	rest_icon = new /atom/movable/screen/rest(null, src)
	rest_icon.icon = ui_style
	rest_icon.screen_loc = ui_pull_resist
	static_inventory += rest_icon
	//END OF CIT CHANGES

	using = new /atom/movable/screen/human/toggle(null, src)
	using.icon = ui_style
	using.screen_loc = ui_inventory
	static_inventory += using

	using = new /atom/movable/screen/human/equip(null, src)
	using.icon = ui_style
	using.screen_loc = ui_equip_position(mymob)
	static_inventory += using

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "gloves"
	inv_box.icon = ui_style
	inv_box.icon_state = "gloves"
	inv_box.icon_full = "template"
	inv_box.screen_loc = ui_gloves
	inv_box.slot_id = ITEM_SLOT_GLOVES
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "eyes"
	inv_box.icon = ui_style
	inv_box.icon_state = "glasses"
	inv_box.icon_full = "template"
	inv_box.screen_loc = ui_glasses
	inv_box.slot_id = ITEM_SLOT_EYES
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "left ear" // Sandstorm edit
	inv_box.icon = ui_style
	inv_box.icon_state = "ears"
	inv_box.icon_full = "template"
	inv_box.screen_loc = ui_ears
	inv_box.slot_id = ITEM_SLOT_EARS_LEFT // Sandstorm Edit
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "head"
	inv_box.icon = ui_style
	inv_box.icon_state = "head"
	inv_box.icon_full = "template"
	inv_box.screen_loc = ui_head
	inv_box.slot_id = ITEM_SLOT_HEAD
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "shoes"
	inv_box.icon = ui_style
	inv_box.icon_state = "shoes"
	inv_box.icon_full = "template"
	inv_box.screen_loc = ui_shoes
	inv_box.slot_id = ITEM_SLOT_FEET
	toggleable_inventory += inv_box

	// Sandstorm edit
	using = new /atom/movable/screen/human/toggle/extra(null, src)
	using.icon = ui_style_modular(ui_style)
	using.screen_loc = ui_inventory_extra
	toggleable_inventory += using

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "underwear"
	inv_box.icon = ui_style_modular(ui_style)
	inv_box.icon_state = "underwear"
	inv_box.icon_full = "template"
	inv_box.screen_loc = ui_boxers
	inv_box.slot_id = ITEM_SLOT_UNDERWEAR // Sandstorm edit
	extra_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "socks"
	inv_box.icon = ui_style_modular(ui_style)
	inv_box.icon_state = "socks"
	inv_box.icon_full = "template"
	inv_box.screen_loc = ui_socks
	inv_box.slot_id = ITEM_SLOT_SOCKS // Sandstorm edit
	extra_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "shirt"
	inv_box.icon = ui_style_modular(ui_style)
	inv_box.icon_state = "shirt"
	inv_box.icon_full = "template"
	inv_box.screen_loc = ui_shirt
	inv_box.slot_id = ITEM_SLOT_SHIRT // Sandstorm edit
	extra_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "right ear"
	inv_box.icon = ui_style_modular(ui_style)
	inv_box.icon_state = "ears_extra"
	inv_box.icon_full = "template"
	inv_box.screen_loc = ui_ears_extra
	inv_box.slot_id = ITEM_SLOT_EARS_RIGHT // Sandstorm edit
	extra_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "wrists"
	inv_box.icon = ui_style_modular(ui_style)
	inv_box.icon_state = "wrists"
	inv_box.icon_full = "template"
	inv_box.screen_loc = ui_wrists
	inv_box.slot_id = ITEM_SLOT_WRISTS
	extra_inventory += inv_box
	//

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "belt"
	inv_box.icon = ui_style
	inv_box.icon_state = "belt"
	inv_box.icon_full = "template_small"
	inv_box.screen_loc = ui_belt
	inv_box.slot_id = ITEM_SLOT_BELT
	static_inventory += inv_box

	throw_icon = new /atom/movable/screen/throw_catch(null, src)
	throw_icon.icon = ui_style
	throw_icon.screen_loc = ui_drop_throw
	hotkeybuttons += throw_icon

	hunger = new /atom/movable/screen/hunger(null, src)
	infodisplay += hunger

	thirst = new /atom/movable/screen/thirst(null, src)
	infodisplay += thirst

	healths = new /atom/movable/screen/healths(null, src)
	healths.icon = ui_style_modular(ui_style, "health")
	infodisplay += healths

	staminas = new /atom/movable/screen/staminas(null, src)
	staminas.icon = ui_style_modular(ui_style, "stamina")
	infodisplay += staminas

	if(!CONFIG_GET(flag/disable_stambuffer))
		staminabuffer = new /atom/movable/screen/staminabuffer(null, src)
		staminabuffer.icon = ui_style_modular(ui_style, "stamina")
		infodisplay += staminabuffer
	//END OF CIT CHANGES

	healthdoll = new /atom/movable/screen/healthdoll(null, src)
	healthdoll.icon = ui_style_modular(ui_style, "health")
	infodisplay += healthdoll

	pull_icon = new /atom/movable/screen/pull(null, src)
	pull_icon.icon = ui_style
	pull_icon.update_icon()
	pull_icon.screen_loc = ui_pull_resist
	static_inventory += pull_icon

	lingchemdisplay = new /atom/movable/screen/ling/chems(null, src)
	infodisplay += lingchemdisplay

	lingstingdisplay = new /atom/movable/screen/ling/sting(null, src)
	infodisplay += lingstingdisplay

	devilsouldisplay = new /atom/movable/screen/devil/soul_counter(null, src)
	infodisplay += devilsouldisplay

	blood_display = new /atom/movable/screen/bloodsucker/blood_counter(null, src)	// Blood Volume
	infodisplay += blood_display

	vamprank_display = new /atom/movable/screen/bloodsucker/rank_counter(null, src)	// Bloodsucker Rank
	infodisplay += vamprank_display

	sunlight_display = new /atom/movable/screen/bloodsucker/sunlight_counter(null, src)	// Sunlight
	infodisplay += sunlight_display

	coolant_display = new /atom/movable/screen/synth/coolant_counter(null, src)	//Coolant & cooling efficiency readouts for Synths.
	infodisplay += coolant_display

	zone_select =  new /atom/movable/screen/zone_sel(null, src)
	zone_select.icon = ui_style
	zone_select.overlay_icon = ui_style_modular(ui_style, "zone")
	zone_select.update_icon()
	static_inventory += zone_select

	combo_display = new /atom/movable/screen/combo(null, src)
	infodisplay += combo_display

	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory + extra_inventory)) // Sandstorm edit
		if(inv.slot_id)
			inv_slots[TOBITSHIFT(inv.slot_id) + 1] = inv
			inv.update_icon()

	update_locked_slots()

/datum/hud/human/proc/assert_move_intent_ui(mob/living/carbon/human/owner = mymob, on_new = FALSE)
	var/atom/movable/screen/using
	// delete old ones
	var/list/atom/movable/screen/victims = list()
	victims += locate(/atom/movable/screen/mov_intent) in static_inventory
	victims += locate(/atom/movable/screen/sprintbutton) in static_inventory
	victims += locate(/atom/movable/screen/sprint_buffer) in static_inventory
	if(victims)
		static_inventory -= victims
		if(mymob?.client)
			mymob.client.screen -= victims
		QDEL_LIST(victims)

	// make new ones
	// walk/run
	using = new /atom/movable/screen/mov_intent(null, src)
	using.icon = tg_ui_icon_to_cit_ui(ui_style) // CIT CHANGE - overrides mov intent icon
	using.screen_loc = ui_movi
	using.update_icon()
	static_inventory += using
	if(!on_new)
		owner?.client?.screen += using

	if(!CONFIG_GET(flag/sprint_enabled))
		return

	// sprint button
	using = new /atom/movable/screen/sprintbutton(null, src)
	using.icon = tg_ui_icon_to_cit_ui(ui_style)
	using.icon_state = ((owner.combat_flags & COMBAT_FLAG_SPRINT_ACTIVE) ? "act_sprint_on" : "act_sprint")
	using.screen_loc = ui_movi
	static_inventory += using
	if(!on_new)
		owner?.client?.screen += using

	// same as above but buffer.
	sprint_buffer = new /atom/movable/screen/sprint_buffer(null, src)
	sprint_buffer.screen_loc = ui_sprintbufferloc
	static_inventory += sprint_buffer
	if(!on_new)
		owner?.client?.screen += using

/datum/hud/human/update_locked_slots()
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob
	if(!istype(H) || !H.dna.species)
		return
	var/datum/species/S = H.dna.species
	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory + extra_inventory)) // Sandstorm edit
		if(inv.slot_id)
			if(inv.slot_id in S.no_equip)
				inv.alpha = 128
			else
				inv.alpha = initial(inv.alpha)

/datum/hud/human/hidden_inventory_update(mob/viewer)
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(screenmob.hud_used.inventory_shown && screenmob.hud_used.hud_shown)
		if(H.shoes)
			H.shoes.screen_loc = ui_shoes
			screenmob.client.screen += H.shoes
		if(H.gloves)
			H.gloves.screen_loc = ui_gloves
			screenmob.client.screen += H.gloves
		if(H.ears)
			H.ears.screen_loc = ui_ears
			screenmob.client.screen += H.ears
		if(H.glasses)
			H.glasses.screen_loc = ui_glasses
			screenmob.client.screen += H.glasses
		if(H.w_uniform)
			H.w_uniform.screen_loc = ui_iclothing
			screenmob.client.screen += H.w_uniform
		if(H.wear_suit)
			H.wear_suit.screen_loc = ui_oclothing
			screenmob.client.screen += H.wear_suit
		if(H.wear_mask)
			H.wear_mask.screen_loc = ui_mask
			screenmob.client.screen += H.wear_mask
		if(H.wear_neck)
			H.wear_neck.screen_loc = ui_neck
			screenmob.client.screen += H.wear_neck
		if(H.head)
			H.head.screen_loc = ui_head
			screenmob.client.screen += H.head
	else
		if(H.shoes)
			screenmob.client.screen -= H.shoes
		if(H.gloves)
			screenmob.client.screen -= H.gloves
		if(H.ears)
			screenmob.client.screen -= H.ears
		if(H.glasses)
			screenmob.client.screen -= H.glasses
		if(H.w_uniform)
			screenmob.client.screen -= H.w_uniform
		if(H.wear_suit)
			screenmob.client.screen -= H.wear_suit
		if(H.wear_mask)
			screenmob.client.screen -= H.wear_mask
		if(H.wear_neck)
			screenmob.client.screen -= H.wear_neck
		if(H.head)
			screenmob.client.screen -= H.head


// Sandstorm edit
/datum/hud/human/extra_inventory_update(mob/viewer)
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(screenmob.hud_used.extra_shown && screenmob.hud_used.inventory_shown && screenmob.hud_used.hud_shown)
		if(H.ears_extra)
			H.ears_extra.screen_loc = ui_ears_extra
			screenmob.client.screen += H.ears_extra
		if(H.w_underwear)
			H.w_underwear.screen_loc = ui_boxers
			screenmob.client.screen += H.w_underwear
		if(H.w_socks)
			H.w_socks.screen_loc = ui_socks
			screenmob.client.screen += H.w_socks
		if(H.w_shirt)
			H.w_shirt.screen_loc = ui_shirt
			screenmob.client.screen += H.w_shirt
		if(H.wrists)
			H.wrists.screen_loc = ui_wrists
			screenmob.client.screen += H.wrists
	else
		if(H.ears_extra)
			screenmob.client.screen -= H.ears_extra
		if(H.w_underwear)
			screenmob.client.screen -= H.w_underwear
		if(H.w_socks)
			screenmob.client.screen -= H.w_socks
		if(H.w_shirt)
			screenmob.client.screen -= H.w_shirt
		if(H.wrists)
			screenmob.client.screen -= H.wrists
//

/datum/hud/human/persistent_inventory_update(mob/viewer)
	if(!mymob)
		return
	..()
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(screenmob.hud_used)
		if(screenmob.hud_used.hud_shown)
			if(H.s_store)
				H.s_store.screen_loc = ui_sstore1
				screenmob.client.screen += H.s_store
			if(H.wear_id)
				H.wear_id.screen_loc = ui_id
				screenmob.client.screen += H.wear_id
			if(H.belt)
				H.belt.screen_loc = ui_belt
				screenmob.client.screen += H.belt
			if(H.back)
				H.back.screen_loc = ui_back
				screenmob.client.screen += H.back
			if(H.l_store)
				H.l_store.screen_loc = ui_storage1
				screenmob.client.screen += H.l_store
			if(H.r_store)
				H.r_store.screen_loc = ui_storage2
				screenmob.client.screen += H.r_store
		else
			if(H.s_store)
				screenmob.client.screen -= H.s_store
			if(H.wear_id)
				screenmob.client.screen -= H.wear_id
			if(H.belt)
				screenmob.client.screen -= H.belt
			if(H.back)
				screenmob.client.screen -= H.back
			if(H.l_store)
				screenmob.client.screen -= H.l_store
			if(H.r_store)
				screenmob.client.screen -= H.r_store

	if(hud_version != HUD_STYLE_NOHUD)
		for(var/obj/item/I in H.held_items)
			I.screen_loc = ui_hand_position(H.get_held_index_of_item(I))
			screenmob.client.screen += I
	else
		for(var/obj/item/I in H.held_items)
			I.screen_loc = null
			screenmob.client.screen -= I


/mob/living/carbon/human/verb/toggle_hotkey_verbs()
	set category = "OOC"
	set name = "Toggle hotkey buttons"
	set desc = "This disables or enables the user interface buttons which can be used with hotkeys."

	if(hud_used.hotkey_ui_hidden)
		client.screen += hud_used.hotkeybuttons
		hud_used.hotkey_ui_hidden = FALSE
	else
		client.screen -= hud_used.hotkeybuttons
		hud_used.hotkey_ui_hidden = TRUE
