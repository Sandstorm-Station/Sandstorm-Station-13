/datum/hud/robot/New(mob/owner)
	. = ..()

	var/atom/movable/screen/using

	//PDA message
	using = new /atom/movable/screen/robot/pda_msg_send
	using.screen_loc = ui_borg_pda_send
	using.hud = src
	static_inventory += using

	//PDA log
	using = new /atom/movable/screen/robot/pda_msg_show
	using.screen_loc = ui_borg_pda_log
	using.hud = src
	static_inventory += using

/atom/movable/screen/robot/pda_msg_send
	name = "PDA - Send Message"
	icon = 'icons/mob/screen_ai.dmi'
	icon_state = "pda_send"

/atom/movable/screen/robot/pda_msg_send/Click()
	if(..())
		return
	var/mob/living/silicon/robot/R = usr
	R.cmd_send_pdamesg(usr)

/atom/movable/screen/robot/pda_msg_show
	name = "PDA - Show Message Log"
	icon = 'icons/mob/screen_ai.dmi'
	icon_state = "pda_receive"

/atom/movable/screen/robot/pda_msg_show/Click()
	if(..())
		return
	var/mob/living/silicon/robot/R = usr
	R.cmd_show_message_log(usr)

