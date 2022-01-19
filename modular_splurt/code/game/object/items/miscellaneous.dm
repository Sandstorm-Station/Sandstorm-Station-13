/obj/item/choice_beacon/hosgun
    desc = "Use this to summon your personal Head of Security issued sidearm!"

/obj/item/choice_beacon/copgun
	name = "personal weapon beacon"
	desc = "Use this to summon your personal Security issued sidearm!"

/obj/item/choice_beacon/copgun/generate_display_names()
	var/static/list/cop_gun_list
	if(!cop_gun_list)
		cop_gun_list = list()
		var/list/templist = subtypesof(/obj/item/storage/secure/briefcase/cop/) //we have to convert type = name to name = type, how lovely!
		for(var/V in templist)
			var/atom/A = V
			cop_gun_list[initial(A.name)] = A
	return cop_gun_list
