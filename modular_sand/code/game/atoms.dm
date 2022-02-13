/atom
	var/icon/cum_splatter_icon

/atom/emag_act()
	. = ..()
	if(. && usr)
		balloon_alert(usr, "emagged")
