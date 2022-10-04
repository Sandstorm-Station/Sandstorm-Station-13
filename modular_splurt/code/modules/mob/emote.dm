/mob/emote(act, m_type, message, intentional)
	. = ..()
	SEND_SIGNAL(src, COMSIG_MOB_EMOTE, args)
