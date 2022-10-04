/datum/hud/qareen/New(mob/owner)
	..()

	healths = new /atom/movable/screen/healths/qareen()
	healths.hud = src
	infodisplay += healths
