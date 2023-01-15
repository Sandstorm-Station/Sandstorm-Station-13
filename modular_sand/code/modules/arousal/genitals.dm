/obj/item/organ/genital
	/// Controls whenever a genital is always accessible
	var/always_accessible = FALSE

/// Toggles whether such genital can always be accessed
/obj/item/organ/genital/proc/toggle_accessibility()
	always_accessible = !always_accessible
