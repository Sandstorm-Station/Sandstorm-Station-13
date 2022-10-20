/datum/quirk/tough
	name = "Tough"
	desc = "Your body is abnormally enduring and can take 10% more damage."
	value = 4
	medical_record_text = "Patient has an abnormally high capacity for injury."
	gain_text = "<span class='notice'>You feel very sturdy.</span>"
	lose_text = "<span class='notice'>You feel less sturdy.</span>"

/datum/quirk/tough/add()
	quirk_holder.maxHealth *= 1.1

/datum/quirk/tough/remove()
	if(!quirk_holder)
		return
	quirk_holder.maxHealth *= 0.909 //close enough

/datum/quirk/ashresistance
	name = "Ashen Resistance"
	desc = "Your form is naturally adapted to the burning sheets of ash that coat volcanic worlds."
	value = 2 //Is not actually THAT good. Does not grant breathing and does stamina damage to the point you are unable to attack. Crippling on lavaland, but you'll survive. Is not a replacement for SEVA suits for this reason. Can be adjusted.
	mob_trait = TRAIT_ASHRESISTANCE
	medical_record_text = "Patient has an abnormally thick epidermis."
	gain_text = "<span class='notice'>You feel resistant to burning brimstone.</span>"
	lose_text = "<span class='notice'>You feel less as if your flesh is more flamamble.</span>"

/* --FALLBACK SYSTEM INCASE THE TRAIT FAILS TO WORK. Do NOT enable this without editing ash_storm.dm to deal stamina damage with ash immunity.
/datum/quirk/ashresistance/add()
	quirk_holder.weather_immunities |= "ash"

/datum/quirk/ashresistance/remove()
	if(!quirk_holder)
		return
	quirk_holder.weather_immunities -= "ash"
*/

/datum/quirk/dominant_aura
	name = "Dominant Aura"
	desc = "Your personality is assertive enough to appear as powerful to other people, so much in fact that the weaker kind can't help but throw themselves at your feet on command."
	value = 1
	gain_text = "<span class='notice'>You feel like making someone your pet</span>"
	lose_text = "<span class='notice'>You feel less assertive than befpre</span>"

/datum/quirk/dominant_aura/add()
	. = ..()
	RegisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE, .proc/on_examine_holder)
	RegisterSignal(quirk_holder, COMSIG_MOB_EMOTE, .proc/handle_snap)

/datum/quirk/dominant_aura/remove()
	. = ..()
	UnregisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE)
	UnregisterSignal(quirk_holder, COMSIG_MOB_EMOTE)

