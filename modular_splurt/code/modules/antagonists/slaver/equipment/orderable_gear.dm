GLOBAL_LIST_INIT(slaver_gear, subtypesof(/datum/slaver_gear))

/datum/slaver_gear
	/// Name of the gear
	var/name = "Generic slaver Gear"
	/// Description of the gear
	var/description = "Generic description."
	/// Unique ID of the gear
	var/id = "slaver_generic"
	/// Credit cost of the gear
	var/cost = 1
	/// Build path of the gear itself
	var/build_path = null
	/// Category of the gear
	var/category = "Basic Gear"

/datum/slaver_gear/slave_collars
	name = "Slave Collars"
	description = "Slave collar x 3."
	id = "slave_collar"
	build_path = /obj/item/storage/box/slave_collars
	category = "Slaving"
	cost = 500

/datum/slaver_gear/jammers
	name = "Radio Jammers"
	description = "Radio jammer x 3."
	id = "jammers"
	build_path = /obj/item/storage/box/jammers
	category = "Slaving"
	cost = 1000

/datum/slaver_gear/gloves
	name = "Combat Krav Maga Gloves"
	description = "Shock and fire-resistant gloves that also teach krav maga x 3."
	id = "gloves"
	build_path = /obj/item/storage/box/krav_gloves
	category = "Slaving"
	cost = 1750

/datum/slaver_gear/pens
	name = "Sleepy Pens"
	description = "Pen that injects sleep-inducing chemicals x 7."
	id = "pens"
	build_path = /obj/item/storage/box/pens
	category = "Slaving"
	cost = 1500

/datum/slaver_gear/codespeak
	name = "Codespeak Manual"
	description = "A handy book that teaches the user how to speak in code. Useful to stop eavesdropping! This one has unlimited uses."
	id = "codespeak"
	build_path = /obj/item/codespeak_manual/unlimited
	category = "Slaving"
	cost = 1250

/datum/slaver_gear/chameleon
	name = "Chameleon Kit"
	description = "A set of items that contain chameleon technology allowing you to disguise as pretty much anything on the station, and more! \
			Due to budget cuts, the shoes don't provide protection against slipping."
	id = "chameleon"
	build_path = /obj/item/storage/box/syndie_kit/chameleon
	category = "Slaving"
	cost = 1000

/datum/slaver_gear/policing
	name = "Policing Kit"
	description = "Strobe shield x 1. Strobe replacement bulbs x 2. Stunbaton x 1. Box of handcuffs x 1. Electrostaff x 1."
	id = "policing"
	build_path = /obj/structure/closet/crate/policing_shipment
	category = "Slaving"
	cost = 2000

/datum/slaver_gear/slaver_gear
	name = "Slaver Gear"
	description = "A set of standard-issue slave trader items. The same you would find in your personal locker."
	id = "slaver_gear"
	build_path = /obj/structure/closet/crate/slaver_loadout
	category = "Slaving"
	cost = 750

/datum/slaver_gear/x4
	name = "X4 charges"
	description = "X4 plastic explosive charge x 3."
	id = "x4"
	build_path = /obj/item/storage/box/syndie_kit/x4
	category = "Advanced"
	cost = 1250

/datum/slaver_gear/emag
	name = "Cryptographic Sequencer"
	description = "A card capable of instantly hacking open most doors."
	id = "emag"
	build_path = /obj/item/card/emag
	category = "Advanced"
	cost = 3000

/datum/slaver_gear/implant_teleport
	name = "Emergency Teleport Implants"
	description = "Emergency teleport implant x 2."
	id = "implant_teleport"
	build_path = /obj/item/storage/box/slaver_teleport
	category = "Advanced"
	cost = 7000

/datum/slaver_gear/hardsuits
	name = "Combat Hardsuits"
	description = "Military suit supplied by our Syndicate sponsors x 2."
	id = "hardsuits"
	build_path = /obj/structure/closet/crate/slaver_hardsuits
	category = "Advanced"
	cost = 4500

/datum/slaver_gear/riot
	name = "Riot Kit"
	description = "Toy L6 SAW with riot darts."
	id = "riot"
	build_path = /obj/structure/closet/crate/l6saw_shipment
	category = "Advanced"
	cost = 2000

/datum/slaver_gear/medic
	name = "Medic Kit"
	description = "Advanced medical supplies for field medics."
	id = "implant_teleport"
	build_path = /obj/item/storage/firstaid/tactical/slaver
	category = "Advanced"
	cost = 2500

/datum/slaver_gear/chems
	name = "Bio Kit"
	description = "Chemical warfare? Warcrimes? Better not tell your mom! A set of items that drug your victim in case asking them nicely didn't work. \
			Contains a chem sprayer that confuses, knocks down and eventually knocks out the victim. A dart pistol. A mix of knockout and mute chems. And some teargas grenades just in case. \
			Disclaimer: Does not work on synthetic targets."
	id = "chems"
	build_path = /obj/item/storage/backpack/duffelbag/syndie/med/sleeperbundle
	category = "Advanced"
	cost = 2500

/datum/slaver_gear/marksman
	name = "Marksman Kit"
	description = ".50 cal sniper rifle with sleep-inducing rounds."
	id = "marksman"
	build_path = /obj/structure/closet/crate/slaver_marksman
	category = "Advanced"
	cost = 10000

/datum/slaver_gear/mech
	name = "Gygax 'Riot-Control' Exosuit"
	description = "A lightweight, agile mecha. This one comes with a taser cannon, clusterbang launcher and breaching missiles. Must be self-assembled."
	id = "mech"
	build_path = /obj/structure/closet/crate/slaver_mech
	category = "Mech"
	cost = 40000

/datum/slaver_gear/mech_ammo
	name = "Gygax Exosuit Ammo"
	description = "A shipment of ammo for the Gygax 'Riot-Control' Exosuit. Clusterbang x 3, breaching missile x 6."
	id = "mech_ammo"
	build_path = /obj/structure/closet/crate/slaver_mech_ammo
	category = "Mech"
	cost = 10000
