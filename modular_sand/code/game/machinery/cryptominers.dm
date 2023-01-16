/obj/machinery/cryptominer
	name = "cryptocurrency miner"
	desc = "This handy-dandy machine will produce credits for your enjoyment."
	icon = 'modular_sand/icons/obj/machines/cryptominer.dmi'
	icon_state = "off"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 20
	active_power_usage = 200
	circuit = /obj/item/circuitboard/machine/cryptominer
	init_process = FALSE // Don't process upon creation
	var/mining = FALSE
	var/miningtime = 3000
	var/miningpoints = 50
	var/temp_min = TCRYO			// 225K equals approximately -55F or -48C
	var/temp_mid = T0C				// 273K equals 32F or 0C
	var/temp_max = 500				// 500K equals approximately 440F or 226C
	var/mult_min = 0.2				// Multiplier used during temp_min
	var/mult_mid = 1				// Multiplier used during temp_mid
	var/mult_max = 3				// Multiplier used during temp_max
	var/heating_power = 100 		// Heat added each processing
	var/ignore_atmos = FALSE 		// Allow use in space
	var/datum/bank_account/pay_me = null

/obj/machinery/cryptominer/Initialize(mapload)
	. = ..()
	pay_me = SSeconomy.get_dep_account(ACCOUNT_CAR)
	
	// Read configurations
	use_power = CONFIG_GET(number/crypto_power_use_process)
	idle_power_usage = CONFIG_GET(number/crypto_power_use_idle)
	active_power_usage = CONFIG_GET(number/crypto_power_use_active)
	
	miningtime = CONFIG_GET(number/crypto_mining_time)
	miningpoints = CONFIG_GET(number/crypto_payout_amount)

	temp_min = CONFIG_GET(number/crypto_heat_threshold_min)
	temp_mid = CONFIG_GET(number/crypto_heat_threshold_mid)
	temp_max = CONFIG_GET(number/crypto_heat_threshold_max)

	mult_min = CONFIG_GET(number/crypto_multiplier_min)
	mult_mid = CONFIG_GET(number/crypto_multiplier_mid)
	mult_max = CONFIG_GET(number/crypto_multiplier_max)

	heating_power = CONFIG_GET(number/crypto_heat_power)
	ignore_atmos = CONFIG_GET(flag/crypto_ignore_atmos)

/obj/machinery/cryptominer/update_icon()
	. = ..()
	if(!is_operational())
		icon_state = "off"
	else if(mining)
		icon_state = "loop"
	else
		icon_state = "on"

/obj/machinery/cryptominer/Destroy()
	STOP_PROCESSING(SSmachines,src)
	return ..()

/obj/machinery/cryptominer/deconstruct()
	STOP_PROCESSING(SSmachines,src)
	return ..()

