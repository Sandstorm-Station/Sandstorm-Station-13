// Special file for adding more job access
// Please try to keep this alphabetized

// add_access - Used for low population
// add_minimal_access - Used for high population

// Atmospheric Technician
/datum/job/atmos/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_ENGINEERING
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_ENGINEERING
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Bartender
/datum/job/bartender/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_SERVICE
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_SERVICE
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Botanist
/datum/job/hydro/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_SERVICE
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_SERVICE
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Captain
/datum/job/captain/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_CAPTAIN
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_CAPTAIN
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Cargo Technician
/datum/job/cargo_tech/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_CARGO
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_CARGO
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Chemist
/datum/job/chemist/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_MEDICAL
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_MEDICAL
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Chief Engineer
/datum/job/chief_engineer/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_MEDICAL
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_MEDICAL
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Chief Medical Officer
/datum/job/cmo/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_MEDICAL
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_MEDICAL
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Cook
/datum/job/cook/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_SERVICE
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_SERVICE
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Detective
/datum/job/detective/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_SECURITY
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_SECURITY
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Geneticist
/datum/job/geneticist/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_MEDICAL
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_MEDICAL
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Head of Security
/datum/job/hos/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_SECURITY
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_SECURITY
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Janitor
/datum/job/janitor/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_SERVICE
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_SERVICE
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Medical Doctor
/datum/job/doctor/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_MEDICAL
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_MEDICAL
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Paramedic
/datum/job/paramedic/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_MEDICAL
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_MEDICAL
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Quartermaster
/datum/job/qm/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_CARGO
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_CARGO
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Research Director
/datum/job/rd/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_SCIENCE
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_SCIENCE
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Roboticist
/datum/job/roboticist/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_SCIENCE
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_SCIENCE
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Scientist
/datum/job/scientist/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_SCIENCE
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_SCIENCE
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Security Officer
/datum/job/officer/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_SECURITY
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_SECURITY
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Shaft Miner
/datum/job/mining/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_CARGO
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_CARGO
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Station Engineer
/datum/job/engineer/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_ENGINEERING
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_ENGINEERING
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Virologist
/datum/job/virologist/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_MEDICAL
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_MEDICAL
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()

// Warden
/datum/job/warden/New()
	var/list/add_access = list(
		ACCESS_PRODUCTION_SECURITY
	)
	var/list/add_minimal_access = list(
		ACCESS_PRODUCTION_SECURITY
	)

	LAZYADD(access, add_access)
	LAZYADD(minimal_access, add_minimal_access)

	. = ..()
