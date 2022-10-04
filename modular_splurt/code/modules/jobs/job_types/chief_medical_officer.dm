/datum/job/cmo
	custom_spawn_text = "<font color='red'>Keep the Fridge stocked with Medicine. Have SOME competency at performing surgeries. Ensure that if a Virus breaks out, that you or the Virologist handles creating a vaccine. You are Fourth in line to be Acting Captain.</font>"

/datum/job/cmo/New()
	. = ..()
	var/list/extra_access = list(ACCESS_PSYCH)
	var/list/extra_minimal_access = list(ACCESS_PSYCH)
	LAZYADD(access, extra_access)
	LAZYADD(minimal_access, extra_minimal_access)
