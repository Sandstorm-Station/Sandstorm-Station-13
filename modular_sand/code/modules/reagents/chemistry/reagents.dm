#define MAX_THIRST_CYCLE 25

/datum/reagent
	var/hydration = 0 //does this hydrate your thirst?

/datum/reagent/on_mob_life(mob/living/carbon/M)
	. = ..()
	M.adjust_thirst(hydration * current_cycle >= MAX_THIRST_CYCLE ? MAX_THIRST_CYCLE : current_cycle)
