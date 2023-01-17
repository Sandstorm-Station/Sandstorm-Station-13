/datum/admins/proc/kick(mob/M)
	if (!ismob(M) || !M.client)
		to_chat(usr, span_danger("Error: [M] has no client!"))
		return

	if(!check_if_greater_rights_than(M.client))
		to_chat(usr, span_danger("Error: They have more rights than you do."))
		return

	to_chat(M, span_danger("You have been kicked from the server by [usr.client.holder.fakekey ? "an Administrator" : "[usr.client.key]"]."))
	log_admin("[key_name(usr)] kicked [key_name(M)].")
	message_admins(span_adminnotice("[key_name_admin(usr)] kicked [key_name_admin(M)]."))
	qdel(M.client)
