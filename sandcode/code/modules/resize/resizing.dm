//I am not a coder. Please fucking tear apart my code, and insult me for how awful I am at coding. Please and thank you. -Dahlular
//alright bet -BoxBoy
var/const/RESIZE_MACRO = 6
var/const/RESIZE_HUGE = 4
var/const/RESIZE_BIG = 2
var/const/RESIZE_NORMAL = 1
var/const/RESIZE_SMALL = 0.75
var/const/RESIZE_TINY = 0.50
var/const/RESIZE_MICRO = 0.25

//averages
var/const/RESIZE_A_MACROHUGE = (RESIZE_MACRO + RESIZE_HUGE) / 2
var/const/RESIZE_A_HUGEBIG = (RESIZE_HUGE + RESIZE_BIG) / 2
var/const/RESIZE_A_BIGNORMAL = (RESIZE_BIG + RESIZE_NORMAL) / 2
var/const/RESIZE_A_NORMALSMALL = (RESIZE_NORMAL + RESIZE_SMALL) / 2
var/const/RESIZE_A_SMALLTINY = (RESIZE_SMALL + RESIZE_TINY) / 2
var/const/RESIZE_A_TINYMICRO = (RESIZE_TINY + RESIZE_MICRO) / 2

//handle the big steppy, except nice
/mob/living/proc/handle_micro_bump_helping(var/mob/living/carbon/tmob)
	if(ishuman(src))
		var/mob/living/carbon/human/H = src

		if(tmob.pulledby == H)
			return 0

		//Micro is on a table.
		var/turf/steppyspot = tmob.loc
		for(var/thing in steppyspot.contents)
			if(istype(thing, /obj/structure/table))
				return 1

		//Both small.
		if(H.dna?.features["body_size"] <= RESIZE_A_TINYMICRO && tmob.dna.features["body_size"] <= RESIZE_A_TINYMICRO)
			now_pushing = 0
			H.forceMove(tmob.loc)
			return 1

		//Doing messages
		if(abs(H.dna?.features["body_size"]/tmob.dna.features["body_size"] >= 2)) //if the initiator is twice the size of the micro
			now_pushing = 0
			H.forceMove(tmob.loc)

			//Smaller person being stepped on
			if(H.dna?.features["body_size"] > tmob.dna.features["body_size"] && iscarbon(src))
				if(istype(H) && H.dna.features["taur"] == "Naga" || H.dna.features["taur"] == "Tentacle")
					tmob.visible_message("<span class='notice'>[src] carefully slithers around [tmob].</span>", "<span class='notice'>[src]'s huge tail slithers besides you.</span>")
				else
					tmob.visible_message("<span class='notice'>[src] carefully steps over [tmob].</span>", "<span class='notice'>[src] steps over you carefully.</span>")
				return 1

		//Smaller person stepping under a larger person
		if(abs(tmob.dna.features["body_size"]/H.dna?.features["body_size"]) >= 2)
			H.forceMove(tmob.loc)
			now_pushing = 0
			micro_step_under(tmob)
			return 1

