/obj/machinery/porta_turret/slaver
	always_up = 1
	use_power = NO_POWER_USE
	has_cover = 0
	scan_range = 9
	req_access = list()
	icon_state = "standard_stun"
	faction = list(ROLE_SLAVER)

/obj/machinery/porta_turret/slaver/assess_perp(mob/living/carbon/human/perp)
	return 10 //Slaver turrets shoot everything not in their faction
