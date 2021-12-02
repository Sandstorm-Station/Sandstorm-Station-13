//normal ball mittens
/obj/item/clothing/gloves/ball_mittens
	name = "Ball mittens"
	desc = "A nice, comfortable pair of inflatable ball gloves."
	icon_state = "ballmittens"
	item_state = "ballmittens"
	icon = 'modular_sand/icons/obj/clothing/lewd_clothes/gloves/lewd_gloves.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/lewd_clothing/gloves/lewd_gloves.dmi'
	//equip_delay_other = 60
	// equip_delay_self = 60
	// strip_delay = 60
	breakouttime = 10

//That part allows reinforcing this item with handcuffs
/obj/item/clothing/gloves/ball_mittens/attackby(obj/item/I, mob/user, params)
    if(istype(I, /obj/item/restraints/handcuffs))
        var/obj/item/clothing/gloves/ball_mittens_reinforced/W = new /obj/item/clothing/gloves/ball_mittens_reinforced
        remove_item_from_storage(user)
        user.put_in_hands(W)
        to_chat(user, span_notice("You reinforced the belts on [src] with [I]."))
        qdel(I)
        qdel(src)
        return
    . = ..()

//ball_mittens reinforced
/obj/item/clothing/gloves/ball_mittens_reinforced //We getting this item by using handcuffs on normal ball mittens
	name = "reinforced ball mittens"
	desc = "Do not put these on, it's REALLY hard to take them off! But they look so comfortable..."
	icon_state = "ballmittens"
	item_state = "ballmittens"
	icon = 'modular_sand/icons/obj/clothing/lewd_clothes/gloves/lewd_gloves.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/lewd_clothing/gloves/lewd_gloves.dmi'
	// equip_delay_other = 80
	// equip_delay_self = 80
	// strip_delay = 80
	breakouttime = 1000 //do not touch this, i beg you.

//latex gloves
/obj/item/clothing/gloves/latex_gloves
	name = "Latex gloves"
	desc = "Awesome looking gloves that are satisfying to the touch."
	icon_state = "latexgloves"
	item_state = "latexgloves"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'modular_sand/icons/obj/clothing/lewd_clothes/gloves/lewd_gloves.dmi'
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/lewd_clothing/gloves/lewd_gloves.dmi'
	var/seamless = FALSE

//Lock

/obj/item/clothing/gloves/latex_gloves/attackby(/obj/item/gloves, mob/user, params)
	if(istype(gloves, /obj/item/key/latex))
		if(seamless != FALSE)
			to_chat(user, "<span class='warning'>The gloves seem to loosen!</span>")
			seamless = FALSE
		else
			to_chat(user, "<span class='warning'>The gloves suddenly tighten!</span>")
			seamless = TRUE
	return

/obj/item/clothing/gloves/latex_gloves/attack_hand(mob/living/carbon/human/user)
	var/mob/living/carbon/human/C = user
	if(iscarbon(user) && seamless && (user.get_item_by_slot(SLOT_GLOVES)))
		to_chat(C, span_purple(pick("You rub your gloved fingers together as you search for some sort of escape.",
									"You can't find any leverage to remove these gloves!",
									"Your pointless clawing seems to only make things more skin tight")))
		return
	. = ..()
