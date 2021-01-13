/obj/screen/robot/lamp
	name = "headlamp"
	icon = 'sandcode/icons/mob/screen_cyborg.dmi'
	icon_state = "lamp_off"
	var/mob/living/silicon/robot/robot

/obj/screen/robot/lamp/Click()
	. = ..()
	if(.)
		return
	robot?.toggle_headlamp()
	update_icon()

/obj/screen/robot/lamp/update_icon()
	if(robot?.lamp_enabled)
		icon_state = "lamp_on"
	else
		icon_state = "lamp_off"

/obj/screen/robot/modPC
	name = "Modular Interface"
	icon = 'sandcode/icons/mob/screen_cyborg.dmi'
	icon_state = "template"
	var/mob/living/silicon/robot/robot

/obj/screen/robot/modPC/Click()
	. = ..()
	if(.)
		return
	robot.modularInterface?.interact(robot)

/obj/screen/robot/alerts
	name = "Alert Panel"
	icon = 'icons/mob/screen_ai.dmi'
	icon_state = "alerts"

/obj/screen/robot/alerts/Click()
	. = ..()
	if(.)
		return
	var/mob/living/silicon/robot/borgo = usr
	borgo.robot_alerts()
