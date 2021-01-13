/obj/item/modular_computer/screwdriver_act(mob/user, obj/item/tool)
	if(!all_components.len)
		to_chat(user, "<span class='warning'>This device doesn't have any components installed.</span>")
		return
	var/list/component_names = list()
	for(var/h in all_components)
		var/obj/item/computer_hardware/H = all_components[h]
		component_names.Add(H.name)

	var/choice = input(user, "Which component do you want to uninstall?", "Computer maintenance", null) as null|anything in sortList(component_names)

	if(!choice)
		return

	if(!Adjacent(user))
		return

	var/obj/item/computer_hardware/H = find_hardware_by_name(choice)

	if(!H)
		return

	uninstall_component(H, user)
	return