/datum/quirk/dominant_aura/proc/on_examine_holder(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(!ishuman(user))
		return
	var/mob/living/carbon/human/sub = user
	if(!sub.has_quirk(/datum/quirk/well_trained) || (sub == quirk_holder))
		return

	examine_list += span_lewd("\nYou can't look at [quirk_holder.p_them()] for more than three seconds before flustering away.")
	if(!TIMER_COOLDOWN_CHECK(user, COOLDOWN_DOMINANT_EXAMINE))
		to_chat(quirk_holder, span_notice("\The [user] tries to look at you but immediately looks away with a red face..."))
		TIMER_COOLDOWN_START(user, COOLDOWN_DOMINANT_EXAMINE, 5 SECONDS)
	sub.dir = turn(get_dir(sub, quirk_holder), pick(-90, 90))
	sub.emote("blush")

/datum/quirk/dominant_aura/proc/handle_snap(datum/source, list/emote_args)
	SIGNAL_HANDLER

	. = FALSE
	var/datum/emote/E
	E = E.emote_list[lowertext(emote_args[EMOTE_ACT])]
	if(TIMER_COOLDOWN_CHECK(quirk_holder, COOLDOWN_DOMINANT_SNAP) || !findtext(E?.key, "snap"))
		return
	for(var/mob/living/carbon/human/sub in hearers(DOMINANT_DETECT_RANGE, quirk_holder))
		if(!sub.has_quirk(/datum/quirk/well_trained) || (sub == quirk_holder))
			continue
		var/good_x = "pet"
		switch(sub.gender)
			if(MALE)
				good_x = "boy"
			if(FEMALE)
				good_x = "girl"
		switch(E?.key)
			if("snap")
				sub.dir = get_dir(sub, quirk_holder)
				sub.emote(pick("blush", "pant"))
				sub.visible_message(span_notice("\The <b>[sub]</b> turns shyly towards \the <b>[quirk_holder]</b>."),
									span_lewd("You stare into \the [quirk_holder] submissively."))
			if("snap2")
				sub.dir = get_dir(sub, quirk_holder)
				sub.KnockToFloor()
				sub.emote(pick("blush", "pant"))
				sub.visible_message(span_lewd("\The <b>[sub]</b> submissively throws [sub.p_them()]self on the floor."),
									span_lewd("You throw yourself on the floor like a dog on <b>[quirk_holder]</b>'s command."))
			if("snap3")
				sub.KnockToFloor()
				step(sub, get_dir(sub, quirk_holder))
				sub.emote(pick("blush", "pant"))
				sub.do_jitter_animation(30) //You're being moved anyways
				sub.visible_message(span_lewd("\The <b>[sub]</b> crawls closer to \the <b>[quirk_holder]</b> in all fours, following [quirk_holder.p_their()] command"),
									span_lewd("You get on your fours and crawl towards \the <b>[quirk_holder]</b> like a good, submissive [good_x]."))
		. = TRUE

	if(.)
		TIMER_COOLDOWN_START(quirk_holder, COOLDOWN_DOMINANT_SNAP, DOMINANT_SNAP_COOLDOWN)

/datum/quirk/arachnid
	name = "Arachnid"
	desc = "Your bodily anatomy allows you to spin webs and cocoons, even if you aren't an arachnid! (Note that this quirk does nothing for members of the arachnid species)"
	value = 1
	medical_record_text = "Patient has attempted to cover the room in webs, claiming to be \"making a nest\"."
	mob_trait = TRAIT_ARACHNID
	gain_text = "<span class='notice'>You feel a strange sensation near your anus...</span>"
	lose_text = "<span class='notice'>You feel like you can't spin webs anymore...</span>"
	processing_quirk = TRUE

/datum/quirk/arachnid/add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	if(is_species(H,/datum/species/arachnid))
		to_chat(H, "<span class='warning'>As an arachnid, this quirk does nothing for you, as these abilities are innate to your species.</span>")
		return
	var/datum/action/innate/spin_web_quirk/SW = new
	var/datum/action/innate/spin_cocoon_quirk/SC = new
	SC.Grant(H)
	SW.Grant(H)

/datum/quirk/arachnid/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	if(is_species(H,/datum/species/arachnid))
		return
	var/datum/action/innate/spin_web_quirk/SW = locate(/datum/action/innate/spin_web_quirk) in H.actions
	var/datum/action/innate/spin_cocoon_quirk/SC = locate(/datum/action/innate/spin_cocoon_quirk) in H.actions
	SC?.Remove(H)
	SW?.Remove(H)

// Unfortunately, some copy-paste work needed doing. Web spinning and cocoon spinning relied on variables innate to the arachnid species. Also unsure of how to make the cooldown work between both actions ¯\_(ツ)_/¯
/datum/action/innate/spin_web_quirk
	name = "Spin Web"
	check_flags = AB_CHECK_RESTRAINED|AB_CHECK_STUN|AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "lay_web"
	var/web_cooldown = 200
	var/web_ready = TRUE
	var/spinner_rate = 25

/datum/action/innate/spin_cocoon_quirk
	name = "Spin Cocoon"
	check_flags = AB_CHECK_RESTRAINED|AB_CHECK_STUN|AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "wrap_0"
	var/web_cooldown = 200
	var/web_ready = TRUE
	var/spinner_rate = 25

/datum/action/innate/spin_web_quirk/Activate()
	var/mob/living/carbon/human/H = owner
	if(H.stat == "DEAD")
		return
	if(web_ready == FALSE)
		to_chat(H, "<span class='warning'>You need to wait a while to regenerate web fluid.</span>")
		return
	var/turf/T = get_turf(H)
	if(!T)
		to_chat(H, "<span class='warning'>There's no room to spin your web here!</span>")
		return
	var/obj/structure/spider/stickyweb/W = locate() in T
	var/obj/structure/arachnid/W2 = locate() in T
	if(W || W2)
		to_chat(H, "<span class='warning'>There's already a web here!</span>")
		return
	 // Should have some minimum amount of food before trying to activate
	var/nutrition_threshold = NUTRITION_LEVEL_FED
	if (H.nutrition >= nutrition_threshold)
		to_chat(H, "<i>You begin spinning some web...</i>")
		if(!do_after(H, 10 SECONDS, 1, T))
			to_chat(H, "<span class='warning'>Your web spinning was interrupted!</span>")
			return
		H.adjust_nutrition(-spinner_rate)
		addtimer(VARSET_CALLBACK(src, web_ready, TRUE), web_cooldown)
		to_chat(H, "<i>You use up a fair amount of energy weaving a web on the ground with your spinneret!</i>")
		new /obj/structure/arachnid(T, owner)

	else
		to_chat(H, "<span class='warning'>You're too hungry to spin web right now, eat something first!</span>")
		return
/*
	This took me far too long to figure out so I'm gonna document it here.
	1) Create an innate action for the species
	2) Have that action trigger a RegisterSignal for mob clicking
	3) Trigger the cocoonAtom proc on that signal
	4) Validate the target then start spinning
	5) if you're not interrupted, force move the target to the cocoon created at their location.
*/
/datum/action/innate/spin_cocoon_quirk/Activate()
	var/mob/living/carbon/human/H = owner
	if(H.stat == "DEAD")
		return
	if(web_ready == FALSE)
		to_chat(H, "<span class='warning'>You need to wait awhile to regenerate web fluid.</span>")
		return
	var/nutrition_threshold = NUTRITION_LEVEL_FED
	if (H.nutrition >= nutrition_threshold)
		to_chat(H, "<span class='warning'>You pull out a strand from your spinneret, ready to wrap a target. <BR>\
		 (Press ALT+CLICK on the target to start wrapping.)</span>")
		H.adjust_nutrition(spinner_rate * -0.5)
		addtimer(VARSET_CALLBACK(src, web_ready, TRUE), web_cooldown)
		RegisterSignal(H, list(COMSIG_MOB_ALTCLICKON), .proc/cocoonAtom)
		return
	else
		to_chat(H, "<span class='warning'>You're too hungry to spin web right now, eat something first!</span>")
		return

/datum/action/innate/spin_cocoon_quirk/proc/cocoonAtom(mob/living/carbon/human/H, atom/movable/A)
	UnregisterSignal(H, list(COMSIG_MOB_ALTCLICKON))
	if (!H || !isarachnid(H))
		return COMSIG_MOB_CANCEL_CLICKON
	else
		if(web_ready == FALSE)
			to_chat(H, "<span class='warning'>You need to wait awhile to regenerate web fluid.</span>")
			return
		if(!H.Adjacent(A))	//No.
			return
		if(!isliving(A) && A.anchored)
			to_chat(H, "<span class='warning'>[A] is bolted to the floor!</span>")
			return
		if(istype(A, /obj/structure/arachnid))
			to_chat(H, "<span class='warning'>No double wrapping.</span>")
			return
		if(istype(A, /obj/effect))
			to_chat(H, "<span class='warning'>You cannot wrap this.</span>")
			return
		if(isliving(A))
			var/mob/living/L = A
			if(L.key)
				to_chat(H, "<span class='warning'>You prepare to wrap [L] in a cocoon...</span>")
				var/response = alert(L, "Do you wish to be wrapped in a cocoon?", "Cocooning", "No", "Yes")
				if(response == "No")
					to_chat(H, "<span class='warning'>[L] resists your attempts to wrap [L.p_them()]!</span>")
					return
		H.visible_message("<span class='danger'>[H] starts to wrap [A] into a cocoon!</span>","<span class='warning'>You start to wrap [A] into a cocoon.</span>")
		if(!do_after(H, 10 SECONDS, 1, A))
			to_chat(H, "<span class='warning'>Your web spinning was interrupted!</span>")
			return
		H.adjust_nutrition(spinner_rate * -3)
		var/obj/structure/arachnid/cocoon/C = new(A.loc)
		if(isliving(A))
			C.icon_state = pick("cocoon_large1","cocoon_large2","cocoon_large3")
			A.forceMove(C)
			H.visible_message("<span class='danger'>[H] wraps [A] into a large cocoon!</span>")
			return
		else
			A.forceMove(C)
			H.visible_message("<span class='danger'>[H] wraps [A] into a cocoon!</span>")
			return
