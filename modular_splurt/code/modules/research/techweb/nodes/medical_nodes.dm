/datum/techweb_node/subdermal_implants/New()
	var/list/extra_designs = list(
		"implant_gfluid",
		"implant_slave"
	)
	LAZYADD(design_ids, extra_designs)
	. = ..()
