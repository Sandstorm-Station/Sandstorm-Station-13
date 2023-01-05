/obj/item/implant/hide_backpack
	name = "storage concealment implant"
	desc = "Prevents your backpack from being observable by the naked eye."
	icon = 'icons/obj/storage.dmi'
	icon_state = "backpack"

// Implanter item
/obj/item/implanter/hide_backpack
	name = "implanter (storage concealment)"
	imp_type = /obj/item/implant/hide_backpack

// Implant case item
/obj/item/implantcase/hide_backpack
	name = "implant case - 'Storage Concealment'"
	desc = "A glass case containing a Storage Concealment implant."
	imp_type = /obj/item/implant/hide_backpack

// Implant flavor text
/obj/item/implant/hide_backpack/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Chameleon Storage Concealment Implant<BR>
				<b>Important Notes:</b> Pending approval from some security teams.<BR>
				<HR>
				<b>Implant Details:</b><BR>
				<b>Function:</b> Subject emits a weak psychic signal that conceals the presence of back-equipped gear items.<BR>
				<b>Integrity:</b> Implant will last so long as the implant is inside the host."}
	return dat

// Only allow use on "human" targets
/obj/item/implant/hide_backpack/can_be_implanted_in(mob/living/target)
	if(!ishuman(target))
		return FALSE
	. = ..()

// Runs on implanting
/obj/item/implant/hide_backpack/implant(mob/living/target, mob/user, silent = FALSE)
	. = ..()
	
	// Update implant status for target
	set_status(TRUE, target)

// Runs on removal
/obj/item/implant/hide_backpack/removed(mob/target, silent = FALSE, special = 0)
	. = ..()
	
	// Update implant status for target
	set_status(FALSE, target)

// Runs when activating the implant
/obj/item/implant/hide_backpack/activate()
	. = ..()

	// Check if implant status
	var/implant_active = HAS_TRAIT(imp_in, TRAIT_HIDE_BACKPACK)
	
	// Set status to the opposite of active
	set_status(!implant_active, imp_in)

// Function to toggle the implant
/obj/item/implant/hide_backpack/proc/set_status(toggle_state, mob/target)
	// Check if implant status
	var/implant_active = HAS_TRAIT(target, TRAIT_HIDE_BACKPACK)
	
	// Ensure a change will occur
	if(toggle_state == implant_active)
		return
	
	// Set implant status
	if(toggle_state)
		ADD_TRAIT(target, TRAIT_HIDE_BACKPACK, "implant")
	else
		REMOVE_TRAIT(target, TRAIT_HIDE_BACKPACK, "implant")

	// Update sprites
	target.update_inv_back()

	// Display fake sparks to match flavor text
	do_fake_sparks(2,FALSE,target)

	// Set toggle text based on active state
	var/implant_toggle_text = (implant_active ? "discernible" : "imperceptible")
	var/implant_toggle_text_2 = (implant_active ? "dis" : "") // Engage or Disengage

	// Display a chat message
	target.visible_message("<span class='notice'>The equipment worn on [target]'s back-region flickers momentarily, before becoming [implant_toggle_text].</span>", "<span class='notice'>You [implant_toggle_text_2]engage the Storage Concealment Implant, causing your backpack to be [implant_toggle_text].</span>")

// Hidden features unlocked by emag
/*
 * Unused. What could this possibly do?
 *
/obj/item/implant/hide_backpack/emag_act()
	. = ..()
	
	// Do something fun here
	return
*/
