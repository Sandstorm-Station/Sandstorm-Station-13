/obj/item/implant/disrobe
	name = "rapid disrobe implant"
	icon = 'icons/obj/clothing/uniforms.dmi'
	icon_state = "grey"

	// Custom action for extra customization
	actions_types = list(/datum/action/item_action/disrobe)

// Implant flavor text
/obj/item/implant/disrobe_ultra/get_data()
	// Define text variable
	var/dat = {"
		<b>Implant Specifications:</b><BR>
		<b>Name:</b> Rapid Disrobe Implant<BR>
		<b>Important Notes:</b> Nanotransen requires employees to follow workplace safety standards, including protective clothing.<BR>
		<HR>
		<b>Implant Details:</b><BR>
		<b>Function:</b> Allows the user to launch covering clothing items from the body.<BR>
		<b>Special Features:</b> Allows the express removal of embarrassing maid outfits.<BR>
		<b>Integrity:</b> Implant will last so long as it is inside the host.
		"}

	// Return text
	return dat

// Only allow use on "human" targets
/obj/item/implant/disrobe/can_be_implanted_in(mob/living/target)
	if(!ishuman(target))
		return FALSE
	. = ..()

// Runs on toggling the implant
/obj/item/implant/disrobe/activate()
	. = ..()

	// Get worn items
	var/items = imp_in.get_contents()

	// Did the action succeed?
	var/user_disrobed = FALSE

	// Iterate over worn items
	for(var/obj/item/item_worn in items)
		// Ignore non-mob (storage)
		if(!ismob(item_worn.loc))
			continue

		// Ignore held items
		if(imp_in.is_holding(item_worn))
			continue

		// Check for anything covering CHEST or GROIN
		// These are the regions used by the nudist quirk
		if((item_worn.body_parts_covered & CHEST) || (item_worn.body_parts_covered & GROIN))
			// Drop the target item
			imp_in.dropItemToGround(item_worn, TRUE)

			// Throw item to a random spot
			item_worn.throw_at(pick(oview(7,get_turf(src))),10,1)

			// Play the poster rip sound
			playsound(imp_in.loc, 'sound/items/poster_ripped.ogg', 50, 1)

			// Set the activation variable
			user_disrobed = TRUE

	// Display a chat message on success
	if(user_disrobed)
		imp_in.visible_message(span_notice("[imp_in] bursts out of [imp_in.p_their()] clothes!</span>"), span_notice("You burst out of your clothes!</span>"))

	// Alert the user on failure
	else
		to_chat(imp_in, span_notice("You have nothing to disrobe!"))

/*
 * Action datums
*/

// Action for rapid wardrobe removal
/datum/action/item_action/disrobe
	name = "Rapid Disrobe"
	desc = "Eject all torso-covering clothing from your body."
	icon_icon = 'modular_splurt/icons/mob/actions/misc_actions.dmi'
	button_icon_state = "no_uniform"
	background_icon_state = "bg_tech"

/*
 * Implant items
*/

// Implanter item
/obj/item/implanter/disrobe
	name = "implanter (rapid disrobe)"
	imp_type = /obj/item/implant/disrobe

// Implant case item
/obj/item/implantcase/disrobe
	name = "implant case - 'rapid disrobe'"
	desc = "A glass case containing a rapid disrobe implant."
	imp_type = /obj/item/implant/disrobe
