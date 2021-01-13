//Borg Built-in tablet
/obj/item/modular_computer/tablet/integrated/Initialize()
	. = ..()
	install_component(new /obj/item/computer_hardware/processor_unit/small)
	install_component(new /obj/item/computer_hardware/hard_drive/small/integrated)
	install_component(new /obj/item/computer_hardware/recharger/cyborg)
	install_component(new /obj/item/computer_hardware/network_card/integrated)
