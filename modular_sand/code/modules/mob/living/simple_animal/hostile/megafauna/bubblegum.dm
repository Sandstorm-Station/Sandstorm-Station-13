/*

BUBBLEGUM

Removes slaughterlings (because they are bullshit), instead replacing them with the blood rending thing from tg

*/

/mob/living/simple_animal/hostile/megafauna/bubblegum
	death_sound = 'modular_sand/sound/misc/gorenest.ogg' //fuck it

/mob/living/simple_animal/hostile/megafauna/bubblegum/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/glory_kill, \
		messages_unarmed = list("grabs bubblegum by the leg, and pulls them down! While downed, they climb on their torso and punch through it, smashing their demonic heart!", "goes around bubblegum and climbs them by their back, once on top of their head they punch right through the demon's skull, ripping out brain matter and killing it as it limply falls on the ground!"), \
		messages_crusher = list("jumps and chops off both of bubblegum's legs in one swift move with their crusher! To finish off the now wheelchair-bound demon, they chop at the torso vertically, getting the crusher stuck in the process but killing the demonic fiend!", "goes around bubblegum and climbs them by their back, once on the top they chop their head off with the crusher!"), \
		messages_pka = list("shoots the weakened demon in the chest, opening a hole and exposing their inner core! With another blast, the demon's heart explodes, and they fall dead and limp on the ground!", "shoots the weakened demon's head, stunning them and revealing their brain! Another PKA blast finishes off what little brainmatter they had!"), \
		messages_pka_bayonet = list("shoots the weakened demon in the chest, opening a hole and exposing their inner core! They run onto the now exposed heart and stab it repeatedly with their bayonet, killing the demon off!"))
