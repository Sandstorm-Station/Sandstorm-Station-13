/client/check_ip_intel()
	. = ..()
	if(ip_intel != initial(ip_intel) && ip_intel >= CONFIG_GET(number/ipintel_rating_bad))
		uses_vpn = TRUE

/client/proc/create_jobban_panel()
	QDEL_NULL(jobban_panel)

	jobban_panel = new(src)
