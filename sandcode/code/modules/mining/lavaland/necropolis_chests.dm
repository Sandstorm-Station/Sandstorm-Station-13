//ghost sword buff because it is dogshit
/obj/item/melee/ghost_sword
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/melee/ghost_sword/attack(mob/living/target, mob/living/carbon/human/user)
	. = ..()
	force = 0
	throwforce = 0
	armour_penetration = 0
	var/ghost_counter = ghost_check()
	force = clamp((ghost_counter * 2.5), 15, 25)
	throwforce = clamp((ghost_counter * 2), 5, 18)
	armour_penetration = clamp((ghost_counter * 3), 0, 35)
	sharpness = IS_BLUNT
	if(ghost_counter >= 4)
		sharpness = IS_SHARP_ACCURATE
	user.visible_message("<span class='danger'>[user] strikes with the force of [ghost_counter] vengeful spirits!</span>")

/obj/item/melee/ghost_sword/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	var/ghost_counter = ghost_check()
	final_block_chance = clamp((ghost_counter * 5), 10, 50)
	owner.visible_message("<span class='danger'>[owner] is protected by a ring of [ghost_counter] ghosts!</span>")
	return ..()

//crystal choosing thing from colosssus
/obj/item/bluecrystal
	name = "\improper blue crystal"
	desc = "It's very shiny... one may wonder what it does."
	icon = 'sandcode/icons/obj/lavaland/artefacts.dmi'
	icon_state = "bluecrystal"
	w_class = WEIGHT_CLASS_SMALL
	var/list/choices = list(
	"Clown" = /obj/machinery/anomalous_crystal/honk,
	"Theme Warp" = /obj/machinery/anomalous_crystal/theme_warp,
	"Bolter" = /obj/machinery/anomalous_crystal/emitter,
	"Dark Revival" = /obj/machinery/anomalous_crystal/dark_reprise,
	"Lightgeist Healers" = /obj/machinery/anomalous_crystal/helpers,
	"Refresher" = /obj/machinery/anomalous_crystal/refresher,
	"Possessor" = /obj/machinery/anomalous_crystal/possessor
	)
	var/list/methods = list(
	"touch",
	"speech",
	"heat",
	"bullet",
	"energy",
	"bomb",
	"bumping",
	"weapon",
	"magic"
	)

/obj/item/bluecrystal/attack_self(mob/user)
	var/choice = input(user, "Choose your destiny", "Crystal") as null|anything in choices
	var/method = input(user, "Choose your activation method", "Crystal") as null|anything in methods
	if(!choice || !method)
		return
	playsound(user.loc, 'sound/effects/hit_on_shattered_glass.ogg', 100, TRUE)
	var/choosey = choices[choice]
	var/obj/machinery/anomalous_crystal/A = new choosey(user.loc)
	A.activation_method = method
	to_chat(user, "<span class='userdanger'>[A] appears under your feet as the [src] breaks apart!</span>")
	qdel(src)

