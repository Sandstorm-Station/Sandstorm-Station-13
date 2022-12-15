//Academy Items

/obj/item/dice/d20/fate
	var/list/used_fingerprints = null // Used to track who used the one_use die

/obj/item/dice/d20/fate/one_use
	reusable = 1 // Obsolete by the used_fingerprints list

/obj/item/dice/d20/fate/diceroll(mob/user)
	// This override checks if a user has rolled the dice
	// If true; Reject them and abort
	if (user in used_fingerprints)
		to_chat(user, "<span class='warning'>You feel the magic of the dice reject you!</span>")
		return
	// If false; Add them to the user list and continue
	else
		LAZYADD(used_fingerprints, user)
	
	// Run the function normally
	..()
