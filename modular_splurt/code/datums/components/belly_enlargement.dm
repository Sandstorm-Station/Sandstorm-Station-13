/datum/component/belly_enlargement
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

	var/obj/item/organ/container
	var/belly_size

/datum/component/belly_enlargement/Initialize(added_size)
	if(added_size < 0)
		return COMPONENT_INCOMPATIBLE
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	belly_size = added_size

	var/obj/item/thing = parent

	if(istype(thing.loc, /obj/item/organ))
		container = thing.loc
		enlarge_belly()

/datum/component/belly_enlargement/InheritComponent(datum/component/C, i_am_original, _belly_size)
	if(!i_am_original)
		return
	var/old_size = belly_size
	if(C)
		var/datum/component/belly_enlargement/other = C
		belly_size = max(belly_size, other.belly_size)
	else
		belly_size = max(belly_size, _belly_size)

	if(abs(belly_size - old_size) > 0)
		add_belly(belly_size - old_size)

/datum/component/belly_enlargement/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_ENTERING, .proc/on_entering)
	if(container)
		register_container()

/datum/component/belly_enlargement/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ATOM_ENTERING)
	if(container)
		unregister_container()

/datum/component/belly_enlargement/proc/register_container()
	RegisterSignal(container, COMSIG_ORGAN_INSERTED, .proc/enlarge_belly)
	RegisterSignal(container, COMSIG_ORGAN_REMOVED, .proc/deflate_belly)

/datum/component/belly_enlargement/proc/unregister_container()
	UnregisterSignal(container, COMSIG_ORGAN_REMOVED)
	UnregisterSignal(container, COMSIG_ORGAN_INSERTED)

/datum/component/belly_enlargement/Destroy(force)
	if(container)
		deflate_belly()
	return ..()

/datum/component/belly_enlargement/proc/on_entering(datum/source, atom/destination, atom/oldLoc)
	SIGNAL_HANDLER
	if(istype(destination, /obj/item/organ))
		container = destination
		register_container()
		enlarge_belly()
	else if(container)
		deflate_belly()
		unregister_container()
		container = null


/datum/component/belly_enlargement/proc/add_belly(size)
	if(!container.owner?.client?.prefs?.pregnancy_inflation)
		return
	var/obj/item/organ/genital/belly/belly = container.owner.getorganslot(ORGAN_SLOT_BELLY)
	if(!belly && ishuman(container.owner))
		var/mob/living/carbon/human/human_owner = container.owner
		belly = human_owner.give_genital(/obj/item/organ/genital/belly)
	belly?.modify_size(size)

//cannot use this proc for above size adding because different args may be passed to this by signals
/datum/component/belly_enlargement/proc/enlarge_belly()
	SIGNAL_HANDLER
	if(!container.owner?.client?.prefs?.pregnancy_inflation)
		return
	var/obj/item/organ/genital/belly/belly = container.owner.getorganslot(ORGAN_SLOT_BELLY)
	if(!belly && ishuman(container.owner))
		var/mob/living/carbon/human/human_owner = container.owner
		belly = human_owner.give_genital(/obj/item/organ/genital/belly)
	belly?.modify_size(belly_size)

/datum/component/belly_enlargement/proc/deflate_belly()
	SIGNAL_HANDLER
	var/obj/item/organ/genital/belly/belly = container?.owner?.getorganslot(ORGAN_SLOT_BELLY)
	belly?.modify_size(-belly_size)

/datum/component/belly_enlargement/Destroy(force, silent)
	deflate_belly()
	return ..()
