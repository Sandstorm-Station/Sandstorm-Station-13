/*
****************************************
// Modular Supermatter Delaminations! //
****************************************
The Problems:
• Staff manually delete the supermatter, because...
• Supermatter explosions are so frequent, and so large that people don't want to fix it.
Our Solutions:
• Make all supermatter explosions respect the bombcap, to prevent it annihilating a third of the station.
• Remove the tesla and singularity delaminations, because lets face it, staff would never allow it...
• Gauge prospective interest in fixing the supermatter, and scale damage based on how willing the crew is to fix the damage.
Our Method:
• Override the supermatter's explode() proc to respect the bombcap.
• Scan through the player list an count how many alive engineers are there. If you sign up as an engineer, you consent to fixing the damage.
*/

// Proc to screen the mob list for engineers. We'll need this later!
/proc/count_alive_engineers(mob/M)
	if(!istype(M) || isobserver(M))
		return FALSE
	if(M.stat != DEAD && M.mind && (M.mind.assigned_role in GLOB.engineering_positions))
		return TRUE

/obj/item/debug/engineer_counter
	name = "magical engineer counter"
	icon = 'icons/obj/guns/magic.dmi'
	icon_state = "nothingwand"
/obj/item/debug/engineer_counter/attack_self(mob/user)
	var/alive_engineers = 0
	for(var/mob/living/carbon/human/M in GLOB.alive_mob_list)
		if(count_alive_engineers(M))
			alive_engineers++
	priority_announce("There are [alive_engineers] alive engineers!", "How many engineers are there?")

/obj/machinery/power/supermatter_crystal/explode()
// Handle the mood event.
	var/turf/T = get_turf(src)
	for(var/mob/M in GLOB.player_list)
		if(M.z == z)
			SEND_SOUND(M, 'sound/magic/charge.ogg')
			to_chat(M, "<span class='boldannounce'>You feel reality distort for a moment...</span>")
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "delam", /datum/mood_event/delam)

// Replace the singularity and tesla delaminations with an EMP pulse. It's hard to achieve this without deliberate sabotage.
	if(combined_gas > MOLE_PENALTY_THRESHOLD || power > POWER_PENALTY_THRESHOLD)
		investigate_log("has reached critical mass, causing an EMP.", INVESTIGATE_SUPERMATTER)
		empulse_using_range(src, 14)

// Grab the mob list and count the amount of engineers there are.
	var/alive_engineers = 0
	for(var/mob/living/carbon/human/M in GLOB.alive_mob_list)
		if(count_alive_engineers(M))
			alive_engineers++
	switch(alive_engineers)

//	DELAMINATION A: No engineers, no explosion.
		if(0)
			investigate_log("has delaminated, but there are no engineers! Removing with no explosion.", INVESTIGATE_SUPERMATTER)
			priority_announce("A supermatter crystal delamination has been detected. Crystal hyperstructure has collapsed safely, resulting in a success complete self-annihilation of the supermatter entity.", "CRYSTAL DELAMINATION DETECTED!")
			qdel(src)
			return
//	DELAMINATION B: Too few engineers, minimal explosion.
		if(1 to 2)
			investigate_log("has delaminated, but there are only [alive_engineers] engineers! Defaulting to minimum explosion.", INVESTIGATE_SUPERMATTER)
			priority_announce("A supermatter crystal delamination has been detected. Crystal hyperstructure has collapsed within safety tolerance, resulting in majority self-annihilation.", "CRYSTAL DELAMINATION DETECTED!")
			explosion(get_turf(src), 1, 2, 3, 10, TRUE, FALSE, 5, FALSE, 1)
			qdel(src)
			return
//	DELAMINATION C: Enough engineers, halved explosion size.
		if(3 to 4)
			investigate_log("has delaminated with [alive_engineers] engineers, explosion size has been halved!", INVESTIGATE_SUPERMATTER)
			priority_announce("A supermatter crystal delamination has been detected. Crystal hyperstructure did not complete a controlled collapse.", "CRYSTAL DELAMINATION DETECTED!")
			explosion(get_turf(src), (explosion_power * max(gasmix_power_ratio, 0.205) * 0.5)/2, ((explosion_power * max(gasmix_power_ratio, 0.205))/2)+1, ((explosion_power * max(gasmix_power_ratio, 0.205))/2)+2, ((explosion_power * max(gasmix_power_ratio, 0.205))/2)+3, TRUE, FALSE)
			qdel(src)
			return
//	DELAMINATION D:
		if(5 to INFINITY)
			investigate_log("has delaminated with full effect due to there being [alive_engineers] engineers.", INVESTIGATE_SUPERMATTER)
			priority_announce("A supermatter crystal delamination has been detected. Crystal hyperstructure has failed catastrophically.", sender_override="CRYSTAL DELAMINATION DETECTED!")
			explosion(get_turf(T), explosion_power * max(gasmix_power_ratio, 0.205) * 0.5 , explosion_power * max(gasmix_power_ratio, 0.205) + 2, explosion_power * max(gasmix_power_ratio, 0.205) + 4 , explosion_power * max(gasmix_power_ratio, 0.205) + 6, TRUE, FALSE)
			qdel(src)
			return
		if(null)
			investigate_log("tried to delaminate, but there are... null alive engineers? [alive_engineers] <- that", INVESTIGATE_SUPERMATTER)
			qdel(src)
			return
