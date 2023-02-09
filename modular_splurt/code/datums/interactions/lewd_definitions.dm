
/mob/living/cum(mob/living/partner, target_orifice)
	. = ..()
	if(src != partner)
		if(iswendigo(partner) && partner.pulling == src)
			var/mob/living/carbon/wendigo/W = partner
			W.slaves |= src
			to_chat(src, "<font color='red'> You are now [W]'s slave! Serve your master properly! </font>")