//normal chests
/obj/structure/closet/crate/necropolis/tendril/PopulateContents()
	var/loot = rand(1,34)
	new /obj/item/stock_parts/cell/high/plus/argent(src)
	switch(loot)
		if(1)
			new /obj/item/shared_storage/red(src)
			return list(/obj/item/shared_storage/red)
		if(2)
			new /obj/item/clothing/suit/space/hardsuit/cult(src)
			return list(/obj/item/clothing/suit/space/hardsuit/cult)
		if(3)
			new /obj/item/soulstone/anybody(src)
			return list(/obj/item/soulstone/anybody)
		if(4)
			new /obj/item/katana/cursed(src)
			return list(/obj/item/katana/cursed)
		if(5)
			new /obj/item/clothing/glasses/godeye(src)
			return list(/obj/item/clothing/glasses/godeye)
		if(6)
			new /obj/item/reagent_containers/glass/bottle/potion/flight(src)
			return list(/obj/item/reagent_containers/glass/bottle/potion/flight)
		if(7)
			new /obj/item/pickaxe/diamond(src)
			return list(/obj/item/pickaxe/diamond)
		if(8)
			if(prob(50))
				new /obj/item/disk/design_disk/modkit_disc/resonator_blast(src)
				return list(/obj/item/disk/design_disk/modkit_disc/resonator_blast)
			else
				new /obj/item/disk/design_disk/modkit_disc/rapid_repeater(src)
				return list(/obj/item/disk/design_disk/modkit_disc/rapid_repeater)
		if(9)
			new /obj/item/rod_of_asclepius(src)
			return list(/obj/item/rod_of_asclepius)
		if(10)
			new /obj/item/organ/heart/cursed/wizard(src)
			return list(/obj/item/organ/heart/cursed/wizard)
		if(11)
			new /obj/item/ship_in_a_bottle(src)
			return list(/obj/item/ship_in_a_bottle)
		if(12)
			new /obj/item/clothing/suit/space/hardsuit/ert/paranormal/beserker(src)
			return list(/obj/item/clothing/suit/space/hardsuit/ert/paranormal/beserker)
		if(13)
			new /obj/item/jacobs_ladder(src)
			return list(/obj/item/jacobs_ladder)
		if(14)
			new /obj/item/nullrod/scythe/talking(src)
			return list(/obj/item/nullrod/scythe/talking)
		if(15)
			new /obj/item/nullrod/armblade(src)
			return list(/obj/item/nullrod/armblade)
		if(16)
			new /obj/item/guardiancreator(src)
			return list(/obj/item/guardiancreator)
		if(17)
			if(prob(50))
				new /obj/item/disk/design_disk/modkit_disc/mob_and_turf_aoe(src)
				return list(/obj/item/disk/design_disk/modkit_disc/mob_and_turf_aoe)
			else
				new /obj/item/disk/design_disk/modkit_disc/bounty(src)
				return list(/obj/item/disk/design_disk/modkit_disc/bounty)
		if(18)
			new /obj/item/warp_cube/red(src)
			return list(/obj/item/warp_cube/red)
		if(19)
			new /obj/item/wisp_lantern(src)
			return list(/obj/item/wisp_lantern)
		if(20)
			new /obj/item/immortality_talisman(src)
			return list(/obj/item/immortality_talisman)
		if(21)
			new /obj/item/gun/magic/hook(src)
			return list(/obj/item/gun/magic/hook)
		if(22)
			new /obj/item/voodoo(src)
			return list(/obj/item/voodoo)
		if(23)
			new /obj/item/grenade/clusterbuster/inferno(src)
			return list(/obj/item/grenade/clusterbuster/inferno)
		if(24)
			new /obj/item/reagent_containers/food/drinks/bottle/holywater/hell(src)
			return list(/obj/item/clothing/suit/space/hardsuit/ert/paranormal/inquisitor, /obj/item/reagent_containers/food/drinks/bottle/holywater/hell)
		if(25)
			new /obj/item/book/granter/spell/summonitem(src)
			return list(/obj/item/book/granter/spell/summonitem)
		if(26)
			new /obj/item/book_of_babel(src)
			return list(/obj/item/book_of_babel)
		if(27)
			new /obj/item/borg/upgrade/modkit/lifesteal(src)
			new /obj/item/bedsheet/cult(src)
			return list(/obj/item/borg/upgrade/modkit/lifesteal, /obj/item/bedsheet/cult)
		if(28)
			new /obj/item/clothing/neck/necklace/memento_mori(src)
			return list(/obj/item/clothing/neck/necklace/memento_mori)
		if(29)
			new /obj/item/gun/magic/staff/door(src)
			return list(/obj/item/gun/magic/staff/door)
		if(30)
			new /obj/item/katana/necropolis(src)
			return list(/obj/item/katana/necropolis)

/obj/item/stock_parts/cell/high/plus/argent
	name = "Argent Energy Cell"
	desc = "Harvested from the necropolis, this autocharging energy cell can be crushed to provide a temporary 90% damage reduction bonus. Also useful for research."
	self_recharge = 1
	maxcharge = 1500 //only barely better than a normal power cell now
	chargerate = 700 //good recharge time doe
	icon = 'sandcode/icons/obj/items_and_weapons.dmi'
	icon_state = "argentcell"
	ratingdesc = FALSE
	rating = 6
	custom_materials = list(/datum/material/glass=500, /datum/material/uranium=250, /datum/material/plasma=1000, /datum/material/diamond=500)
	var/datum/status_effect/onuse = /datum/status_effect/blooddrunk/argent

/obj/item/stock_parts/cell/high/plus/argent/attack_self(mob/user)
	..()
	user.visible_message("<span class='danger'>[user] crushes the [src] in his hands, absorbing it's energy!</span>")
	playsound(user.loc, 'sound/effects/hit_on_shattered_glass.ogg', 100, TRUE)
	var/mob/living/M = user
	M.apply_status_effect(onuse)
	qdel(src)

/obj/item/stock_parts/cell/high/plus/argent/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF)

/obj/item/katana/necropolis
	force = 25 //Wouldn't want a miner walking around with a 40 damage melee around now, would we?
	armour_penetration = 33
	block_chance = 0 //blocky bad

/obj/item/immortality_talisman
	w_class = WEIGHT_CLASS_SMALL //why the fuck are they large anyways

//legion
/obj/structure/closet/crate/necropolis/tendril/legion_loot
	name = "screeching crate"

/obj/structure/closet/crate/necropolis/tendril/legion_loot/PopulateContents()
	var/obj/structure/closet/crate/necropolis/tendril/N = new /obj/structure/closet/crate/necropolis/tendril()
	var/list/weedeater = N.PopulateContents()
	for(var/loot in weedeater)
		new loot(src)
	qdel(N)

/obj/structure/closet/crate/necropolis/legion
	name = "echoing legion crate"

/obj/structure/closet/crate/necropolis/legion/PopulateContents()
	new /obj/item/staff/storm(src)
	new /obj/item/crusher_trophy/golden_skull(src)
