/obj/machinery/camera/examine(mob/user)
	. += ..()
	if(isEmpProof())
		. += "It has electromagnetic interference shielding installed."
	else
		. += "<span class='info'>It can be shielded against electromagnetic interference with some <b>plasma</b>.</span>"
	if(isXRay())
		. += "It has an X-ray photodiode installed."
	else
		. += "<span class='info'>It can be upgraded with an X-ray photodiode with an <b>analyzer</b>.</span>"
	if(isMotion())
		. += "It has a proximity sensor installed."
	else
		. += "<span class='info'>It can be upgraded with a <b>proximity sensor</b>.</span>"

	if(!status)
		. += "<span class='info'>It's currently deactivated.</span>"
		if(!panel_open && powered())
			. += "<span class='notice'>You'll need to open its maintenance panel with a <b>screwdriver</b> to turn it back on.</span>"
	if(panel_open)
		. += "<span class='info'>Its maintenance panel is currently open.</span>"
		if(!status && powered())
			. += "<span class='info'>It can reactivated with <b>wirecutters</b>.</span>"
