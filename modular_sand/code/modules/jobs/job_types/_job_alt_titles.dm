// Great, since upstream got titles, we gotta do this differently.
// If you downstream, got conflicts from this, good, it means
// you'll know that you need to make changes as well
// Although, why are you modifying it here, go be doing shit modularly

//Command
/datum/job/captain/New()
	alt_titles += list(
		"Colony Overseer",
		"Senator",
		"Consul"
	)
	return ..()

/datum/job/chief_engineer/New()
	alt_titles += list(
		"Senior Engineer"
	)
	return ..()

/datum/job/hop/New()
	alt_titles += list(
		"Crew Resource Officer",
		"Executive Officer"
	)
	return ..()

/datum/job/hos/New()
	alt_titles += list(
		"Praetor",
		"Tarkhan"
	)
	return ..()

/datum/job/qm/New()
	alt_titles += list(
		"Resource Manager",
		"Logistics Supervisor"
	)
	return ..()

/datum/job/rd/New()
	alt_titles += list(
		"Chief Science Officer",
		"Research Overseer"
	)
	return ..()

// Re-enable once we have our unique again
/*
/datum/job/atmos/New()
	alt_titles += list(
	)
	return ..()

/datum/job/engineer/New()
	alt_titles += list(
	)
	return ..()
*/

/datum/job/assistant/New()
	alt_titles += list(
		"Intern",
	)
	return ..()

/datum/job/bartender/New()
	alt_titles += list(
		"Barista"
	)
	return ..()

/datum/job/chaplain/New()
	alt_titles += list(
		"Cult Leader",
		"Pope",
		"Bishop",
		"Pontiff"
	)
	return ..()

/datum/job/clown/New()
	alt_titles += list(
		"Entertainer"
	)
	return ..()

/datum/job/cook/New()
	alt_titles += list(
		"Chef",
		"Nutritionist"
	)
	return ..()

/*
/datum/job/curator/New()
	alt_titles += list(
	)
	return ..()
*/

/datum/job/hydro/New()
	alt_titles += list(
		"Florist"
	)
	return ..()

/*
/datum/job/janitor/New()
	alt_titles += list(
	)
	return ..()

/datum/job/lawyer/New()
	alt_titles += list(
	)
	return ..()

/datum/job/mime/New()
	alt_titles += list(
	)
	return ..()
*/

/datum/job/roboticist/New()
	alt_titles += list(
		"Robotics Operator",
		"MODsuit Engineer"
	)
	return ..()

/*
/datum/job/scientist/New()
	alt_titles += list(
	)
	return ..()

/datum/job/chemist/New()
	alt_titles += list(
	)
	return ..()
*/

/datum/job/doctor/New()
	alt_titles += list(
		"Medical Secretary",
		"Emergency Physician",
		"Field Surgeon"
	)
	return ..()

/datum/job/geneticist/New()
	alt_titles += list(
		"Bioengineer"
	)
	return ..()

/datum/job/paramedic/New()
	alt_titles += list(
		"Emergency Medical Technician",
		"Advanced Emergency Medical Technician"
	)
	return ..()

/*
/datum/job/virologist/New()
	alt_titles += list(
	)
	return ..()

/datum/job/detective/New()
	alt_titles += list(
	)
	return ..()
*/

/datum/job/officer/New()
	alt_titles += list(
		"Peacekeeper",
		"Enforcer"
	)
	return ..()

/datum/job/warden/New()
	alt_titles += list(
		"Brig Chief"
	)
	return ..()

/datum/job/cargo_tech/New()
	alt_titles += list(
		"Shipping Specialist",
		"Delivery Manager"
	)
	return ..()

/*
/datum/job/mining/New()
	alt_titles += list(
		"Explorer"
	)
	return ..()
*/
