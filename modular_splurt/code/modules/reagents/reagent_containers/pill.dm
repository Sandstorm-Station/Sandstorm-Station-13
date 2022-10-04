//Main code edits
/obj/item/reagent_containers/pill/breast_enlargement
	icon = 'modular_splurt/icons/obj/chemical.dmi'
	icon_state = "pill_lewd"

/obj/item/reagent_containers/pill/butt_enlargement
	icon = 'modular_splurt/icons/obj/chemical.dmi'
	icon_state = "pill_lewd"

//Own stuff
/obj/item/reagent_containers/pill/lsdpsych
	name = "antipsychotic pill"
	desc = "Talk to your healthcare provider immediately if hallucinations worsen or new hallucinations emerge."
	icon_state = "pill14"
	list_reagents = list(/datum/reagent/toxin/mindbreaker = 5)

/obj/item/reagent_containers/pill/happinesspsych
	name = "mood stabilizer pill"
	desc = "Used to temporarily alleviate anxiety and depression, take only as prescribed."
	icon_state = "pill_happy"
	list_reagents = list(/datum/reagent/drug/happiness = 5)

/obj/item/reagent_containers/pill/paxpsych
	name = "pacification pill"
	desc = "Used to temporarily suppress violent, homicidal, or suicidal behavior in patients."
	list_reagents = list(/datum/reagent/pax = 5)
	icon_state = "pill12"
