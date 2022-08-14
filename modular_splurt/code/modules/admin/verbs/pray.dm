// Save this message to be shown on the TGUI command messages panel (centcom_communications.dm)
/proc/log_command_message(text, mob/sender, is_emagged)
	var/msg = copytext_char(sanitize(text), 1, MAX_MESSAGE_LEN)
	var/list/message_log = list()

	message_log["id"] = GLOB.next_command_message_id++
	message_log["message"] = msg
	message_log["sender_ckey"] = sender.client.ckey
	message_log["sender_name"] = sender.real_name
	message_log["sender_job"] = sender.job
	message_log["time_sent"] = world.time
	message_log["was_emagged"] = is_emagged
	message_log["handled"] = FALSE

	LAZYADD(GLOB.centcom_communications_messages, list(message_log))
