/mob/living/carbon/human/species/Initialize(mapload)
	. = ..()
	randomize_human(src)

/mob/living/carbon/human/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/mob_holder/micro, "micro")
	AddElement(/datum/element/skirt_peeking)
