// Only Clients should have a panel for them, okay?
/mob/Login()
	. = ..()
	AddComponent(/datum/component/interaction)

/mob/Logout()
	qdel(GetComponent(/datum/component/interaction))
	. = ..()

///Adjust the thirst of a mob
/mob/proc/adjust_thirst(change, max = THIRST_LEVEL_THRESHOLD)
	thirst = clamp(thirst + change, 0, max)

/mob/proc/set_thirst(change)
	thirst = max(0, change)