/obj/machinery/cryptominer/attackby(obj/item/W, mob/user, params)
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, W))
		return
	if(default_deconstruction_crowbar(W))
		return
	if(default_unfasten_wrench(user, W))
		return
	if(!mining && panel_open && user.a_intent == INTENT_HELP)
		var/id_card = W.GetID()
		if(id_card)
			var/obj/item/card/id/CARD = id_card
			if(CARD.bank_support != ID_FREE_BANK_ACCOUNT)
				to_chat(user, span_warning("This ID has no banking support whatsover, must be an older model..."))
				return
			if(!CARD.registered_account)
				to_chat(user, span_warning("ERROR: No bank account found."))
				return
			to_chat(user, span_notice("You link \the [CARD] to \the [src]."))
			pay_me = CARD.registered_account
			say("Now using [pay_me.account_holder ? "[pay_me.account_holder]'s" : span_boldwarning("ERROR")] account.")
			return

/obj/machinery/cryptominer/AltClick(mob/user)
	user.visible_message(span_warning("[user] begins resetting \the [src]."),
					span_warning("You begin resetting \the [src]."))
	balloon_alert(user, "resetting")
	if(do_after(user, 5 SECONDS, target = src))
		pay_me = SSeconomy.get_dep_account(ACCOUNT_CAR)
		say("Now using [pay_me.account_holder]'s account.")

/obj/machinery/cryptominer/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += span_notice("A little screen on the machine reads: Currently the linked bank account is [pay_me.account_holder ? "[pay_me.account_holder]'s" : span_boldwarning("ERROR")].")
	. += "Modify the destination of the credits using your id on it while it is inactive and has it's panel open."
	. += "Alt-Click to reset to the Cargo budget.</span>"

/obj/machinery/cryptominer/process()
	// Get turf
	var/turf/T = get_turf(src)
	if(!T)
		return

	// Check for tiles with no conductivity (space)
	if(T.thermal_conductivity == 0)
		// Cheat mode: Skip all atmos code and give points
		// Placed first, as servers are more likely to use it
		if(ignore_atmos)
			produce_points(3)
			return

		// Normal mode: Warn the user and stop processing
		else
			say("Invalid atmospheric conditions detected! Shutting off!")
			playsound(loc, 'sound/machines/beep.ogg', 50, TRUE, -1)
			set_mining(FALSE)
			return

	// Get air
	var/datum/gas_mixture/env = T.return_air()
	if(!env)
		return

	// Get temp
	var/env_temp = env.return_temperature()

	// Check for temperature effects
	// Minimum (most likely)
	if(env_temp <= temp_min)
		produce_points(mult_max)
	// Mid
	else if((env_temp <= temp_mid) && (env_temp >= temp_min))
		produce_points(mult_mid)	
	// Maximum
	else if((env_temp <= temp_max) && (env_temp >= temp_mid))
		produce_points(mult_min)
	// Overheat
	else if(env_temp >= temp_max)
		say("Critical overheating detected! Shutting off!")
		playsound(loc, 'sound/machines/beep.ogg', 50, TRUE, -1)
		set_mining(FALSE)
	
	// Increase heat by heating_power
	env.set_temperature(env_temp + heating_power)

	// Update air
	air_update_turf()

/obj/machinery/cryptominer/proc/produce_points(number)
	playsound(loc, 'sound/machines/ping.ogg', 50, TRUE, -1)
	if(pay_me)
		pay_me.adjust_money(FLOOR(miningpoints * number,1))

/obj/machinery/cryptominer/attack_hand(mob/living/user)
	. = ..()
	if(!is_operational())
		to_chat(user, span_warning("[src] has to be on to do this!"))
		balloon_alert(user, "no power!")
		return FALSE
	if(mining)
		set_mining(FALSE)
		visible_message(span_warning("[src] slowly comes to a halt."),
						span_warning("You turn off [src]."))
		balloon_alert(user, "turned off")
		return
	balloon_alert(user, "turned on")
	set_mining(TRUE)

/obj/machinery/cryptominer/proc/set_mining(new_value)
	if(new_value == mining)
		return //No changes
	mining = new_value
	if(mining)
		START_PROCESSING(SSmachines, src)
	else
		STOP_PROCESSING(SSmachines, src)
	update_icon()


/obj/machinery/cryptominer/syndie
	name = "syndicate cryptocurrency miner"
	desc = "This handy-dandy machine will produce credits for your enjoyment. It lasts a little longer."
	icon_state = "off_syndie"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 10
	active_power_usage = 100
	circuit = /obj/item/circuitboard/machine/cryptominer/syndie
	miningtime = 6000
	miningpoints = 100

/obj/machinery/cryptominer/syndie/update_icon()
	. = ..()
	if(!is_operational())
		icon_state = "off_syndie"
	else if(mining)
		icon_state = "loop_syndie"
	else
		icon_state = "on_syndie"

/obj/machinery/cryptominer/nanotrasen
	name = "nanotrasen cryptocurrency miner"
	desc = "This handy-dandy machine will produce credits for your enjoyment. This doesn't turn off easily."
	icon_state = "off_nano"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 1
	active_power_usage = 1
	miningtime = 600000
	miningpoints = 1000

/obj/machinery/cryptominer/nanotrasen/update_icon()
	. = ..()
	if(!is_operational())
		icon_state = "off_nano"
	else if(mining)
		icon_state = "loop_nano"
	else
		icon_state = "on_nano"
