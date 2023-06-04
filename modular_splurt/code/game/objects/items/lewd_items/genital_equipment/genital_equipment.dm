/obj/item/genital_equipment
	var/genital_slot
	var/datum/component/genital_equipment/equipment

/obj/item/genital_equipment/ComponentInitialize()
	. = ..()
	var/list/procs_list = list(
		CALLBACK(src, .proc/item_inserting),
		CALLBACK(src, .proc/item_removing)
	)
	AddComponent(/datum/component/genital_equipment, genital_slot, procs_list)
	equipment = GetComponent(/datum/component/genital_equipment)
	RegisterSignal(src, COMSIG_MOB_GENITAL_INSERTED, .proc/item_inserted)
	RegisterSignal(src, COMSIG_MOB_GENITAL_REMOVED, .proc/item_removed)

/obj/item/genital_equipment/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_MOB_GENITAL_INSERTED, COMSIG_MOB_GENITAL_REMOVED)

/obj/item/genital_equipment/proc/item_inserting(datum/source, obj/item/organ/genital/G, mob/user)
	SIGNAL_HANDLER_DOES_SLEEP
	return TRUE

/obj/item/genital_equipment/proc/item_inserted(datum/source, obj/item/organ/genital/G, mob/user)
	SIGNAL_HANDLER_DOES_SLEEP
	return TRUE

/obj/item/genital_equipment/proc/item_removing(datum/source, obj/item/organ/genital/G, mob/user)
	SIGNAL_HANDLER_DOES_SLEEP
	return TRUE

/obj/item/genital_equipment/proc/item_removed(datum/source, obj/item/organ/genital/G, mob/user)
	SIGNAL_HANDLER_DOES_SLEEP
	return TRUE
