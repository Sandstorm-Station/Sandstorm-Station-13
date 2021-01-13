/obj/machinery/modular_computer/screwdriver_act(mob/user, obj/item/tool)
	if(cpu)
		return cpu.screwdriver_act(user, tool)
