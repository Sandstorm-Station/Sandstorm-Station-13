/client
	var/datum/centcom_communications/messages_panel

/datum/admin_help_tickets
	var/obj/effect/statclick/centcomm_messages/mstatclick = new(null, null, null)

/datum/admin_help_tickets/Destroy()
	QDEL_NULL(mstatclick)
	. = ..()

/obj/effect/statclick/centcomm_messages

/obj/effect/statclick/centcomm_messages/Click()
	var/client/C = usr.client

	if(!check_rights(R_ADMIN))
		return

	if(!C.messages_panel)
		C.messages_panel = new()
	C.messages_panel.ui_interact(usr)

/obj/effect/statclick/centcomm_messages/proc/Action()
	Click()
