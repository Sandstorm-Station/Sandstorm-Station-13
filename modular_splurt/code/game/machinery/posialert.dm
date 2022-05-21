/obj/machinery/posialert
	var/online = TRUE
	var/obj/item/radio/radio
	var/radio_key = /obj/item/encryptionkey/headset_sci
	var/science_channel = "Science"

/obj/machinery/posialert/Initialize()
	. = ..()
	radio = new(src)
	radio.keyslot = new radio_key
	radio.listening = 0
	radio.recalculateChannels()

/obj/machinery/posialert/Destroy()
	QDEL_NULL(radio)
	return ..()


/obj/machinery/posialert/attack_hand(mob/living/user)
	online = !online
	to_chat(user, "<span class='warning'>You turn the posi-alert system [online ? "on" : "off"]!</span>")
	return
