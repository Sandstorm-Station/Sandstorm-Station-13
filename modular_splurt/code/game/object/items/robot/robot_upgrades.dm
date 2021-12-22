/obj/item/borg/upgrade/expand
	name = "borg expander"
	desc = "A cyborg resizer, it makes a cyborg huge."
	icon_state = "cyborg_upgrade3"
	var/ExpandSize = 200

/obj/item/borg/upgrade/expand/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)

		if(R.hasExpanded)
			to_chat(usr, "<span class='notice'>This unit already has an expand module installed!</span>")
			return FALSE

		if(R.hasShrunk)
			to_chat(usr, "<span class='notice'>This unit already has an shrink module installed!</span>")
			return FALSE

		R.mob_transforming = TRUE
		var/prev_locked_down = R.locked_down
		R.SetLockdown(1)
		R.anchored = TRUE
		var/datum/effect_system/smoke_spread/smoke = new
		smoke.set_up(1, R.loc)
		smoke.start()
		sleep(2)
		for(var/i in 1 to 4)
			playsound(R, pick('sound/items/drill_use.ogg', 'sound/items/jaws_cut.ogg', 'sound/items/jaws_pry.ogg', 'sound/items/welder.ogg', 'sound/items/ratchet.ogg'), 80, 1, -1)
			sleep(12)
		if(!prev_locked_down)
			R.SetLockdown(0)
		R.anchored = FALSE
		R.mob_transforming = FALSE
		R.resize = ExpandSize/100
		R.update_transform()
		R.hasExpanded = TRUE

/obj/item/borg/upgrade/expand/attack_self(mob/user)
	if(src && !user.incapacitated() && in_range(user,src))
		ExpandSize = input(user,"Choose the size of expanding (101-250)","Expander size setting") as null|num
		if(src && ExpandSize && !user.incapacitated() && in_range(user,src))
			sanitize_integer(ExpandSize, 101, 250, 200) //sanitize_integer won't work!
			if(!(101 <= ExpandSize && ExpandSize <= 250) || !isnum(ExpandSize) || ExpandSize == null)
				ExpandSize = 200
			to_chat(user, "<span class='notice'>Expand set to [ExpandSize] %.</span>")
			return ExpandSize

/obj/item/borg/upgrade/expand/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (. && R.hasExpanded)
		R.transform = null
		R.hasExpanded = FALSE

/obj/item/borg/upgrade/shrink
	name = "borg shrinker"
	desc = "A cyborg resizer, it makes a cyborg small."
	icon_state = "cyborg_upgrade3"
	var/ShrinkSize = 50

/obj/item/borg/upgrade/shrink/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)

		if(R.hasShrunk)
			to_chat(usr, "<span class='notice'>This unit already has an shrink module installed!</span>")
			return FALSE

		if(R.hasExpanded)
			to_chat(usr, "<span class='notice'>This unit already has an expand module installed!</span>")
			return FALSE

		R.mob_transforming = TRUE
		var/prev_locked_down = R.locked_down
		R.SetLockdown(1)
		R.anchored = TRUE
		var/datum/effect_system/smoke_spread/smoke = new
		smoke.set_up(1, R.loc)
		smoke.start()
		sleep(2)
		for(var/i in 1 to 4)
			playsound(R, pick('sound/items/drill_use.ogg', 'sound/items/jaws_cut.ogg', 'sound/items/jaws_pry.ogg', 'sound/items/welder.ogg', 'sound/items/ratchet.ogg'), 80, 1, -1)
			sleep(12)
		if(!prev_locked_down)
			R.SetLockdown(0)
		R.anchored = FALSE
		R.mob_transforming = FALSE
		R.resize = ShrinkSize/100
		R.update_transform()
		R.hasShrunk = TRUE

/obj/item/borg/upgrade/shrink/attack_self(mob/user)
	if(src && !user.incapacitated() && in_range(user,src))
		ShrinkSize = input(user,"Choose the size of shrinking (50-99)","Shrinker size setting") as null|num
		if(src && ShrinkSize && !user.incapacitated() && in_range(user,src))
			sanitize_integer(ShrinkSize, 50, 99, 50) //sanitize_integer won't work!
			if(!(50 <= ShrinkSize && ShrinkSize <= 99) || !isnum(ShrinkSize) || ShrinkSize == null)
				ShrinkSize = 50
			to_chat(user, "<span class='notice'>Shrink set to [ShrinkSize] %.</span>")
			return ShrinkSize

/obj/item/borg/upgrade/shrink/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (. && R.hasShrunk)
		R.transform = null
		R.hasShrunk = FALSE
