//Text to radio
//Outputs a simple string into radio (good to couple with the interceptor)
//Input:
//Text: the actual string to output
//Frequency: what channel to output in. This is a STRING, not a number, due to how comms work. It has to be the frequency without the dot, aka for common you need to put "1459"
/obj/item/integrated_circuit/output/text_to_radio
	name = "text-to-radio circuit"
	desc = "Takes any string as an input and will make the device output it in the radio with the frequency chosen as input."
	extended_desc = "Similar to the text-to-speech circuit, except the fact that the text is converted into a subspace signal and broadcasted to the desired frequency, or 1459 as default.\
					The frequency is a number, and doesn't need the dot. Example: Common frequency is 145.9, so the result is 1459 as a number."
	icon_state = "speaker"
	complexity = 15
	inputs = list("text" = IC_PINTYPE_STRING, "frequency" = IC_PINTYPE_NUMBER)
	outputs = list("encryption keys" = IC_PINTYPE_LIST)
	activators = list("broadcast" = IC_PINTYPE_PULSE_IN)
	spawn_flags = IC_SPAWN_DEFAULT|IC_SPAWN_RESEARCH
	power_draw_per_use = 100
	cooldown_per_use = 0.1
	var/list/whitelisted_freqs = list() // special freqs can be used by inserting encryption keys
	var/list/encryption_keys = list()
	var/obj/item/radio/headset/integrated/radio

/obj/item/integrated_circuit/output/text_to_radio/Initialize()
	. = ..()
	radio = new(src)
	radio.frequency = FREQ_COMMON

/obj/item/integrated_circuit/output/text_to_radio/Destroy()
	qdel(radio)
	..()

/obj/item/integrated_circuit/output/text_to_radio/on_data_written()
	var/freq = get_pin_data(IC_INPUT, 2)
	if(!(freq in whitelisted_freqs))
		freq = sanitize_frequency(get_pin_data(IC_INPUT, 2), radio.freerange)
	radio.set_frequency(freq)

/obj/item/integrated_circuit/output/text_to_radio/do_work()
	text = get_pin_data(IC_INPUT, 1)
	if(!isnull(text))
		var/atom/movable/A = get_object()
		var/sanitized_text = sanitize(text)
		radio.talk_into(A, sanitized_text)
		if (assembly)
			log_say("[assembly] [REF(assembly)] : [sanitized_text]")

/obj/item/integrated_circuit/output/text_to_radio/attackby(obj/O, mob/user)
	if(istype(O, /obj/item/encryptionkey))
		user.transferItemToLoc(O,src)
		encryption_keys += O
		recalculate_channels()
		to_chat(user, "<span class='notice'>You slide \the [O] inside the circuit.</span>")
	else
		..()

/obj/item/integrated_circuit/output/text_to_radio/proc/recalculate_channels()
	whitelisted_freqs.Cut()
	set_pin_data(IC_INPUT, 2, 1459)
	radio.set_frequency(FREQ_COMMON) //reset it
	var/list/weakreffd_ekeys = list()
	for(var/o in encryption_keys)
		var/obj/item/encryptionkey/K = o
		weakreffd_ekeys += WEAKREF(K)
		for(var/i in K.channels)
			whitelisted_freqs |= GLOB.radiochannels[i]
	set_pin_data(IC_OUTPUT, 1, weakreffd_ekeys)


/obj/item/integrated_circuit/output/text_to_radio/attack_self(mob/user)
	if(encryption_keys.len)
		for(var/i in encryption_keys)
			var/obj/O = i
			O.forceMove(drop_location())
		encryption_keys.Cut()
		set_pin_data(IC_OUTPUT, 1, WEAKREF(null))
		to_chat(user, "<span class='notice'>You slide the encryption keys out of the circuit.</span>")
		recalculate_channels()
	else
		to_chat(user, "<span class='notice'>There are no encryption keys to remove from the mechanism.</span>")

/obj/item/radio/headset/integrated

//Hologram Projector
//Note: future me, if you don't fucking change the procs and other things on main code (phase vorestation's code you added) i will go kill you.
/obj/item/integrated_circuit/output/holographic_projector
	name = "holographic projector"
	desc = "This projects a holographic copy of an object."
	extended_desc = "If the assembly moves, the hologram will also move.<br>\
	Position coordinates are relative to the assembly, and are capped between -7 and 7.<br>\
	The assembly must be able to see the object to make a holographic copy of it.<br>\
	Scaling is capped between -2 and 2.<br>\
	The rotation pin uses degrees.<br>\
	Imitated object cannot be changed while projecting. Position, \
	scale, and rotation can be updated without restarting by pulsing the update hologram pin."
	complexity = 40
	icon = 'sandcode/icons/obj/integrated_electronics/electronic_components.dmi'
	icon_state = "holo_projector"
	inputs = list(
		"project hologram" = IC_PINTYPE_BOOLEAN,
		"object to copy" = IC_PINTYPE_REF,
		"hologram color" = IC_PINTYPE_COLOR,
		"hologram X pos" = IC_PINTYPE_NUMBER,
		"hologram Y pos" = IC_PINTYPE_NUMBER,
		"hologram scale" = IC_PINTYPE_NUMBER,
		"hologram rotation" = IC_PINTYPE_NUMBER
		)
	inputs_default = list(
		"3" = "#7DB4E1",
		"4" = 0,
		"5" = 0,
		"6" = 1,
		"7" = 0
		)
	outputs = list()
	activators = list(
		"update hologram" = IC_PINTYPE_PULSE_IN,
		"on drawn hologram" = IC_PINTYPE_PULSE_OUT
		)
	power_draw_idle = 0 // Raises to 500 when active, like a regular holopad.
	spawn_flags = IC_SPAWN_DEFAULT|IC_SPAWN_RESEARCH
	var/obj/effect/overlay/holographic/hologram = null // Reference to the hologram effect, and also used to see if component is active.
	var/icon/holo_base = null // Uncolored holographic icon.
