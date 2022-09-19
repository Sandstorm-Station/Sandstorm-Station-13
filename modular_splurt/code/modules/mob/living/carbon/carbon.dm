/mob/living/carbon/is_muzzled()
	return ..() || istype(wear_mask, /obj/item/clothing/mask/gas/sechailer/slut)

/mob/living/carbon/cuff_resist(obj/item/I, breakouttime = 600, cuff_break = 0)
	if(istype(I, /obj/item/restraints/bondage_rope)) {
		var/obj/item/restraints/bondage_rope/rope = I
		cuff_break = rope.prepare_resist()
	}
	..()
