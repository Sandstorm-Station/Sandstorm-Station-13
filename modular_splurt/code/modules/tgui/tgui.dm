/datum/tgui/get_payload(custom_data, with_data, with_static_data)
	if(!user.client)
		return
	. = ..()
