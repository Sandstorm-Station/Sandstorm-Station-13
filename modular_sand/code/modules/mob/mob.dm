///Adjust the thirst of a mob
/mob/proc/adjust_thirst(change, max = INFINITY)
	thirst = clamp(thirst + change, 0, max)

/mob/proc/set_thirst(change)
	thirst = max(0, change)
