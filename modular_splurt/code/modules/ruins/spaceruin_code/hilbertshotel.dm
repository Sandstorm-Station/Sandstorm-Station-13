/obj/item/hilbertshotel
	w_class = WEIGHT_CLASS_GIGANTIC
	var/list/list/mob_dorms = list()

/obj/item/hilbertshotel/sendToNewRoom(roomNumber, mob/user)
	. = ..()
	if(!mob_dorms[user]?.Find(roomNumber))
		LAZYADD(mob_dorms[user], roomNumber)

// Better SPLURT version of hilbert's
/datum/map_template/hilbertshotel
	mappath = '_maps/splurt_maps/templates/hilbertshotel.dmm'

// Empty room - different due to the dimensions of the updated map
/datum/map_template/hilbertshotel/empty
	mappath = '_maps/splurt_maps/templates/hilbertshotelempty.dmm'
