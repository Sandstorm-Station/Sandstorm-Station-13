/mob/living/silicon/robot/modules/syndicate/slaver
	faction = list(ROLE_SLAVER)
	req_access = list(ACCESS_SLAVER)

/mob/living/silicon/robot/modules/syndicate/slaver/Initialize()
	. = ..()

	laws = new /datum/ai_laws/slaver_override
	laws.associate(src)

/mob/living/silicon/robot/modules/slaver
	faction = list(ROLE_SLAVER)
	req_access = list(ACCESS_SLAVER)
	emagged = TRUE
	lawupdate = FALSE

/mob/living/silicon/robot/modules/slaver/Initialize()
	. = ..()

	SetEmagged(1)
	lawupdate = FALSE
	set_connected_ai(null)
	laws = new /datum/ai_laws/slaver_override
	laws.associate(src)
	update_icons()

/mob/living/silicon/robot/modules/syndicate/slaver/medical
	icon_state = "synd_medical"
	playstyle_string = "<span class='big bold'>You are a Slaver medical cyborg!</span><br>\
						<b>You are armed with powerful medical tools to aid you in your mission: help the slavers kidnap crew. \
						Your hypospray will produce Restorative Nanites, a wonder-drug that will heal most types of bodily damages, including clone and brain damage. It also produces morphine for offense. \
						Your defibrillator paddles can revive slavers through their hardsuits, or can be used on harm intent to shock enemies! \
						Your energy saw functions as a circular saw, but can be activated to deal more damage.</b>"
	set_module = /obj/item/robot_module/syndicate_medical

/mob/living/silicon/robot/modules/syndicate/slaver/saboteur
	icon_state = "synd_engi"
	set_module = /obj/item/robot_module/saboteur
	playstyle_string = "<span class='big bold'>You are a Slaver saboteur cyborg!</span><br>\
						<b>You are armed with robust engineering tools to aid you in your mission: help the slavers kidnap crew. \
						Your destination tagger will allow you to stealthily traverse the disposal network across the station \
						Your welder will allow you to repair the slavers' exosuits, but also yourself and your fellow cyborgs \
						Your cyborg chameleon projector allows you to assume the appearance and registered name of a Nanotrasen engineering borg, and undertake covert actions on the station \
						Be aware that almost any physical contact or incidental damage will break your camouflage.</b>"
