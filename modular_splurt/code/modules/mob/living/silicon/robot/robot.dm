//Main code edits

/mob/living/silicon/robot
	var/obj/item/pda/ai/aiPDA //TODO: Refractor the whole PDA system to be on /mob/living/silicon and add the pda functions of all the other silicons from /tg/

/// Allows "cyborg" players to change gender at will - Modularised here
/mob/living/silicon/robot/verb/toggle_gender()
	set name = "Set Gender"
	set desc = "Allows you to set your gender."
	set category = "Robot Commands"

	if(stat != CONSCIOUS)
		to_chat(usr, "<span class='warning'>You cannot toggle your gender while unconcious!</span>")
		return

	var/choice = tgui_alert(usr, "Select Gender.", "Gender", list("Both", "Male", "Female", "None"))
	switch(choice)
		if("Both")
			has_penis = TRUE
			has_balls = TRUE
			has_vagina = TRUE
		if("Male")
			has_penis = TRUE
			has_balls = TRUE
			has_vagina = FALSE
		if("Female")
			has_penis = FALSE
			has_balls = FALSE
			has_vagina = TRUE
		if("None")
			has_penis = FALSE
			has_balls = FALSE
			has_vagina = FALSE

/mob/living/silicon/robot/Initialize(mapload)
	. = ..()
	if(!shell)
		aiPDA = new/obj/item/pda/ai(src)
		aiPDA.owner = real_name
		aiPDA.ownjob = "Cyborg"
		aiPDA.name = real_name + " (" + aiPDA.ownjob + ")"

/mob/living/silicon/robot/replace_identification_name(oldname, newname)
	if(aiPDA && !shell)
		aiPDA.owner = newname
		aiPDA.name = newname + " (" + aiPDA.ownjob + ")"

// Slaver medical borg
/mob/living/silicon/robot/modules/syndicate/slaver/medical
	faction = list(ROLE_SLAVER)
	req_access = list(ACCESS_SLAVER)
	icon_state = "synd_medical"
	set_module = /obj/item/robot_module/syndicate_medical/slaver
	playstyle_string = "<span class='big bold'>You are a Slaver medical cyborg!</span><br>\
						<b>You are armed with powerful medical tools to aid you in your mission: help the slavers kidnap crew. \
						Your hypospray will produce Restorative Nanites, a wonder-drug that will heal most types of bodily damages, including clone and brain damage. It also produces morphine for offense. \
						Your defibrillator paddles can revive slavers through their hardsuits, or can be used on harm intent to shock enemies! \
						Your energy saw functions as a circular saw, but can be activated to deal more damage.</b>"

/mob/living/silicon/robot/modules/syndicate/slaver/medical/Initialize()
	. = ..()

	laws = new /datum/ai_laws/slaver_override
	laws.associate(src)

/mob/living/silicon/robot/modules/slaver
	faction = list(ROLE_SLAVER)
	req_access = list(ACCESS_SLAVER)
	emagged = TRUE
	lawupdate = FALSE

// Slaver generic borg
/mob/living/silicon/robot/modules/slaver/Initialize()
	. = ..()

	SetEmagged(1)
	lawupdate = FALSE
	set_connected_ai(null)
	laws = new /datum/ai_laws/slaver_override
	laws.associate(src)
	update_icons()
