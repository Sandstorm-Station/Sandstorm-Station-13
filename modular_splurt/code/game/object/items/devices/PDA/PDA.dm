//TODO: Refractor the whole PDA system to be on /mob/living/silicon and add the pda functions of all the other silicons from /tg/
/mob/living/silicon/robot/proc/cmd_send_pdamesg(mob/user)
	var/list/plist = list()
	var/list/namecounts = list()

	if(aiPDA.toff)
		to_chat(user, "Turn on your receiver in order to send messages.")
		return

	for (var/obj/item/pda/P in get_viewable_pdas())
		if (P == src)
			continue
		else if (P == aiPDA)
			continue

		plist[avoid_assoc_duplicate_keys(P.owner, namecounts)] = P

	var/c = input(user, "Please select a PDA") as null|anything in sortList(plist)

	if (!c)
		return

	var/selected = plist[c]

	if(aicamera.stored.len)
		var/add_photo = input(user,"Do you want to attach a photo?","Photo","No") as null|anything in list("Yes","No")
		if(add_photo=="Yes")
			var/datum/picture/Pic = aicamera.selectpicture(user)
			aiPDA.picture = Pic

	if(incapacitated())
		return

	aiPDA.create_message(src, selected)


/mob/living/silicon/robot/proc/cmd_show_message_log(mob/user)
	if(incapacitated())
		return
	if(!isnull(aiPDA))
		var/HTML = "<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><title>AI PDA Message Log</title></head><body>[aiPDA.tnote]</body></html>"
		user << browse(HTML, "window=log;size=400x444;border=1;can_resize=1;can_close=1;can_minimize=0")
	else
		to_chat(user, "You do not have a PDA. You should make an issue report about this.")
