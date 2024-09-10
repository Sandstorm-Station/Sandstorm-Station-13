/mob/living/silicon/ai
	vore_flags = NO_VORE

/mob/living/silicon/ai/Initialize(mapload, datum/ai_laws/L, mob/target_ai)
	. = ..()
	if (!mapload)
		return

	// Creating a AI shell for the AI.
	var/turf/open/T = locate() in RANGE_TURFS(1, src)
	if (T)
		new /mob/living/silicon/robot/shell(T)
		return

	// Why the fuck is the station AI completely blocked
	new /mob/living/silicon/robot/shell(get_turf(src))
