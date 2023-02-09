/obj/machinery/rnd/production/ui_interact(mob/user)
	// Define machine user
	var/mob/living/carbon/human/machine_user = user

	// Check if user exists
	if(!istype(machine_user))
		return ..()

	// Define name on ID card
	var/user_public_name = machine_user.get_visible_name()

	// Check if ID name was found
	if(user_public_name == "Unknown")
		// Warn in local chat, then return
		say("User cannot be identified. Access denied.")
		return

	// Define potential job record
	var/datum/data/record/user_job_record

	// Get user assignment from ID
	user_job_record = find_record("name", user_public_name, GLOB.data_core.general)

	// Define potential job name
	var/user_job_name

	// Check if a job was found
	if(user_job_record && (user_job_record != "Unknown"))
		// Define potential rank
		var/user_job_rank = user_job_record.fields["rank"]

		// Check if rank field exists
		if(user_job_rank)
			// Define user job name as rank
			user_job_name = GetJobName(user_job_rank)

	// No job was found
	else
		// Warn in local chat, then return
		say("Unable to verify user rank. Access denied.")
		return

	// Check for Captain
	if(user_job_name == "Captain")
		// Allow usage
		return ..()

	// Check job based on protolathe type
	// Then check if user has that job
	// If so, return normally
	switch(department_tag)
		if("Engineering")
			if(user_job_name in GLOB.engineering_positions)
				return ..()

		if("Service")
			if(user_job_name in GLOB.civilian_positions)
				return ..()

		if("Medical")
			if(user_job_name in GLOB.medical_positions)
				return ..()

		if("Cargo")
			if(user_job_name in GLOB.supply_positions)
				return ..()

		if("Science")
			if(user_job_name in GLOB.science_positions)
				return ..()

		if("Security")
			if(user_job_name in GLOB.security_positions)
				return ..()

		// Non-department lathe
		else
			return ..()

	// User is not a valid job
	// Warn in local chat, then return
	say("No valid departmental credentials detected. Access denied.")
	return
