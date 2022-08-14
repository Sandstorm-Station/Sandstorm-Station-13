GLOBAL_LIST_EMPTY(roundstart_prisoners)

/datum/job/prisoner
	custom_spawn_text = "<font color='red' size='4'><b>If you join the shift as a Prisoner, you MUST go directly to Security to be allowed into the Permabrig, and you may NOT attempt a break out without ahelping unless your life is in immediate danger.</b></font>"

/datum/job/prisoner/after_spawn(mob/living/carbon/human/H, mob/M, latejoin)
	. = ..()
	if(!latejoin)
		GLOB.roundstart_prisoners += H
