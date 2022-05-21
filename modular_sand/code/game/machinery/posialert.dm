/obj/machinery/posialert
	name = "automated positronic alert console"
	desc = "A console that will ping when a positronic personality is available for download."
	icon = 'modular_sand/icons/obj/machines/terminals.dmi'
	icon_state = "posialert"
	var/inuse = FALSE

/obj/machinery/posialert/attack_ghost(mob/user)
	. = ..()
	if(!online)
		return
	if(inuse)
		return
	inuse = TRUE
	flick("posialertflash",src)
	visible_message("There are positronic personalities available!")
	radio.talk_into(src, "There are positronic personalities available!", science_channel)
	playsound(loc, 'sound/machines/ping.ogg', 50)
	addtimer(CALLBACK(src, .proc/liftcooldown), 300)

/obj/machinery/posialert/proc/liftcooldown()
	inuse = FALSE
