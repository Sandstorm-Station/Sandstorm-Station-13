/obj/item/armorkit/blueshield
	name = "aegis armor kit"
	desc = "A nanotrasen armoring kit with armored plates and some nanoglue, for reinforcing outerwear."
	icon = 'modular_splurt/icons/obj/clothing/reinforcekits.dmi'
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "blueshield_armor_kit" // I'm so sorry I butchered the sprite, Toriate.

/obj/item/armorkit/blueshield/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	// yeah have fun making subtypes and modifying the afterattack if you want to make variants
	// idiot
	// I have no idea what you are talking about.
	var/used = FALSE

	if(isobj(target) && istype(target, /obj/item/clothing/suit))
		var/obj/item/clothing/suit/C = target
		if(C.damaged_clothes)
			to_chat(user,"<span class='warning'>You should repair the damage done to [C] first.</span>")
			return
		if(C.armor.getRating(MELEE) < 30)
			C.armor = C.armor.setRating(MELEE = 30)
			used = TRUE
		if(C.armor.getRating(BULLET) < 30)
			C.armor = C.armor.setRating(BULLET = 30)
			used = TRUE
		if(C.armor.getRating(LASER) < 30)
			C.armor = C.armor.setRating(LASER = 30)
			used = TRUE
		if(C.armor.getRating(ENERGY) < 40)
			C.armor = C.armor.setRating(ENERGY = 40)
			used = TRUE
		if(C.armor.getRating(BOMB) < 25)
			C.armor = C.armor.setRating(BOMB = 25)
			used = TRUE
		if(C.armor.getRating(FIRE) < 70)
			C.armor = C.armor.setRating(FIRE = 70)
			used = TRUE
		if(C.armor.getRating(ACID) < 90)
			C.armor = C.armor.setRating(ACID = 90)
			used = TRUE
		if(C.armor.getRating(WOUND) < 10)
			C.armor = C.armor.setRating(WOUND = 10)
			used = TRUE

		if(used)
			user.visible_message("<span class = 'notice'>[user] reinforces [C] with [src].</span>", \
			"<span class = 'notice'>You reinforce [C] with [src], making it as protective as a blueshield armored vest.</span>")
			C.name = "aegis [C.name]"
			C.upgrade_prefix = "aegis" // god i hope this works
			qdel(src)
			return
		else
			to_chat(user, "<span class = 'notice'>You don't need to reinforce [C] any further.")
			return
	else
		return

/obj/item/armorkit/blueshield/helmet
	name = "aegis headgear kit"
	desc = "A nanotrasen armoring kit with armored plates and some nanoglue, for reinforcing hats or other headgear."
	icon = 'modular_splurt/icons/obj/clothing/reinforcekits.dmi'
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "blueshield_helmet_kit" // I'm so sorry I butchered the sprite, Toriate. (x2)

/obj/item/armorkit/blueshield/helmet/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	var/used = FALSE

	if(isobj(target) && istype(target, /obj/item/clothing/head))
		var/obj/item/clothing/head/C = target
		if(C.damaged_clothes)
			to_chat(user,"<span class='warning'>You should repair the damage done to [C] first.</span>")
			return
		if(C.armor.getRating(MELEE) < 40)
			C.armor = C.armor.setRating(MELEE = 40)
			used = TRUE
		if(C.armor.getRating(BULLET) < 30)
			C.armor = C.armor.setRating(BULLET = 30)
			used = TRUE
		if(C.armor.getRating(LASER) < 25)
			C.armor = C.armor.setRating(LASER = 25)
			used = TRUE
		if(C.armor.getRating(ENERGY) < 10)
			C.armor = C.armor.setRating(ENERGY = 10)
			used = TRUE
		if(C.armor.getRating(BOMB) < 25)
			C.armor = C.armor.setRating(BOMB = 25)
			used = TRUE
		if(C.armor.getRating(BIO) < 10)
			C.armor = C.armor.setRating(BIO = 10)
			used = TRUE
		if(C.armor.getRating(FIRE) < 50)
			C.armor = C.armor.setRating(FIRE = 50)
			used = TRUE
		if(C.armor.getRating(ACID) < 60)
			C.armor = C.armor.setRating(ACID = 60)
			used = TRUE

		if(used)
			user.visible_message("<span class = 'notice'>[user] reinforces [C] with [src].</span>", \
			"<span class = 'notice'>You reinforce [C] with [src], making it as protective as a blueshield helmet.</span>")
			C.name = "aegis [C.name]"
			C.upgrade_prefix = "aegis" // god i hope this works
			qdel(src)
			return
		else
			to_chat(user, "<span class = 'notice'>You don't need to reinforce [C] any further.")
			return
	else
		return
