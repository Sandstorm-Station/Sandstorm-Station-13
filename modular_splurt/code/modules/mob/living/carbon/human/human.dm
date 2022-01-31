// This HUD is set based on client data. The above proc is often called before the mob has a client and therefore won't work. Login is thus the better option, correct me if this is a bad idea. - Casper
/mob/living/carbon/human/Login()
	. = ..()
	set_antag_target_indicator()

/mob/living/carbon/human/Logout()
	. = ..()
	set_antag_target_indicator()
