/mob/living/simple_animal/verb/toggle_gender()
	set name = "Set Gender"
	set desc = "Allows you to set your gender."
	set category = "IC"

	var/choice = tgui_alert(usr, "Select Gender.", "Gender", list("Both", "Male", "Female", "None"))
	switch(choice)
		if("Both")
			gender = PLURAL
			has_penis = TRUE
			has_balls = TRUE
			has_vagina = TRUE
		if("Male")
			gender = MALE
			has_penis = TRUE
			has_balls = TRUE
			has_vagina = FALSE
		if("Female")
			gender = FEMALE
			has_penis = FALSE
			has_balls = FALSE
			has_vagina = TRUE
		if("None")
			gender = NEUTER
			has_penis = FALSE
			has_balls = FALSE
			has_vagina = FALSE
