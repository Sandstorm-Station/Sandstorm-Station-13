
GLOBAL_LIST_INIT(egg_skins, list( \
	"xenomorph",		\
	"badrecipe",  	\
	"chocolate",  	\
	"pellet",     	\
	"rock",       	\
	"chicken",    	\
	"slimeglob",  	\
	"synthetic",  	\
	"escapepod",  	\
	"cocoon",     	\
	"bugcocoon",  	\
	"yellow",     	\
	"blue",       	\
	"green",      	\
	"orange",     	\
	"purple",     	\
	"red",        	\
	"rainbow",    	\
	"pink",       	\
	"honeycomb",  	\
	"floppy",     	\
	"file",       	\
	"cd",         	\
	"spidercluster",	\
	"dragon",     	\
	"corrupteddemon",	\
	"holy",       	\
	"fish",       	\
	"insectoid",  	\
	"ashwalker",  	\
	"void",       	\
	"polychrome", 	\
	"ratvar",     	\
	"hybrid"	    \
))
//Oviposition egg, logic is at the pregnancy component
/obj/item/oviposition_egg
	name = "egg"
	desc = "An egg, this one looks suspiciously large though."
	icon_state = "egg_chicken"
	icon = 'modular_splurt/icons/obj/lewd_items/egg.dmi'
	integrity_failure = 0.9
	obj_flags = UNIQUE_RENAME

/obj/item/oviposition_egg/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/organ_inflation, 0)

/obj/item/oviposition_egg/obj_break(damage_flag)
	. = ..()
	icon = 'modular_splurt/icons/obj/lewd_items/egg_broken.dmi'
	update_appearance()
