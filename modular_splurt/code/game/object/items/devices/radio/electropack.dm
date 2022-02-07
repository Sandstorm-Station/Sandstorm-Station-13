/obj/item/electropack/shockcollar/slave
	name = "slave collar"
	desc = "A reinforced metal collar. This one has a shock element and tracker installed."

	var/price = 0 // The ransom amount
	var/bought = FALSE // Has the station paid the ransom
	var/nextPriceChange = 0 // Last time the price was changed
	var/nextRansomChange = 0 // Last time the ransom was paid / cancelled
	shockStrength = 400
	shockCooldown = 200
	code = -1
	frequency = -1

/obj/item/electropack/shockcollar/slave/Initialize()
	GLOB.tracked_slaves += src
	. = ..()


/obj/item/electropack/shockcollar/slave/Destroy()
	visible_message("<span class='notice'>The [src] detaches from [src.loc]'s neck.</span>", \
		"<span class='notice'>The [src] detaches from your neck.</span>")
	playsound(get_turf(src.loc), 'sound/machines/terminal_eject_disc.ogg', 50, 1)

	GLOB.tracked_slaves -= src
	. = ..()

// Don't let user change frequency.
/obj/item/electropack/shockcollar/slave/attack_self(mob/living/user)
	return

// Once equipped, do not let anyone take it off
/obj/item/electropack/shockcollar/slave/equipped(mob/user, slot)
	. = ..()

	if(isliving(user))
		var/mob/living/M = user
		if(slot == SLOT_NECK)
			playsound(get_turf(M), 'sound/machines/triple_beep.ogg', 50, 1)
			ADD_TRAIT(src, TRAIT_NODROP, CLOTHING_TRAIT)

/obj/item/electropack/shockcollar/slave/proc/setPrice(newPrice)
	var/mob/living/M = loc
	var/announceMessage = "[M.real_name] has been captured. Send us [newPrice] credits with your communications console to get them back!"
	if (price) // If price has already been set once, we are just changing it
		if (newPrice > price) // Price has increased
			announceMessage = "[M.real_name]'s ransom has increased to [newPrice] credits."
		else // Price has decreased
			announceMessage = "[M.real_name]'s ransom has decreased to [newPrice] credits."


	price = newPrice
	nextPriceChange = world.time + 3000 // Cannot be changed again for 5 minutes
	priority_announce(announceMessage, sender_override = "[GLOB.slavers_team_name] Transmission")


/obj/item/electropack/shockcollar/slave/proc/setBought(isBought)
	bought = isBought
	nextRansomChange = world.time + 1200 // Cannot be changed again for 2 minutes
