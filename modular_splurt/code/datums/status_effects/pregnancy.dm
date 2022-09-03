/**
 * Who is the liar but he who denies that Jesus is the Christ? This is the antichrist, he who denies the Father and the Son.
 * - John 2:22
 */
/atom/movable/screen/alert/status_effect/pregnancy
	name = "Pregnant"
	desc = "Welp, you sure are pregnant."
	icon = 'modular_splurt/icons/mob/screen_alert.dmi'
	icon_state = "baby"

/datum/status_effect/pregnancy
	id = "pregnancy"
	duration = -1
	tick = FALSE
	alert_type = /atom/movable/screen/alert/status_effect/pregnancy

