// Only Clients should have a panel for them, okay?
/mob/Login()
	. = ..()
	AddComponent(/datum/component/interaction_menu_granter)

/mob/Logout()
	qdel(GetComponent(/datum/component/interaction_menu_granter))
	. = ..()

/mob/Initialize(mapload)
	. = ..()
	register_context()

/mob/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()
	if(user.GetComponent(/datum/component/interaction_menu_granter))
		LAZYSET(context[SCREENTIP_CONTEXT_CTRL_SHIFT_LMB], INTENT_ANY, "Interact with")
		return CONTEXTUAL_SCREENTIP_SET

///Adjust the thirst of a mob
/mob/proc/adjust_thirst(change, max = THIRST_LEVEL_THRESHOLD)
	thirst = clamp(thirst + change, 0, max)

/mob/proc/set_thirst(change)
	thirst = max(0, change)