//Stepping on disarm intent -- TO DO, OPTIMIZE ALL OF THIS SHIT
/mob/living/proc/handle_micro_bump_other(var/mob/living/carbon/tmob)
	ASSERT(isliving(tmob))
	if(ishuman(src))
		var/mob/living/carbon/human/H = src

		if(tmob.pulledby == H)
			return 0

	//If on a table, don't
		var/turf/steppyspot = tmob.loc
		for(var/thing in steppyspot.contents)
			if(istype(thing, /obj/structure/table))
				return 1

	//Both small
		if(H.dna?.features["body_size"] <= RESIZE_A_TINYMICRO && tmob.dna.features["body_size"] <= RESIZE_A_TINYMICRO)
			now_pushing = 0
			H.forceMove(tmob.loc)
			return 1

		if(abs(H.dna.features["body_size"]/tmob.dna.features["body_size"]) >= 2)
			if(H.a_intent == "disarm" && CHECK_MOBILITY(H, MOBILITY_MOVE) && !H.buckled)
				now_pushing = 0
				H.forceMove(tmob.loc)
				H.sizediffStamLoss(tmob)
				H.add_movespeed_modifier(/datum/movespeed_modifier/stomp) //Full stop
				addtimer(CALLBACK(H, /mob/.proc/remove_movespeed_modifier, MOVESPEED_ID_STOMP), 3) //0.3 seconds
				if(H.dna.features["body_size"] > tmob.dna.features["body_size"] && iscarbon(H))
					if(istype(H) && H.dna.features["taur"] == "Naga" || H.dna.features["taur"] == "Tentacle")
						tmob.visible_message("<span class='danger'>[src] carefully rolls their tail over [tmob]!</span>", "<span class='danger'>[src]'s huge tail rolls over you!</span>")
					else
						tmob.visible_message("<span class='danger'>[src] carefully steps on [tmob]!</span>", "<span class='danger'>[src] steps onto you with force!</span>")
					return 1

			if(H.a_intent == "harm" && CHECK_MOBILITY(H, MOBILITY_MOVE) && !H.buckled)
				now_pushing = 0
				H.forceMove(tmob.loc)
				H.sizediffStamLoss(tmob)
				H.sizediffBruteloss(tmob)
				playsound(loc, 'sound/misc/splort.ogg', 50, 1)
				H.add_movespeed_modifier(/datum/movespeed_modifier/stomp)
				addtimer(CALLBACK(H, /mob/.proc/remove_movespeed_modifier, MOVESPEED_ID_STOMP), 10) //1 second
				//H.Stun(20)
				if(H.dna.features["body_size"] > tmob.dna.features["body_size"] && iscarbon(H))
					if(istype(H) && H.dna.features["taur"] == "Naga" || H.dna.features["taur"] == "Tentacle")
						tmob.visible_message("<span class='danger'>[src] mows down [tmob] under their tail!</span>", "<span class='userdanger'>[src] plows their tail over you mercilessly!</span>")
					else
						tmob.visible_message("<span class='danger'>[src] slams their foot down on [tmob], crushing them!</span>", "<span class='userdanger'>[src] crushes you under their foot!</span>")
					return 1

			if(H.a_intent == "grab" && CHECK_MOBILITY(H, MOBILITY_MOVE) && !H.buckled)
				now_pushing = 0
				H.forceMove(tmob.loc)
				H.sizediffStamLoss(tmob)
				H.sizediffStun(tmob)
				H.add_movespeed_modifier(/datum/movespeed_modifier/stomp)
				addtimer(CALLBACK(H, /mob/.proc/remove_movespeed_modifier, MOVESPEED_ID_STOMP), 7)//About 3/4th a second
				if(H.dna.features["body_size"] > tmob.dna.features["body_size"] && iscarbon(H))
					var/feetCover = (H.wear_suit && (H.wear_suit.body_parts_covered & FEET)) || (H.w_uniform && (H.w_uniform.body_parts_covered & FEET) || (H.shoes && (H.shoes.body_parts_covered & FEET)))
					if(feetCover)
						if(istype(H) && H.dna.features["taur"] == "Naga" || H.dna.features["taur"] == "Tentacle")
							tmob.visible_message("<span class='danger'>[src] pins [tmob] under their tail!</span>", "<span class='danger'>[src] pins you beneath their tail!</span>")
						else
							tmob.visible_message("<span class='danger'>[src] pins [tmob] helplessly underfoot!</span>", "<span class='danger'>[src] pins you underfoot!</span>")
						return 1
					else
						if(istype(H) && H.dna.features["taur"] == "Naga" || H.dna.features["taur"] == "Tentacle")
							tmob.visible_message("<span class='danger'>[src] snatches up [tmob] underneath their tail!</span>", "<span class='userdanger'>[src]'s tail winds around you and snatches you in its coils!</span>")
							//tmob.mob_pickup_micro_feet(H)
							SEND_SIGNAL(tmob, COMSIG_MICRO_PICKUP_FEET, H)
						else
							tmob.visible_message("<span class='danger'>[src] stomps down on [tmob], curling their toes and picking them up!</span>", "<span class='userdanger'>[src]'s toes pin you down and curl around you, picking you up!</span>")
							//tmob.mob_pickup_micro_feet(H)
							SEND_SIGNAL(tmob, COMSIG_MICRO_PICKUP_FEET, H)
						return 1

		if(abs(tmob.dna.features["body_size"]/H.dna.features["body_size"]) >= 2)
			H.forceMove(tmob.loc)
			now_pushing = 0
			micro_step_under(tmob)
			return 1

//smaller person stepping under another person... TO DO, fix and allow special interactions with naga legs to be seen
/mob/living/proc/micro_step_under(var/mob/living/tmob)
	if(istype(tmob) && istype(tmob, /datum/sprite_accessory/taur/naga))
		src.visible_message("<span class='notice'>[src] bounds over [tmob]'s tail.</span>", "<span class='notice'>You jump over [tmob]'s thick tail.</span>")
	else
		src.visible_message("<span class='notice'>[src] runs between [tmob]'s legs.</span>", "<span class='notice'>You run between [tmob]'s legs.</span>")

//Proc for scaling stamina damage on size difference
/mob/living/carbon/proc/sizediffStamLoss(var/mob/living/carbon/tmob)
	var/S = (dna.features["body_size"]/tmob.dna.features["body_size"]*25) //macro divided by micro, times 25
	tmob.Knockdown(S) //final result in stamina knockdown

//Proc for scaling stuns on size difference (for grab intent)
/mob/living/carbon/proc/sizediffStun(var/mob/living/carbon/tmob)
	var/T = (dna.features["body_size"]/tmob.dna.features["body_size"]*2) //Macro divided by micro, times 2
	tmob.Stun(T)

//Proc for scaling brute damage on size difference
/mob/living/carbon/proc/sizediffBruteloss(var/mob/living/carbon/tmob)
	var/B = (dna.features["body_size"]/tmob.dna.features["body_size"]*3) //macro divided by micro, times 3
	tmob.adjustBruteLoss(B) //final result in brute loss

//Proc for instantly grabbing valid size difference. Code optimizations soon(TM)
/*
/mob/living/proc/sizeinteractioncheck(var/mob/living/tmob)
	if(abs(get_effective_size()/tmob.get_effective_size())>=2.0 && get_effective_size()>tmob.get_effective_size())
		return 0
	else
		return 1
*/
//Clothes coming off at different sizes, and health/speed/stam changes as well
