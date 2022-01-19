/obj/item/gun/ballistic/revolver/detective/Initialize()
	var/list/extra_reskin = list(
						"Fitz Special" = "detective_fitz",
						"Police Positive Special" = "detective_police",
						"Blued Steel" = "detective_blued",
						"Stainless Steel" = "detective_stainless",
						)
	LAZYADD(unique_reskin, extra_reskin)
	. = ..()


/obj/item/gun/ballistic/revolver/doublebarrel/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "_broke"]"
