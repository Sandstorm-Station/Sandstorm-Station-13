/datum/job/prisoner
	title = "Prisoner"
	flag = PRISONER
	department_head = list("The Security Team")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	supervisors = "the security team"
	custom_spawn_text = "<font color='red' size='4'><b>If you join the shift as a Prisoner, you MUST go directly to Security to be allowed into the Permabrig, and you may NOT attempt a break out without ahelping unless your life is in immediate danger.</b></font>"
	outfit = /datum/outfit/job/prisoner
	plasma_outfit = /datum/outfit/plasmaman/prisoner

	display_order = JOB_DISPLAY_ORDER_PRISONER

/datum/job/prisoner/after_spawn(mob/living/carbon/human/H, mob/M)
	var/list/policies = CONFIG_GET(keyed_list/policy)
	var/policy = policies[POLICYCONFIG_JOB_PRISONER]
	if(policy)
		var/mob/found = (M?.client && M) || (H?.client && H)
		to_chat(found, "<br><span class='userdanger'>!!READ THIS!!</span><br><span class='warning'>The following is server-specific policy configuration and overrides anything said above if conflicting.</span>")
		to_chat(found, "<br><br>")
		to_chat(found, "<span class='boldnotice'>[policy]</span>")

/datum/outfit/job/prisoner
	name = "Prisoner"
	jobtype = /datum/job/prisoner

	uniform = /obj/item/clothing/under/rank/prisoner
	shoes = /obj/item/clothing/shoes/sneakers/orange
	id = /obj/item/card/id/prisoner
	ears = /obj/item/radio/headset/headset_prisoner
	belt = null
