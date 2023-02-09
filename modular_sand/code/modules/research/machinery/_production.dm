/obj/machinery/rnd/production/ui_interact(mob/user)
	// Define machine user
	var/mob/living/carbon/human/machine_user = user

	// Check if user exists
	if(!istype(machine_user))
		return ..()

	// Get user job from mind
	var/user_job_mind = machine_user.mind?.assigned_role || null

	// Check if mind job exists
	if(!user_job_mind)
		// Warn in local chat, then return
		say("Invalid user detected. Access denied.")
		return

	// Check job based on protolathe type
	// Then check if user has that job
	// If so, return normally
	switch(department_tag)
		if("Engineering")
			if(user_job_mind in GLOB.engineering_positions)
				return ..()

		if("Service")
			if(user_job_mind in GLOB.civilian_positions)
				return ..()

		if("Medical")
			if(user_job_mind in GLOB.medical_positions)
				return ..()

		if("Cargo")
			if(user_job_mind in GLOB.supply_positions)
				return ..()

		if("Science")
			if(user_job_mind in GLOB.science_positions)
				return ..()

		if("Security")
			if(user_job_mind in GLOB.security_positions)
				return ..()

		// Non-department lathe
		else
			return ..()

	// User is not a valid job
	// Warn in local chat, then return
	say("Invalid user detected. Access denied.")
	return
