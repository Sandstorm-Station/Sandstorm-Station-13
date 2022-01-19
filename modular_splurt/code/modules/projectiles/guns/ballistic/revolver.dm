/obj.item/gun/ballstic/revolver/detective
	unique_reskin = list("Default" = "detective",
						"Fitz Special" = "detective_fitz",
						"Police Positive Special" = "detective_police",
						"Blued Steel" = "detective_blued",
						"Stainless Steel" = "detective_stainless",
						"Gold Trim" = "detective_gold",
						"Leopard Spots" = "detective_leopard",
						"The Peacemaker" = "detective_peacemaker",
						"Black Panther" = "detective_panther"
						)

/obj/item/gun/ballistic/revolver/doublebarrel/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "_broke"]"
