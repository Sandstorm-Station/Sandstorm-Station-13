/datum/dna/update_body_size(old_size)
	. = ..()
	if(!holder || features["body_size"] == old_size)
		return

	holder.adjust_mobsize()
