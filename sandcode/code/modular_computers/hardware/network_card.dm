/obj/item/computer_hardware/network_card/integrated //Borg tablet version, only works while the borg has power and is not locked
	name = "cyborg data link"

/obj/item/computer_hardware/network_card/integrated/get_signal(specific_action = 0)
	var/obj/item/modular_computer/tablet/integrated/modularInterface = holder

	if(!modularInterface || !istype(modularInterface))
		return FALSE //wrong type of tablet

	if(!modularInterface.borgo)
		return FALSE //No borg found

	if(modularInterface.borgo.locked_down)
		return FALSE //lockdown restricts borg networking

	if(!modularInterface.borgo.cell || modularInterface.borgo.cell.charge == 0)
		return FALSE //borg cell dying restricts borg networking

	return ..()
