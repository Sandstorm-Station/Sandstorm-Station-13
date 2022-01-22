/obj/item/choice_beacon/hosgun
    desc = "Use this to summon your personal Head of Security issued sidearm!"

/obj/item/choice_beacon/copgun
	name = "personal weapon beacon"
	desc = "Use this to summon your personal Security issued sidearm!"

/obj/item/choice_beacon/copgun/generate_display_names()
	var/static/list/cop_gun_list
	if(!cop_gun_list)
		cop_gun_list = list()
		var/list/templist = subtypesof(/obj/item/storage/secure/briefcase/cop/) //we have to convert type = name to name = type, how lovely!
		for(var/V in templist)
			var/atom/A = V
			cop_gun_list[initial(A.name)] = A
	return cop_gun_list

/obj/item/device/hailer
	name = "hailer"
	desc = "Used by obese officers to save their breath for running."
	icon = 'modular_splurt/icons/obj/device.dmi'
	icon_state = "voice0"
	item_state = "flashbang"	//looks exactly like a flash (and nothing like a flashbang)
	w_class = WEIGHT_CLASS_TINY
	var/use_message = "Halt! Security!"
	var/spamcheck = 0
	var/insults

/obj/item/device/hailer/verb/set_message()
	set name = "Set Hailer Message"
	set category = "Object"
	set desc = "Alter the message shouted by your hailer."

	if(!isnull(insults))
		usr << "The hailer is fried. The tiny input screen just shows a waving ASCII penis."
		return

	var/new_message = input(usr, "Please enter new message (leave blank to reset).") as text
	if(!new_message || new_message == "")
		use_message = "Halt! Security!"
	else
		use_message = capitalize(copytext(sanitize(new_message), 1, MAX_MESSAGE_LEN))

	usr << "You configure the hailer to shout \"[use_message]\"."

/obj/item/device/hailer/attack_self(mob/living/carbon/user as mob)
	if (spamcheck)
		return

	if(isnull(insults))
		playsound(get_turf(src), 'modular_splurt/sound/voice/halt.ogg', 100, 1, vary = 0)
		user.audible_message("<span class='warning'>[user]'s [name] rasps, \"[use_message]\"</span>", "<span class='warning'>\The [user] holds up \the [name].</span>")
	else
		if(insults > 0)
			playsound(get_turf(src), 'sound/voice/beepsky/insult.ogg', 100, 1, vary = 0)
			// Yes, it used to show the transcription of the sound clip. That was a) inaccurate b) immature as shit.
			user.audible_message("<span class='warning'>[user]'s [name] gurgles something indecipherable and deeply offensive.</span>", "<span class='warning'>\The [user] holds up \the [name].</span>")
			insults--
		else
			user << "<span class='danger'>*BZZZZZZZZT*</span>"

	spamcheck = 1
	spawn(20)
		spamcheck = 0

/obj/item/device/hailer/emag_act(remaining_charges, mob/user)
	if(isnull(insults))
		user << "<span class='danger'>You overload \the [src]'s voice synthesizer.</span>"
		insults = rand(1, 3)//to prevent dickflooding
		return 1
	else
		user << "The hailer is fried. You can't even fit the sequencer into the input slot."


/obj/item/disk/data
	max_mutations = 15
