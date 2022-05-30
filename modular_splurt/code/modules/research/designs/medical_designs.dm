/datum/design/implant_slave
	name = "Slave Implant Case"
	desc = "A glass case containing an implant."
	id = "implant_slave"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	build_path = /obj/item/implantcase/slave
	category = list("Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_MEDICAL

/datum/design/implant_gfluid
	name = "Genital Fluid Implant Case"
	desc = "A glass case containing an implant"
	id = "implant_gfluid"
	build_type = PROTOLATHE
	materials = list(/datum/material/glass = 500)
	build_path = /obj/item/implantcase/genital_fluid
	category = list("Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_MEDICAL

/datum/design/board/implantradio
	name = "Radio Implants"
	desc = "Allows for the construction of Radio implants"
	id = "impant_radio"
	build_path = /obj/item/implant/radio
	category = list("Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SECURITY
