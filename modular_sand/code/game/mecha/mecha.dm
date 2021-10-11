#define MECH_SIZE 1.5

/obj/mecha/Initialize()
	. = ..()
	var/matrix/M = matrix(transform)
	M.Scale(MECH_SIZE, MECH_SIZE)
	M.Translate(0, 16*(MECH_SIZE-1))
	transform = M

#undef MECH_SIZE
