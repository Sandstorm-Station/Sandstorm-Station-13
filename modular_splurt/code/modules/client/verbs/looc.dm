/client/looc(msg as text)
	if(!(SSdbcore.IsConnected() && CONFIG_GET(flag/need_discord_to_join) && CONFIG_GET(string/discordbotcommandprefix)))
		return ..()
	if(!SSdiscord) // SS is still starting
		to_chat(usr, span_notice("The server is still starting up. Please wait... "))
		return
	if(!usr)
		return
	if(usr?.ckey in GLOB.discord_passthrough)
		return ..()

	var/player_id = SSdiscord.lookup_id(usr?.ckey)

	if(!player_id)
		to_chat(usr, span_warning("You must link your discord account to your ckey in order to join the game. Join our <a style=\"color: #ff00ff;\" href=\"[CONFIG_GET(string/discordurl)]\">discord</a> and use the <span style=\"color: #ff00ff;\">[CONFIG_GET(string/discordbotcommandprefix)][CONFIG_GET(string/verification_command)]</span> command [CONFIG_GET(string/verification_channel) ? "as indicated in #[CONFIG_GET(string/verification_channel)] " : ""]. It won't take you more than two minutes :)<br>Ahelp or ask staff in the discord if this is an error."))
		return
	. = ..()