//	var/datum/beam/holo_beam = null // A visual effect, to make it easy to know where a hologram is coming from.
	// It is commented out due to picking up the assembly killing the beam.
	var/toggled = FALSE

/obj/item/integrated_circuit/output/holographic_projector/Initialize()
	START_PROCESSING(SSmachines, src)
	. = ..()

/obj/item/integrated_circuit/output/holographic_projector/Destroy()
	destroy_hologram()
	STOP_PROCESSING(SSmachines, src)
	return ..()

/obj/item/integrated_circuit/output/holographic_projector/process()
	toggled = get_pin_data(IC_INPUT, 1)
	if(!toggled)
		destroy_hologram()

/obj/item/integrated_circuit/output/holographic_projector/do_work()
	if(hologram) // Currently active.
		update_hologram()

	else // Currently not active.
		if(toggled) // We're gonna turn on.
			create_hologram()

	activate_pin(2)

// Updates some changable aspects of the hologram like the size or position.
/obj/item/integrated_circuit/output/holographic_projector/proc/update_hologram()
	if(!hologram)
		return FALSE

	var/holo_scale = get_pin_data(IC_INPUT, 6)
	var/holo_rotation = get_pin_data(IC_INPUT, 7)

	if(!isnum(holo_scale) || !isnum(holo_rotation) )
		return FALSE // Invalid.

	hologram.adjust_scale(between(-2, holo_scale, 2) )
	hologram.adjust_rotation(holo_rotation)
	update_hologram_position()

	return TRUE

// This is a seperate function because other things besides do_work() might warrant updating position, like movement, without bothering with other parts.
/obj/item/integrated_circuit/output/holographic_projector/proc/update_hologram_position()
	var/holo_x = get_pin_data(IC_INPUT, 4)
	var/holo_y = get_pin_data(IC_INPUT, 5)
	if(!isnum(holo_x) || !isnum(holo_y) )
		return FALSE

	holo_x = between(-7, holo_x, 7)
	holo_y = between(-7, holo_y, 7)

	var/turf/T = get_turf(src)
	if(T)
		// Absolute coordinates.
		var/holo_abs_x = T.x + holo_x
		var/holo_abs_y = T.y + holo_y
		var/turf/W = locate(holo_abs_x, holo_abs_y, T.z)
		if(W) // Make sure we're not out of bounds.
			hologram.forceMove(W)
		return TRUE
	return FALSE

/obj/item/integrated_circuit/output/holographic_projector/proc/create_hologram()
	var/atom/movable/AM = get_pin_data_as_type(IC_INPUT, 2, /atom/movable)
	var/holo_color = get_pin_data(IC_INPUT, 3)

	if(istype(AM) && assembly) //Removed AM in view, it would be better if the ref "carries" image data
		hologram = new(src)
		var/icon/holo_icon = getHologramIcon_Alt(getFlatIcon(AM), no_color = TRUE)
	//	holo_icon.GrayScale() // So it looks better colored.
		if(holo_color) // The color pin should ensure that it is a valid hex.
			holo_icon.ColorTone(holo_color)
		hologram.icon = holo_icon
		hologram.name = "[AM.name] (Hologram)"
		update_hologram()

//		holo_beam = assembly.Beam(hologram, icon_state = "holo_beam", time = INFINITY, maxdistance = world.view)
		power_draw_idle = 500
		return TRUE
	return FALSE

/obj/item/integrated_circuit/output/holographic_projector/proc/destroy_hologram()
	QDEL_NULL(hologram)

//	holo_beam.End()
//	QDEL_NULL(holo_beam)

	power_draw_idle = 0

/obj/item/integrated_circuit/output/holographic_projector/on_data_written()
	if(hologram)
		update_hologram()

/obj/item/integrated_circuit/output/holographic_projector/on_loc_moved(atom/oldloc)
	if(hologram)
		update_hologram_position()

/obj/item/integrated_circuit/output/holographic_projector/power_fail()
	if(hologram)
		destroy_hologram()
		set_pin_data(IC_INPUT, 1, FALSE)
