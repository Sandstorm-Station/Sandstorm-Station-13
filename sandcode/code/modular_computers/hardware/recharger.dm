/// This recharger exists only in borg built-in tablets. I would have tied it to the borg's cell but
/// the program that displays laws should always be usable, and the exceptions were starting to pile.
/obj/item/computer_hardware/recharger/cyborg
	name = "modular interface power harness"
	desc = "A standard connection to power a small computer device from a cyborg's chassis."

/obj/item/computer_hardware/recharger/cyborg/use_power(amount, charging=0)
	return TRUE
