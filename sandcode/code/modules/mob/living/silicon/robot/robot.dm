/mob/living/silicon/robot
	speed = 0.2
	var/hasShrunk = FALSE
	///Set to true if a doomsday event is locking our lamp to on and RED
	var/lamp_doom = FALSE
	//Maximum brightness of a borg lamp. Set as a var for easy adjusting.
	var/lamp_max = 10

/**
 * Handles headlamp smashing
 *
 * When called (such as by the shadowperson lighteater's attack), this proc will break the borg's headlamp
 * and then call toggle_headlamp to disable the light. It also plays a sound effect of glass breaking, and
 * tells the borg what happened to its chat. Broken lights can be repaired by using a flashlight on the borg.
 */
/mob/living/silicon/robot/proc/smash_headlamp()
	if(!lamp_functional)
		return
	lamp_functional = FALSE
	playsound(src, 'sound/effects/glass_step.ogg', 50)
	toggle_headlamp(TRUE)
	to_chat(src, "<span class='danger'>Your headlamp is broken! You'll need a human to help replace it.</span>")

/**
 * Handles headlamp toggling, disabling, and color setting.
 *
 * The initial if statment is a bit long, but the gist of it is that should the lamp be on AND the update_color
 * arg be true, we should simply change the color of the lamp but not disable it. Otherwise, should the turn_off
 * arg be true, the lamp already be enabled, any of the normal reasons the lamp would turn off happen, or the
 * update_color arg be passed with the lamp not on, we should set the lamp off. The update_color arg is only
 * ever true when this proc is called from the borg tablet, when the color selection feature is used.
 *
 * Arguments:
 * * arg1 - turn_off, if enabled will force the lamp into an off state (rather than toggling it if possible)
 * * arg2 - update_color, if enabled, will adjust the behavior of the proc to change the color of the light if it is already on.
 */
/mob/living/silicon/robot/proc/toggle_headlamp(turn_off = FALSE, update_color = FALSE)
	//if both lamp is enabled AND the update_color flag is on, keep the lamp on. Otherwise, if anything listed is true, disable the lamp.
	if(!(update_color && lamp_enabled) && (turn_off || lamp_enabled || update_color || !lamp_functional || stat || low_power_mode))
		if(lamp_functional && stat != DEAD && lamp_doom)
			set_light(l_power = TRUE) //If the lamp isn't broken and borg isn't dead, doomsday borgs cannot disable their light fully.
			set_light(l_color = "#FF0000") //This should only matter for doomsday borgs, as any other time the lamp will be off and the color not seen
			set_light(l_range = 1) //Again, like above, this only takes effect when the light is forced on by doomsday mode.
		set_light(l_power = FALSE)
		lamp_enabled = FALSE
		lampButton?.update_icon()
		update_icons()
		return
	set_light(l_range = lamp_intensity)
	set_light(l_color = (lamp_doom? "#FF0000" : lamp_color)) //Red for doomsday killborgs, borg's choice otherwise
	set_light(l_power = TRUE)
	lamp_enabled = TRUE
	lampButton?.update_icon()
	update_icons()

/mob/living/silicon/robot/proc/create_modularInterface()
	if(!modularInterface)
		modularInterface = new /obj/item/modular_computer/tablet/integrated(src)
	modularInterface.layer = ABOVE_HUD_PLANE
	modularInterface.plane = ABOVE_HUD_PLANE

/mob/living/silicon/robot/modules/syndicate/create_modularInterface()
	if(!modularInterface)
		modularInterface = new /obj/item/modular_computer/tablet/integrated/syndicate(src)
	return ..()

/**
  * Records an IC event log entry in the cyborg's internal tablet.
  *
  * Creates an entry in the borglog list of the cyborg's internal tablet, listing the current
  * in-game time followed by the message given. These logs can be seen by the cyborg in their
  * BorgUI tablet app. By design, logging fails if the cyborg is dead.
  *
  * Arguments:
  * arg1: a string containing the message to log.
 */
/mob/living/silicon/robot/proc/logevent(var/string = "")
	if(!string)
		return
	if(stat == DEAD) //Dead borgs log no longer
		return
	if(!modularInterface)
		stack_trace("Cyborg [src] ( [type] ) was somehow missing their integrated tablet. Please make a bug report.")
		create_modularInterface()
	modularInterface.borglog += "[STATION_TIME_TIMESTAMP("hh:mm:ss", world.time)] - [string]"
	var/datum/computer_file/program/robotact/program = modularInterface.get_robotact()
	if(program)
		program.force_full_update()
