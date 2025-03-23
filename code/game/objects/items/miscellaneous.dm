/obj/item/choice_beacon
	name = "choice beacon"
	desc = "Hey, why are you viewing this?!! Please let Centcom know about this odd occurance."
	icon = 'icons/obj/device.dmi'
	icon_state = "gangtool-blue"
	item_state = "radio"
	var/list/stored_options
	var/force_refresh = FALSE //if set to true, the beacon will recalculate its display options whenever opened

/obj/item/choice_beacon/attack_self(mob/user)
	if(canUseBeacon(user))
		generate_options(user)

/obj/item/choice_beacon/proc/generate_display_names() // return the list that will be used in the choice selection. entries should be in (type.name = type) fashion. see choice_beacon/hero for how this is done.
	return list()

/obj/item/choice_beacon/proc/canUseBeacon(mob/living/user)
	if(user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return TRUE
	else
		playsound(src, 'sound/machines/buzz-sigh.ogg', 40, 1)
		return FALSE

/obj/item/choice_beacon/proc/generate_options(mob/living/M)
	if(!stored_options || force_refresh)
		stored_options = generate_display_names()
	if(!stored_options.len)
		return
	var/choice = input(M,"Which item would you like to order?","Select an Item") as null|anything in stored_options
	if(!choice || !M.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return

	spawn_option(stored_options[choice],M)
	qdel(src)

/obj/item/choice_beacon/proc/create_choice_atom(atom/choice, mob/owner)
	return new choice()

/obj/item/choice_beacon/proc/spawn_option(atom/choice,mob/living/M)
	var/obj/new_item = create_choice_atom(choice, M)
	var/area/pod_storage_area = locate(/area/centcom/supplypod/podStorage) in GLOB.sortedAreas
	var/obj/structure/closet/supplypod/bluespacepod/pod = new(pick(get_area_turfs(pod_storage_area))) //Lets just have it in the pod storage zone for a really short time because we don't want it in nullspace
	pod.explosionSize = list(0,0,0,0)
	new_item.forceMove(pod)
	var/msg = "<span class='danger'>After making your selection, you notice a strange target on the ground. It might be best to step back!</span>"
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(istype(H.ears, /obj/item/radio/headset))
			msg = "You hear something crackle in your ears for a moment before a voice speaks.  \"Please stand by for a message from Central Command.  Message as follows: <span class='bold'>Item request received. Your package is inbound, please stand back from the landing site.</span> Message ends.\""
	to_chat(M, msg)

	new /obj/effect/pod_landingzone(get_turf(src), pod)

/obj/item/choice_beacon/ingredients
	name = "ingredient box delivery beacon"
	desc = "Summon a box of ingredients from a wide selection!"
	icon_state = "gangtool-red"

/obj/item/choice_beacon/ingredients/generate_display_names()
	var/static/list/ingredientboxes
	if(!ingredientboxes)
		ingredientboxes = list()
		var/list/templist = typesof(/obj/item/storage/box/ingredients)
		for(var/V in templist)
			var/obj/item/storage/box/ingredients/A = V
			ingredientboxes[initial(A.theme_name)] = A
	return ingredientboxes

/obj/item/choice_beacon/hero
	name = "heroic beacon"
	desc = "To summon heroes from the past to protect the future."

/obj/item/choice_beacon/hero/generate_display_names()
	var/static/list/hero_item_list
	if(!hero_item_list)
		hero_item_list = list()
		var/list/templist = typesof(/obj/item/storage/box/hero) //we have to convert type = name to name = type, how lovely!
		for(var/V in templist)
			var/atom/A = V
			hero_item_list[initial(A.name)] = A
	return hero_item_list

/obj/item/storage/box/hero
	name = "Courageous Tomb Raider - 1940's."

/obj/item/storage/box/hero/PopulateContents()
	new /obj/item/clothing/head/fedora/curator(src)
	new /obj/item/clothing/suit/curator(src)
	new /obj/item/clothing/under/rank/civilian/curator/treasure_hunter(src)
	new /obj/item/clothing/shoes/workboots/mining(src)
	new /obj/item/melee/curator_whip(src)

/obj/item/storage/box/hero/astronaut
	name = "First Man on the Moon - 1960's."

/obj/item/storage/box/hero/astronaut/PopulateContents()
	new /obj/item/clothing/suit/space/nasavoid(src)
	new /obj/item/clothing/head/helmet/space/nasavoid(src)
	new /obj/item/tank/internals/emergency_oxygen/double(src)
	new /obj/item/gps(src)

/obj/item/storage/box/hero/scottish
	name = "Braveheart, the Scottish rebel - 1300's."

/obj/item/storage/box/hero/scottish/PopulateContents()
	new /obj/item/clothing/under/costume/kilt(src)
	new /obj/item/claymore/weak/ceremonial(src)
	new /obj/item/toy/crayon/spraycan(src)
	new /obj/item/clothing/shoes/sandal(src)

/obj/item/choice_beacon/hosgun
	name = "personal weapon beacon"
	desc = "Use this to summon your personal Head of Security issued firearm!"

/obj/item/choice_beacon/hosgun/generate_display_names()
	var/static/list/hos_gun_list
	if(!hos_gun_list)
		hos_gun_list = list()
		var/list/templist = subtypesof(/obj/item/storage/secure/briefcase/hos/) //we have to convert type = name to name = type, how lovely!
		for(var/V in templist)
			var/atom/A = V
			hos_gun_list[initial(A.name)] = A
	return hos_gun_list

/obj/item/choice_beacon/augments
	name = "augment beacon"
	desc = "Summons augmentations."

/obj/item/choice_beacon/augments/generate_display_names()
	var/static/list/augment_list
	if(!augment_list)
		augment_list = list()
		var/list/templist = list(
		/obj/item/organ/cyberimp/brain/anti_drop,
		/obj/item/organ/cyberimp/arm/toolset,
		/obj/item/organ/cyberimp/arm/surgery,
		/obj/item/organ/cyberimp/chest/thrusters,
		/obj/item/organ/lungs/cybernetic/tier3,
		/obj/item/organ/liver/cybernetic/tier3) //cyberimplants range from a nice bonus to fucking broken bullshit so no subtypesof
		for(var/V in templist)
			var/atom/A = V
			augment_list[initial(A.name)] = A
	return augment_list

/obj/item/choice_beacon/augments/spawn_option(atom/choice,mob/living/M)
	new choice(get_turf(M))
	to_chat(M, "<span class='hear'>You hear something crackle from the beacon for a moment before a voice speaks. \"Please stand by for a message from S.E.L.F. Message as follows: <b>Item request received. Your package has been transported, use the autosurgeon supplied to apply the upgrade.</b> Message ends.\"</span>")

/obj/item/choice_beacon/pet //donator beacon that summons a small friendly animal
	name = "pet beacon"
	desc = "Straight from the outerspace pet shop to your feet."
	var/static/list/pets = list("Crab" = /mob/living/simple_animal/crab,
		"Cat" = /mob/living/simple_animal/pet/cat,
		"Space cat" = /mob/living/simple_animal/pet/cat/space,
		"Kitten" = /mob/living/simple_animal/pet/cat/kitten,
		"Dog" = /mob/living/simple_animal/pet/dog,
		"Corgi" = /mob/living/simple_animal/pet/dog/corgi,
		"Pug" = /mob/living/simple_animal/pet/dog/pug,
		"Exotic Corgi" = /mob/living/simple_animal/pet/dog/corgi/exoticcorgi,
		"Fox" = /mob/living/simple_animal/pet/fox,
		"Red Panda" = /mob/living/simple_animal/pet/redpanda,
		"Possum" = /mob/living/simple_animal/opossum)
	var/pet_name

/obj/item/choice_beacon/pet/generate_display_names()
	return pets

/obj/item/choice_beacon/pet/create_choice_atom(atom/choice, mob/owner)
	var/mob/living/simple_animal/new_choice = new choice()
	new_choice.butcher_results = null //please don't eat your pet, chef
	var/obj/item/pet_carrier/donator/carrier = new() //a donator pet carrier is just a carrier that can't be shoved in an autolathe for metal
	carrier.add_occupant(new_choice)
	new_choice.mob_size = MOB_SIZE_TINY //yeah we're not letting you use this roundstart pet to hurt people / knock them down
	new_choice.pass_flags = PASSTABLE | PASSMOB //your pet is not a bullet/person shield
	new_choice.density = FALSE
	new_choice.blood_volume = 0 //your pet cannot be used to drain blood from for a bloodsucker
	new_choice.desc = "A pet [initial(choice.name)], owned by [owner]!"
	new_choice.can_have_ai = FALSE //no it cant be sentient damnit
	if(pet_name)
		new_choice.name = pet_name
		new_choice.unique_name = TRUE
	return carrier

/obj/item/choice_beacon/pet/spawn_option(atom/choice,mob/living/M)
	pet_name = input(M, "What would you like to name the pet? (leave blank for default name)", "Pet Name")
	..()

//choice boxes (they just open in your hand instead of making a pod)
/obj/item/choice_beacon/box
	name = "choice box (default)"
	desc = "Think really hard about what you want, and then rip it open!"
	icon = 'icons/obj/storage.dmi'
	icon_state = "deliverypackage3"
	item_state = "deliverypackage3"

/obj/item/choice_beacon/box/spawn_option(atom/choice,mob/living/M)
	var/choice_text = choice
	if(ispath(choice_text))
		choice_text = initial(choice.name)
	to_chat(M, "<span class='hear'>The box opens, revealing the [choice_text]!</span>")
	playsound(src.loc, 'sound/items/poster_ripped.ogg', 50, 1)
	M.temporarilyRemoveItemFromInventory(src, TRUE)
	M.put_in_hands(new choice)
	qdel(src)

/obj/item/choice_beacon/box/plushie/spawn_option(choice,mob/living/M)
	if(ispath(choice, /obj/item/toy/plush))
		..() //regular plush, spawn it naturally
	else
		//snowflake plush
		var/obj/item/toy/plush/snowflake_plushie = new(get_turf(M))
		snowflake_plushie.set_snowflake_from_config(choice)
		M.temporarilyRemoveItemFromInventory(src, TRUE)
		M.put_in_hands(new choice)
		qdel(src)

/obj/item/choice_beacon/box/carpet //donator carpet beacon
	name = "choice box (carpet)"
	desc = "Contains 50 of a selected carpet inside!"
	var/static/list/carpet_list = list(/obj/item/stack/tile/carpet/black/fifty = "Black Carpet",
		"Black & Red Carpet" = /obj/item/stack/tile/carpet/blackred/fifty,
		"Monochrome Carpet" = /obj/item/stack/tile/carpet/monochrome/fifty,
		"Blue Carpet" = /obj/item/stack/tile/carpet/blue/fifty,
		"Cyan Carpet" = /obj/item/stack/tile/carpet/cyan/fifty,
		"Green Carpet" = /obj/item/stack/tile/carpet/green/fifty,
		"Orange Carpet" = /obj/item/stack/tile/carpet/orange/fifty,
		"Purple Carpet" = /obj/item/stack/tile/carpet/purple/fifty,
		"Red Carpet" = /obj/item/stack/tile/carpet/red/fifty,
		"Royal Black Carpet" = /obj/item/stack/tile/carpet/royalblack/fifty,
		"Royal Blue Carpet" = /obj/item/stack/tile/carpet/royalblue/fifty)

/obj/item/choice_beacon/box/carpet/generate_display_names()
	return carpet_list

/obj/item/choice_beacon/box/plushie
	name = "choice box (plushie)"
	desc = "Using the power of quantum entanglement, this box contains every plush, until the moment it is opened!"
	icon = 'icons/obj/plushes.dmi'
	icon_state = "box"
	item_state = "box"

/obj/item/choice_beacon/box/plushie/generate_display_names()
	var/static/list/plushie_list = list()
	if(!length(plushie_list))
		//plushie set 1: just subtypes of /obj/item/toy/plush
		var/list/plushies_set_one = subtypesof(/obj/item/toy/plush)
		plushies_set_one = remove_bad_plushies(plushies_set_one)
		for(var/V in plushies_set_one)
			var/atom/A = V
			plushie_list[initial(A.name)] = A
		//plushie set 2: snowflake plushies
		var/list/plushies_set_two = CONFIG_GET(keyed_list/snowflake_plushies)
		for(var/V in plushies_set_two)
			plushie_list[V] = V //easiest way to do this which works with how selecting options works, despite being snowflakey to have the key equal the value
	return plushie_list

/// Don't allow these special ones (you can still get narplush/hugbox)
/obj/item/choice_beacon/box/plushie/proc/remove_bad_plushies(list/plushies)
	plushies -= list(
		/obj/item/toy/plush/narplush,
		/obj/item/toy/plush/awakenedplushie,
		/obj/item/toy/plush/random_snowflake,
		/obj/item/toy/plush/plushling,
		/obj/item/toy/plush/random
		)
	return plushies

/obj/item/skub
	desc = "It's skub."
	name = "skub"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "skub"
	w_class = WEIGHT_CLASS_BULKY
	attack_verb = list("skubbed")

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

/obj/item/choice_beacon/bsbaton
	name = "personal weapon beacon"
	desc = "Use this to summon your personal baton!"

/obj/item/choice_beacon/bsbaton/generate_display_names()
	var/static/list/bsbaton_list
	if(!bsbaton_list)
		bsbaton_list = list()
		var/list/templist = subtypesof(/obj/item/storage/secure/briefcase/bsbaton/) //we have to convert type = name to name = type, how lovely!
		for(var/V in templist)
			var/atom/A = V
			bsbaton_list[initial(A.name)] = A
	return bsbaton_list


/obj/item/device/hailer
	name = "hailer"
	desc = "Used by obese officers to save their breath for running."
	icon = 'modular_sand/icons/obj/device.dmi'
	icon_state = "voice0"
	item_state = "flashbang"	//looks exactly like a flash (and nothing like a flashbang)
	w_class = WEIGHT_CLASS_TINY
	var/use_message = "Halt! Security!"
	var/spamcheck = 0
	var/insults

/obj/item/device/hailer/verb/set_message()
	set name = "Set Hailer Message"
	set category = "Object"
	set desc = "Alter the message shouted by your hailer."

	if(!isnull(insults))
		usr << "The hailer is fried. The tiny input screen just shows a waving ASCII penis."
		return

	var/new_message = input(usr, "Please enter new message (leave blank to reset).") as text
	if(!new_message || new_message == "")
		use_message = "Halt! Security!"
	else
		use_message = capitalize(copytext(sanitize(new_message), 1, MAX_MESSAGE_LEN))

	usr << "You configure the hailer to shout \"[use_message]\"."

/obj/item/device/hailer/attack_self(mob/living/carbon/user as mob)
	if (spamcheck)
		return

	if(isnull(insults))
		playsound(get_turf(src), 'modular_sand/sound/voice/halt.ogg', 100, 1, vary = 0)
		user.audible_message(span_warning("[user]'s [name] rasps, \"[use_message]\""), span_warning("\The [user] holds up \the [name]."))
	else
		if(insults > 0)
			playsound(get_turf(src), 'sound/voice/beepsky/insult.ogg', 100, 1, vary = 0)
			// Yes, it used to show the transcription of the sound clip. That was a) inaccurate b) immature as shit.
			user.audible_message(span_warning("[user]'s [name] gurgles something indecipherable and deeply offensive."), span_warning("\The [user] holds up \the [name]."))
			insults--
		else
			user << span_danger("*BZZZZZZZZT*")

	spamcheck = 1
	spawn(20)
		spamcheck = 0

/obj/item/device/hailer/emag_act(remaining_charges, mob/user)
	if(isnull(insults))
		user << span_danger("You overload \the [src]'s voice synthesizer.")
		insults = rand(1, 3)//to prevent dickflooding
		return 1
	else
		user << "The hailer is fried. You can't even fit the sequencer into the input slot."


/obj/item/disk/data
	max_mutations = 15

//This'll be used for gun permits, such as for heads of staff, crew, and bartenders. Sec and the Captain do not require these

/obj/item/clothing/accessory/permit
	name = "Weapons permit"
	desc = "A permit for carrying weapons."
	icon = 'modular_sand/icons/obj/permits.dmi'
	icon_state = "permit"
	mob_overlay_icon = 'icons/mob/clothing/accessories.dmi'
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FIRE_PROOF
	var/access = null
	var/owner = 0	//To prevent people from just renaming the thing if they steal it

/obj/item/clothing/accessory/permit/attack_self(mob/user as mob)
    if(isliving(user))
        if(!owner)
            set_name(user.name)
            to_chat(user, "[src] registers your name.")
            access += list(ACCESS_WEAPONS)
        else
            to_chat(user, "[src] already has an owner!")

/obj/item/clothing/accessory/permit/proc/set_name(new_name)
	owner = 1
	if(new_name)
		src.name += " ([new_name])"
		desc += " It belongs to [new_name]."

/obj/item/clothing/accessory/permit/head
	name = "Heads of staff weapon permit"
	desc = "A card indicating that the Head of staff is allowed to carry a weapon."
	icon_state = "compermit"

/obj/item/clothing/accessory/permit/bar
	name = "bar weapon permit"
	desc = "A card indicating that the barkeep is allowed to carry a weapon, most likely their shotgun."
	icon_state = "permit"

//Hyper stuff
// Bouquets
/obj/item/bouquet
	name = "mixed bouquet"
	desc = "A bouquet of sunflowers, lilies, and geraniums. How delightful."
	icon = 'modular_sand/icons/obj/items_and_weapons.dmi'
	icon_state = "mixedbouquet"

/obj/item/bouquet/sunflower
	name = "sunflower bouquet"
	desc = "A bright bouquet of sunflowers."
	icon_state = "sunbouquet"

/obj/item/bouquet/poppy
	name = "poppy bouquet"
	desc = "A bouquet of poppies. You feel loved just looking at it."
	icon_state = "poppybouquet"

/obj/item/bouquet/rose
	name = "rose bouquet"
	desc = "A bouquet of roses. A bundle of love."
	icon_state = "rosebouquet"

/obj/item/clothing/accessory/badge
	name = "security badge"
	desc = "A badge showing the wearer is a member of Security."
	icon = 'modular_sand/icons/obj/badge.dmi'
	icon_state = "security_badge"
	mob_overlay_icon = 'icons/mob/clothing/accessories.dmi'
	item_state = "lawerbadge"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FIRE_PROOF
	var/owner = null	//To prevent people from just renaming the thing if they steal it
	var/ownjob = null

/obj/item/clothing/accessory/badge/proc/update_label()
	name = "Badge-[owner] ([ownjob])"

/obj/item/clothing/accessory/badge/attackby(obj/item/C, mob/user)
	if(istype(C, /obj/item/card/id))
		var/obj/item/card/id/idcard = C
		if(!idcard.registered_name)
			to_chat(user, span_warning("\The [src] rejects the ID!"))
			return

		if(!owner)
			owner = idcard.registered_name
			ownjob = idcard.assignment
			update_label()
			to_chat(user, span_notice("Badge updated."))


/obj/item/clothing/accessory/badge/attack_self(mob/user)
	if(Adjacent(user))
		user.visible_message(span_notice("[user] shows you: [icon2html(src, viewers(user))] [src.name]."), \
					span_notice("You show \the [src.name]."))
		add_fingerprint(user)

/obj/item/clothing/accessory/badge/holo
	name = "security holo badge"
	desc = "A more futuristic hard-light badge"
	icon_state = "security_badge_holo"

/obj/item/clothing/accessory/badge/deputy
	name = "security deputy badge"
	desc = "A shiny silver badge for deputies on the Security force"
	icon_state = "security_badge_deputy"

/datum/design/sec_badge
	name = "Security Badge"
	desc = "A shiny badge to show the bearer is part of the Security force."
	id = "sec_badge"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/gold = 100)
	build_path = /obj/item/clothing/accessory/badge
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/dep_badge
	name = "Deputy Badge"
	desc = "A shiny badge for deputies to the Security force."
	id = "dep_badge"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/silver = 100)
	build_path = /obj/item/clothing/accessory/badge/deputy
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/handmirror/split_personality
	name = "dissociative mirror"
	desc = "An enchanted hand mirror. You may not recognize who stares back."
	var/item_used

