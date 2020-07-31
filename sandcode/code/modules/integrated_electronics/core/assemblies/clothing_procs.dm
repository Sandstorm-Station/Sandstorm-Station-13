/obj/item/electronic_assembly/on_loc_moved(oldloc)
	for(var/obj/O in contents)
		O.on_loc_moved(oldloc)

// Received from Moved(), useful for items that need to know that their loc just moved.
/obj/proc/on_loc_moved(atom/oldloc)
	return
