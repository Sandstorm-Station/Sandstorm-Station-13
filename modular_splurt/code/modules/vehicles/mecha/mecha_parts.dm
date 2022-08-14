
////////// Phazon

// Savannah-Ivanov

/obj/item/mecha_parts/chassis/savannah_ivanov
	icon = 'modular_splurt/icons/mecha/mech_construct.dmi'
	name = "\improper Savannah-Ivanov chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/savannah_ivanov

/obj/item/mecha_parts/part/savannah_ivanov_torso
	icon = 'modular_splurt/icons/mecha/mech_construct.dmi'
	name="\improper Savannah-Ivanov torso"
	desc="A Savannah-Ivanov torso part. It's missing a huge chunk of space..."
	icon_state = "savannah_ivanov_harness"

/obj/item/mecha_parts/part/savannah_ivanov_head
	icon = 'modular_splurt/icons/mecha/mech_construct.dmi'
	name="\improper Savannah-Ivanov head"
	desc="A Savannah-Ivanov head. It's sensors have been adjusted to support graceful landings."
	icon_state = "savannah_ivanov_head"

/obj/item/mecha_parts/part/savannah_ivanov_left_arm
	icon = 'modular_splurt/icons/mecha/mech_construct.dmi'
	name="\improper Savannah-Ivanov left arm"
	desc="A Savannah-Ivanov left arm. Hidden rocket fabrication included in the wrists."
	icon_state = "savannah_ivanov_l_arm"

/obj/item/mecha_parts/part/savannah_ivanov_right_arm
	icon = 'modular_splurt/icons/mecha/mech_construct.dmi'
	name="\improper Savannah-Ivanov right arm"
	desc="A Savannah-Ivanov left arm. Hidden rocket fabrication included in the wrists."
	icon_state = "savannah_ivanov_r_arm"

/obj/item/mecha_parts/part/savannah_ivanov_left_leg
	icon = 'modular_splurt/icons/mecha/mech_construct.dmi'
	name="\improper Savannah-Ivanov left leg"
	desc="A Savannah-Ivanov left leg. In production they were designed to carry more than two passengers, so the leaping functionality was added as to not waste potential."
	icon_state = "savannah_ivanov_l_leg"

/obj/item/mecha_parts/part/savannah_ivanov_right_leg
	icon = 'modular_splurt/icons/mecha/mech_construct.dmi'
	name="\improper Savannah-Ivanov right leg"
	desc="A Savannah-Ivanov left leg. In production they were designed to carry more than two passengers, so the leaping functionality was added as to not waste potential."
	icon_state = "savannah_ivanov_r_leg"

/obj/item/mecha_parts/part/savannah_ivanov_armor
	icon = 'modular_splurt/icons/mecha/mech_construct.dmi'
	name="Savannah-Ivanov armor"
	desc="Savannah-Ivanov armor plates. They are uniquely shaped and reinforced to deal with the stresses of two pilots, grandiose leaps, and missiles."
	icon_state = "savannah_ivanov_armor"

///////// Circuitboards

/obj/item/circuitboard/mecha/savannah_ivanov/peripherals
	name = "Savannah Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/savannah_ivanov/targeting
	name = "Ivanov Weapon Control and Targeting module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/savannah_ivanov/main
	name = "Savannah-Ivanov Combination Control Lock module (Exosuit Board)"
	icon_state = "mainboard"
