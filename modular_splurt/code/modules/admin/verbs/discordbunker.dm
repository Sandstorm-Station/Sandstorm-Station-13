/client/proc/discordbunker() //TODO: add bunker bypass stuffs
	set category = "Server"
	set name = "Toggle Discord Bunker"
	if(!SSdbcore.IsConnected())
		to_chat(usr, "<span class='adminnotice'>The Database is not connected/enabled!</span>")
		return

	var/new_dbun = !CONFIG_GET(flag/need_discord_to_join)
	CONFIG_SET(flag/need_discord_to_join, new_dbun)

	log_admin("[key_name(usr)] has toggled the Discord Bunker, it is now [new_dbun ? "on" : "off"]")
	message_admins("[key_name_admin(usr)] has toggled the Discord Bunker, it is now [new_dbun ? "enabled" : "disabled"].")
	SSblackbox.record_feedback("nested tally", "discord_toggle", 1, list("Toggle Panic Bunker", "[new_dbun ? "Enabled" : "Disabled"]"))
	send2adminchat("Discord Bunker", "[key_name(usr)] has toggled the Panic Bunker, it is now [new_dbun ? "enabled" : "disabled"].")
