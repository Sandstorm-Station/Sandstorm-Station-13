


/obj/item/organ/cyberimp/brain/condenser
	name = "condenser implant"
	desc = "This cybernetic brain implant will allow you to force your hand muscles to contract, preventing item dropping. Twitch ear to toggle."
	implant_color = "#DE7E00"
	slot = ORGAN_SLOT_BRAIN_ANTIDROP
	actions_types = list(/datum/action/item_action/organ_action/toggle)
	var/datum/condenser_implant/condenser/condenser
	var/on = 0
	var/wanted_size = 30

/obj/item/organ/cyberimp/brain/condenser/New()
	..()
	condenser = new(null, src)

/obj/item/organ/cyberimp/brain/condenser/ui_action_click()
	condenser.ui_interact(usr)

/datum/condenser_implant/condenser
	var/obj/item/organ/cyberimp/brain/condenser/FATHER = null

/datum/condenser_implant/condenser/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Condenser", "Condenser")
		ui.open()

/datum/condenser_implant/condenser/New(mob/viewer, obj/item/organ/cyberimp/brain/condenser/objectA)
	FATHER = objectA
	ui_interact(viewer)

/datum/condenser_implant/ui_state(mob/user)
	return GLOB.conscious_state

/datum/condenser_implant/condenser/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("condenser")
			FATHER.on = !FATHER.on
			. = TRUE
		if("size")
			var/sent_value = params["size"]
			FATHER.wanted_size = sent_value
			. = TRUE

/datum/condenser_implant/condenser/ui_data(mob/user)
	if(!ishuman(user))
		return
	var/list/data = list()
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/genital/penis/P = null
	var/obj/item/organ/genital/testicles/T = null
	var/obj/item/organ/genital/breasts/B = null

	for(var/obj/item/organ/genital/penis/PP in H.internal_organs)
		P = PP
	for(var/obj/item/organ/genital/testicles/TT in H.internal_organs)
		T = TT
	for(var/obj/item/organ/genital/breasts/BB in H.internal_organs)
		B = BB


	data["on"] = FATHER.on
	data["wanted_size"] = FATHER.wanted_size
	if(FATHER.on)
		if(P)
			P.length = max(FATHER.wanted_size, 1)
		if(T)
			T.size = clamp(FATHER.wanted_size, BALLS_SIZE_MIN, BALLS_SIZE_MAX)
		if(B)
			B.cached_size = max(FATHER.wanted_size, 1)
	else
		if(P)
			P.length = initial(P.prev_length)
		if(B)
			B.cached_size = max(FATHER.wanted_size, 1)

	if(P)
		if(P.length != P.prev_length)
			P.update()
			P.update_size()
			P.get_features(user)
		P.prev_length = P.length

	if(T)
		T.get_features(user)
		T.update_appearance()
		T.update_size()

	if(B)
		if(B.cached_size != B.prev_size)
			B.update()
			B.update_size()
			B.get_features(user)
		else
			B.prev_size = B.cached_size

	return data