/obj/item/handmirror/split_personality/attack_self(mob/user)
	// Check if already used
	if(item_used)
		// Warn user, then return
		to_chat(user, span_warning("[src] is no longer functional."))
		return

	// Check if human user exists
	if(!ishuman(user))
		// Warn user, then return
		to_chat(user, span_warning("You see nothing in [src]."))
		return

	// Define human user
	var/mob/living/carbon/human/mirror_user = user

	// Add brain trauma
	mirror_user.gain_trauma(/datum/brain_trauma/severe/split_personality, TRAUMA_RESILIENCE_SURGERY)

	// Set item used variable
	// This prevents future use
	item_used = TRUE

	// Alert in local chat
	mirror_user.visible_message(span_warning("The [src] shatters in [mirror_user]'s hands!"), span_warning("The mirror shatters in your hands!"))

	// Play mirror break sound
	playsound(src, 'sound/effects/Glassbr3.ogg', 50, 1)

	// Set flavor text
	name = "broken hand mirror"
	desc = "You won\'t get much use out of it."

/obj/item/choice_beacon/box/plushie/deluxe
	name = "Deluxe choice box (plushie)"
	desc =  "Using the power of quantum entanglement, this box contains five times every plush, until the moment it is opened!"
	var/uses = 5

/obj/item/choice_beacon/box/plushie/deluxe/spawn_option(choice, mob/living/M)
	//I don't wanna recode two different procs just for it to do the same as doing this
	if(uses > 1)
		var/obj/item/choice_beacon/box/plushie/deluxe/replace = new
		replace.uses = uses - 1
		M.put_in_hands(replace)
	. = ..()

/obj/item/choice_beacon/ouija
	name = "spirit board delivery beacon"
	desc = "Ghost communication on demand! It is unclear how this thing is still operational."

/obj/item/choice_beacon/ouija/generate_display_names()
	var/static/list/ouija_spaghetti_list
	if(!ouija_spaghetti_list)
		ouija_spaghetti_list = list()
		var/list/templist = list(/obj/structure/spirit_board)
		for(var/V in templist)
			var/atom/A = V
			ouija_spaghetti_list[initial(A.name)] = A
	return ouija_spaghetti_list
