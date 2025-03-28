// Great, since upstream got titles, we gotta do this differently.
// If you downstream, got conflicts from this, good, it means
// you'll know that you need to make changes as well
// Although, why are you modifying it here, go be doing shit modularly

//Command
/datum/job/captain/New()
	alt_titles += list(
		"Colony Overseer",
		"Senator",
		"Consul",
		"Death Captain"
	)
	return ..()

/datum/job/chief_engineer/New()
	alt_titles += list(
		"Senior Engineer",
		"Super Engineer"
	)
	return ..()

/datum/job/hop/New()
	alt_titles += list(
		"Crew Resource Officer",
		"Executive Officer",
		"Democracy Officer"
	)
	return ..()

/datum/job/hos/New()
	alt_titles += list(
		"Truth Enforcer"
	)
	return ..()

/datum/job/qm/New()
	alt_titles += list(
		"Resource Manager",
		"Logistics Supervisor",
		"Requisitions Officer"
	)
	return ..()

/datum/job/rd/New()
	alt_titles += list(
		"Chief Science Officer",
		"Research Overseer"
	)
	return ..()

/datum/job/atmos/New()
	alt_titles += list(
		"Fire Safety Officer"
	)
	return ..()

/datum/job/engineer/New()
	alt_titles += list(
		"Super Engineer"
	)
	return ..()

/datum/job/assistant/New()
	alt_titles += list(
		"Intern",
		"Super Pedestrian",
	)
	return ..()

/datum/job/bartender/New()
	alt_titles += list(
		"Barista",
		"Super Bartender",
		"Super Barista",
	)
	return ..()

/datum/job/chaplain/New()
	alt_titles += list(
		"Cult Leader",
		"Pope",
		"Bishop",
		"Pontiff",
		"Jehovah Witness",
		"Super Chaplain"
	)
	return ..()

/datum/job/clown/New()
	alt_titles += list(
		"Entertainer",
		"Dissident"
	)
	return ..()

/datum/job/cook/New()
	alt_titles += list(
		"Chef",
		"Nutritionist",
		"Super Chef",
		"Super Cook"
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
*/

/datum/job/lawyer/New()
	alt_titles += list(
		"Super Attorney"
	)
	return ..()

/*
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

/datum/job/scientist/New()
	alt_titles += list(
		"Super Scientist"
	)
	return ..()

/*
/datum/job/chemist/New()
	alt_titles += list(
	)
	return ..()
*/

/datum/job/doctor/New()
	alt_titles += list(
		"Medical Secretary",
		"Emergency Physician",
		"Field Surgeon",
		"Super Doctor",
		"Super Surgeon"
	)
	return ..()

/datum/job/geneticist/New()
	alt_titles += list(
		"Bioengineer",
		"Super Geneticist"
	)
	return ..()

/datum/job/paramedic/New()
	alt_titles += list(
		"Emergency Medical Technician",
		"Advanced Emergency Medical Technician",
		"Super Paramedic"
	)
	return ..()

/*
/datum/job/virologist/New()
	alt_titles += list(
	)
	return ..()
*/

/datum/job/detective/New()
	alt_titles += list(
		"Super Sheriff"
	)
	return ..()

/datum/job/officer/New()
	alt_titles += list(
		"Peacekeeper",
		"Peace Officer"
	)
	return ..()

/datum/job/warden/New()
	alt_titles += list(
		"Brig Chief",
		"Super Executioner"
	)
	return ..()

/datum/job/cargo_tech/New()
	alt_titles += list(
		"Shipping Specialist",
		"Delivery Manager",
		"Super Technician"
	)
	return ..()


/datum/job/mining/New()
	alt_titles += list(
		"Helldiver"
	)
	return ..()

