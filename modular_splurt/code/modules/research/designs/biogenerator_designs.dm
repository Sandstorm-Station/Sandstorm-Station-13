//Idk who jessie is
/datum/design/bbqsauce
	name = "5u Barbecue sauce"
	id = "bbq_sauce"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	make_reagents = list(/datum/reagent/consumable/bbqsauce = 5)
	category = list("initial","Food")

/datum/design/flour_sack
	name = "Flour Sack"
	id = "flour_sack"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/reagent_containers/food/condiment/flour
	category = list("initial","Food")

/datum/design/egg_synth
	name = "Synthesized Egg"
	id = "egg_snack"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 90)
	build_path = /obj/item/reagent_containers/food/snacks/egg
	category = list("initial","Food")

/datum/design/sfish
	name = "Biomass Fish Slab"
	id = "sfish"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 350)
	build_path = /obj/item/reagent_containers/food/snacks/carpmeat/imitation
	category = list("initial", "Food")

/datum/design/seaweedz
	name = "Biomass Sea Weed"
	id = "sea_weed"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 350)
	build_path = /obj/item/reagent_containers/food/snacks/sea_weed
	category = list("initial", "Food")

/datum/design/ricebag
	name = "Biomass Rice Box"
	id = "Ricebox"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 350)
	build_path = /obj/item/reagent_containers/food/condiment/rice
	category = list("initial", "Food")

/datum/design/fishketchup
	name = "5u Soy Sauce"
	id = "soy_sauce"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	make_reagents = list(/datum/reagent/consumable/soysauce = 5)
	category = list("initial","Food")
