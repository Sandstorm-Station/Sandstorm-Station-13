modular_eros/obj/item/smithing/stundild
	name = "dildo frame"
	finishingitem = /obj/item/melee/baton/cattleprod
	finalitem = modular_eros/obj/item/melee/baton/stunsword/smithed
	icon = 'modular_eros/icons/obj/smith.dmi'
	icon_state = "stund"

modular_eros/obj/item/smithing/stundild/startfinish()
	var/modular_eros/obj/item/melee/baton/stunsword/smithed/finalforreal = new modular_eros/obj/item/melee/baton/stunsword/smithed(src)
	finalforreal.stamina_loss_amount += quality
	finalitem = finalforreal
	..()
