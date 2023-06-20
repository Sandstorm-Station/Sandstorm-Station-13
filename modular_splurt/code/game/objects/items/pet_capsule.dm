//Pet Capsule
/obj/item/pet_capsule
	name = "pet capsule"
	desc = "A bluespace capsule used to store pets of the more... dangerous variety"
	icon = 'modular_splurt/icons/obj/pet_capsule.dmi'
	icon_state = "pet_capsule_closed"
	w_class = WEIGHT_CLASS_TINY
	var/mob/living/simple_animal/selected_pet
	var/mob/living/simple_animal/stored_pet
	var/new_name = "pet"
	var/pet_picked = FALSE
	var/open = FALSE

/obj/item/pet_capsule/proc/pet_capsule_triggered(atom/location_atom, is_in_hand = FALSE, mob/user = null)
	//If pet has not been chosen yet
	if (!pet_picked && is_in_hand && user != null)
		pet_picked = TRUE;

		new_name = input(user, "New name :", "Rename your pet(Once per shift!)")

		//radial menu appears to select one of the avaliable pets & store it in a template
		var/static/list/pet_icons
		if(!pet_icons)
			pet_icons = list(
			"Deathclaw" = image(icon = 'modular_splurt/icons/mob/deathclaw.dmi', icon_state = "deathclaw"),
			"Carp" = image(icon = 'icons/mob/animal.dmi', icon_state = "carp"),
			"Spider" = image(icon = 'icons/mob/animal.dmi', icon_state = "guard")
		)
		var/selected_icon = show_radial_menu(loc, loc , pet_icons,  radius = 42, require_near = TRUE)
		switch(selected_icon)
			if("Deathclaw")
				selected_pet = /mob/living/simple_animal/hostile/deathclaw/pet_deathclaw
			if("Carp")
				selected_pet = /mob/living/simple_animal/hostile/carp/pet_carp
			if("Spider")
				selected_pet = /mob/living/simple_animal/hostile/poison/giant_spider/pet_spider
			else
				pet_picked = FALSE;
				return FALSE
		return



	//Make pet appear if thrown on the floor
	else if (!open && !is_in_hand && pet_picked)
		open = TRUE
		icon_state = "pet_capsule_opened"
		var/turf/targetloc = location_atom
		stored_pet = new selected_pet(targetloc) //stores reference to the pet to be able to do the recall
		stored_pet.name = new_name //Apply the customized name
		loc.visible_message("<span class='warning'>\The [src] opens, [stored_pet.name] suddenly appearing!</span>")
		var/datum/effect_system/spark_spread/smoke = new
		smoke.set_up(10,TRUE, targetloc)
		smoke.start()
	//recall pet
	else
		open = FALSE
		icon_state = "pet_capsule_closed"
		loc.visible_message("<span class='warning'>\The [src] closes, [stored_pet.name] being recalled inside of it!</span>")
		del(stored_pet)

/obj/item/pet_capsule/attack_self(mob/user)
	pet_capsule_triggered(loc,TRUE,user)

/obj/item/pet_capsule/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	.=..()
	pet_capsule_triggered(hit_atom)

