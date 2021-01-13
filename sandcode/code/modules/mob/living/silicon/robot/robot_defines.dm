/mob/living/silicon/robot
	///If the lamp isn't broken.
	var/lamp_functional = TRUE
	///If the lamp is turned on
	var/lamp_enabled = FALSE
	///Set lamp color
	var/lamp_color = "#FFFFFF"
	///Lamp brightness. Starts at 3, but can be 1 - 5.
	var/lamp_intensity = 3
	///Lamp button reference
	var/obj/screen/robot/lamp/lampButton

	///The reference to the built-in tablet that borgs carry.
	var/obj/item/modular_computer/tablet/integrated/modularInterface
	var/obj/screen/robot/modPC/interfaceButton
