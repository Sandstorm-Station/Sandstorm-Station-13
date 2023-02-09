/obj/machinery/rnd/production/ui_interact(mob/user)
	// Define machine user
	var/mob/living/carbon/human/machine_user = user

	// Check if user exists
	if(!istype(machine_user))
		return ..()

	// Define user job assignment
	var/job_type = machine_user.get_assignment(if_no_id = null, if_no_job = null, hand_first = TRUE)

	// Check if assignment was found
	if(!job_type)
		// Warn in local chat, then return
		say("Unable to verify user credentials. Access denied.")
		return

	// Define job name
	var/user_job_name = GetJobName(job_type)

	// Check if job name exists
	if(!user_job_name)
		// Warn in local chat, then return
		say("Unable to verify user assignment. Access denied.")
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
