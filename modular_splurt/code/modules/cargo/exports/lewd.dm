//Condom
/datum/export/gear/condom
	cost = 150
	unit_name = "filled condom"
	export_types = list(/obj/item/genital_equipment/condom)
	include_subtypes = TRUE

/datum/export/gear/condom/applies_to(obj/O)
	if(!..())
		return FALSE
	var/obj/item/genital_equipment/condom/T = O
	return T.reagents.total_volume > 0
