/mob/dead/new_player/Login()
	. = ..()
	if(!(client?.prefs.toggles & TG_PLAYER_PANEL))
		new_player_panel()
