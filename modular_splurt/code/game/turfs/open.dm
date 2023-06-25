/turf/open/floor/plating/asteroid/layeniasand
	gender = PLURAL
	name = "crimson sand"
	icon = 'modular_splurt/icons/turf/layeniasand.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/layeniaredder
	desc = "Looks cold."
	icon_state = "mapping"
	ore_type = /obj/item/stack/sheet/sandblock/twenty
	planetary_atmos = TRUE
	floor_tile = null
	initial_gas_mix = FROZEN_ATMOS
	slowdown = 0
	bullet_sizzle = TRUE
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/closed/mineral/ash_rock/layenia
	name = "crimson rock"
	icon = 'modular_splurt/icons/turf/layeniamining.dmi'
	smooth_icon = 'modular_splurt/icons/turf/layeniarocks.dmi'
	icon_state = "layenia"
	smooth = SMOOTH_MORE|SMOOTH_BORDER
	canSmoothWith = list (/turf/closed)
	baseturfs = /turf/open/floor/plating/asteroid/layenia
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	environment_type = "waste"
	turf_type = /turf/open/floor/plating/asteroid/layenia
	defer_change = TRUE

/turf/open/floor/plating/asteroid/layeniaredder
	name = "crimson rock"
	desc = "crimson rocks surrond you."
	icon = 'modular_splurt/icons/turf/layenia.dmi'
	icon_state = "layenia"
	turfverb = "dig up"
	slowdown = 0
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
