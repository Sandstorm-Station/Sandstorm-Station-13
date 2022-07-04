// - Crocin -
/obj/item/implant/aphrodisiac_pump
	name = "crocin pumping implant"
	desc = "A pump that injects an aphrodisiac drug into the bloodstream constantly."
	activated = FALSE
	var/reagent = /datum/reagent/drug/aphrodisiac
	var/base_amount = 5
	var/amount
	var/max_amount = 50
	var/timer

/obj/item/implant/aphrodisiac_pump/Initialize(mapload)
	. = ..()
	amount = base_amount

/obj/item/implant/aphrodisiac_pump/implant()
	. = ..()
	timer = addtimer(CALLBACK(src, .proc/pump), 30 SECONDS, TIMER_STOPPABLE)

/obj/item/implant/aphrodisiac_pump/removed(source)
	. = ..()
	deltimer(timer)
	timer = null

/obj/item/implant/aphrodisiac_pump/proc/pump()
	if(imp_in)
		imp_in.reagents.add_reagent(reagent, amount)


/obj/item/implanter/aphrodisiac_pump
	name = "implanter (crocin pump)"
	imp_type = /obj/item/implant/aphrodisiac_pump

/obj/item/implantcase/aphrodisiac_pump
	name = "implant case - 'Crocin pump'"
	desc = "A glass case containing a crocin pumping implant."
	imp_type = /obj/item/implant/aphrodisiac_pump

/obj/item/implantcase/aphrodisiac_pump/attack_self(mob/user)
	var/obj/item/implant/aphrodisiac_pump/pump = imp

	if(pump.amount >= pump.max_amount)
		pump.amount = pump.amount
	else
		pump.amount += 5
	balloon_alert(user, "Now synthetizing [pump.amount]u.")
//

// - Hexacrocin -
/obj/item/implant/aphrodisiac_pump/plus
	name = "hexacrocin pumping implant"
	desc = "A pump that injects a potent aphrodisiac drug into the bloodstream constantly."
	reagent = /datum/reagent/drug/aphrodisiacplus

/obj/item/implanter/aphrodisiac_pump/plus
	name = "implanter (hexacrocin pump)"
	imp_type = /obj/item/implant/aphrodisiac_pump/plus

/obj/item/implantcase/aphrodisiac_pump/plus
	name = "implant case - 'Hexacrocin pump'"
	desc = "A glass case containing a hexacrocin pumping implant."
	imp_type = /obj/item/implant/aphrodisiac_pump/plus
//

/obj/item/storage/box/aphrodisiac_pump
	name = "crocin pump box"
	desc = "Comes with an implanter and a implant case for quick application!"

/obj/item/storage/box/aphrodisiac_pump/ComponentInitialize()
	. = ..()
	var/datum/component/storage/str = GetComponent(/datum/component/storage)
	str.max_items = 2

/obj/item/storage/box/aphrodisiac_pump/PopulateContents()
	new /obj/item/implanter(src)
	new /obj/item/implantcase/aphrodisiac_pump(src)

/obj/item/storage/box/aphrodisiac_pump/plus
	name = "hexacrocin pump box"
	desc = "Comes with an implanter and a implant case for quick application!"

/obj/item/storage/box/aphrodisiac_pump/plus/PopulateContents()
	new /obj/item/implanter(src)
	new /obj/item/implantcase/aphrodisiac_pump/plus(src)