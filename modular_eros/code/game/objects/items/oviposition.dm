/obj/item/reagent_containers/food/snacks/egg/oviposition
	var/baby_type = /mob/living/carbon/human

	var/datum/dna/father_dna
	var/datum/dna/mother_dna

	var/stage = -1
	var/max_stage = 2
	COOLDOWN_DECLARE(stage_time)

/obj/item/reagent_containers/food/snacks/egg/oviposition/Initialize(datum/component/pregnancy/comp)
	. = ..()
	if(comp)
		inherit_pregnancy(comp)
		START_PROCESSING(SSobj, src)

/obj/item/reagent_containers/food/snacks/egg/oviposition/process()
	if(stage >= max_stage && prob(30))
		src.visible_message(span_warning("The egg starts hatching!"))
		hatch()

	if(COOLDOWN_FINISHED(src, stage_time))
		COOLDOWN_START(src, stage_time, PREGNANCY_STAGE_DURATION)
		stage += 1
		stage = min(stage, max_stage)


/obj/item/reagent_containers/food/snacks/egg/oviposition/proc/inherit_pregnancy(datum/component/pregnancy/comp)
	if(comp.father_dna)
		comp.father_dna.copy_dna(father_dna)

	if(iscarbon(comp.parent))
		var/mob/living/carbon/momma = comp.parent
		momma.dna.copy_dna(mother_dna)

	baby_type = comp.baby_type

/obj/item/reagent_containers/food/snacks/egg/oviposition/proc/hatch()
	var/mob/living/babby = new baby_type(src)
	if(ishuman(babby))
		determine_baby_dna(babby)
	sleep(10)
	babby.forceMove(get_turf(src))
	qdel(src)

/obj/item/reagent_containers/food/snacks/egg/oviposition/proc/determine_baby_dna(mob/living/carbon/human/babby)
	if(mother_dna && father_dna)
		if(prob(50))
			mother_dna.transfer_identity(babby)
		else
			father_dna.transfer_identity(babby)
	else if(mother_dna && !father_dna)
		mother_dna.transfer_identity(babby)
	else if(!mother_dna && father_dna)
		father_dna.transfer_identity(babby)
	else
		var/datum/dna/rando = new
		rando.initialize_dna(random_blood_type())
		rando.transfer_identity(babby)
