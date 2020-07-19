//kinetic destroyer (premium crusher)
/obj/item/kinetic_crusher/premiumcrusher
	icon = 'sandcode/icons/obj/mining.dmi'
	lefthand_file = 'sandcode/icons/mob/inhands/weapons/hammerspc_lefthand.dmi'
	righthand_file = 'sandcode/icons/mob/inhands/weapons/hammerspc_righthand.dmi'
	name = "Kinetic Destroyer"
	desc = "Revised and refined by veteran miners, this crusher design has been improved in nearly everyway. Featuring a lightweight composite body and a hardened plastitanium head, this weapon is exceptional at removing life from most things."
	hitsound = 'sound/weapons/bladeslice.ogg'
	armour_penetration = 15
	detonation_damage = 60
	backstab_bonus = 40

//legion (the big one!)
/obj/item/crusher_trophy/golden_skull
	name = "golden legion skull"
	desc = "Nope, it's not the crystal one, but still valuable. Suitable as a trophy for a kinetic crusher."
	icon = 'sandcode/icons/obj/lavaland/artefacts.dmi'
	icon_state = "goldenskull"
	denied_type = /obj/item/crusher_trophy/golden_skull

/obj/item/crusher_trophy/golden_skull/effect_desc()
	return "a kinetic crusher to make dead animals into friendly fauna, as well as turning corpses into legions"

/obj/item/crusher_trophy/golden_skull/on_mark_detonation(mob/living/target, mob/living/user)
	if(target.stat == DEAD)
		if(istype(target, /mob/living/simple_animal/hostile/asteroid))
			var/mob/living/simple_animal/hostile/asteroid/L = target
			L.revive(full_heal = 1, admin_revive = 1)
			if(ishostile(L))
				L.attack_same = 0
			L.loot = null
			L.crusher_loot = null
			L.faction = user.faction.Copy()
			user.visible_message("<span class='notice'>[user] revives [target] with [src], as a friendly fauna</span>")
			playsound(src,'sound/effects/supermatter.ogg',50,1)

/obj/item/crusher_trophy/golden_skull/on_melee_hit(mob/living/target, mob/living/user)
	if(ishuman(target) && (target.stat == DEAD))
		var/confirm = input("Are you sure you want to turn [target] into a friendly legion?", "Sure?") in list("Yes", "No")
		if(confirm == "Yes")
			var/mob/living/carbon/human/H = target
			var/mob/living/simple_animal/hostile/asteroid/hivelord/legion/L = new /mob/living/simple_animal/hostile/asteroid/hivelord/legion(H.loc)
			L.stored_mob = H
			H.forceMove(L)
			L.faction = user.faction.Copy()
			L.revive(full_heal = 1, admin_revive = 1)
			if(ishostile(L))
				L.attack_same = 0
			L.loot = null
			L.crusher_loot = null
			user.visible_message("<span class='notice'>[user] revives [target] with [src], as a friendly legion.</span>")
			playsound(src,'sound/effects/supermatter.ogg',50,1)
		else
			(to_chat(user, "<span class='notice'>You cancel turning [target] into a legion.</span>"))

//shambling miner
/obj/item/crusher_trophy/blaster_tubes/mask
	name = "mask of a shambling miner"
	desc = "It really doesn't seem like it could be worn. Suitable as a crusher trophy."
	icon = 'sandcode/icons/obj/lavaland/artefacts.dmi'
	icon_state = "miner_mask"
	bonus_value = 0
	denied_type = /obj/item/crusher_trophy/blaster_tubes/mask

/obj/item/crusher_trophy/blaster_tubes/mask/effect_desc()
	return "the crusher have no slowdown when wielded"

/obj/item/crusher_trophy/blaster_tubes/mask/on_projectile_fire(obj/item/projectile/destabilizer/marker, mob/living/user)
	if(deadly_shot)
		marker.name = "kinetic [marker.name]"
		marker.icon_state = "ka_tracer"
		marker.damage = bonus_value
		marker.nodamage = FALSE
		deadly_shot = FALSE

/obj/item/crusher_trophy/blaster_tubes/mask/on_mark_application(mob/living/target, datum/status_effect/crusher_mark/mark, had_mark)
	new /obj/effect/temp_visual/kinetic_blast(target)
	playsound(target.loc, 'sound/weapons/kenetic_accel.ogg', 60, 0)

/obj/item/crusher_trophy/blaster_tubes/mask/add_to(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	H.slowdown = 0
	H.slowdown_wielded = 0

/obj/item/crusher_trophy/blaster_tubes/mask/remove_from(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	H.slowdown = initial(H.slowdown)
	H.slowdown_wielded = initial(H.slowdown_wielded)

//lava imp
/obj/item/crusher_trophy/blaster_tubes/impskull
	name = "imp skull"
	desc = "Somebody got killed. Suitable as a trophy."
	icon = 'sandcode/icons/obj/lavaland/artefacts.dmi'
	icon_state = "impskull"
	bonus_value = 5
	denied_type = /obj/item/crusher_trophy/blaster_tubes/impskull

/obj/item/crusher_trophy/blaster_tubes/impskull/effect_desc()
	return "causes every marker to deal <b>[bonus_value]</b> damage."

/obj/item/crusher_trophy/blaster_tubes/impskull/on_projectile_fire(obj/item/projectile/destabilizer/marker, mob/living/user)
	marker.name = "fiery [marker.name]"
	marker.icon_state = "fireball"
	marker.damage = bonus_value
	marker.nodamage = FALSE
	playsound(user.loc, 'sandcode/sound/misc/impranged.wav', 50, 0)

//hierophant crusher small changes
/obj/item/crusher_trophy/vortex_talisman
	var/cdmultiplier = 1.25

/obj/item/crusher_trophy/vortex_talisman/on_mark_detonation(mob/living/target, mob/living/user)
	if(vortex_cd >= world.time)
		return
	var/turf/T = get_turf(user)
	var/obj/effect/temp_visual/hierophant/wall/crusher/wall = new /obj/effect/temp_visual/hierophant/wall/crusher(T, user) //a wall only you can pass!
	var/turf/otherT = get_step(T, turn(user.dir, 90))
	if(otherT)
		new /obj/effect/temp_visual/hierophant/wall/crusher(otherT, user)
	otherT = get_step(T, turn(user.dir, -90))
	if(otherT)
		new /obj/effect/temp_visual/hierophant/wall/crusher(otherT, user)
	vortex_cd = world.time + (wall.duration * cdmultiplier)

//watcher wing slight buff
/obj/item/crusher_trophy/watcher_wing
	bonus_value = 5
