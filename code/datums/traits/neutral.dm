//traits with no real impact that can be taken freely
//MAKE SURE THESE DO NOT MAJORLY IMPACT GAMEPLAY. those should be positive or negative traits.

/datum/quirk/no_taste
	name = "Ageusia"
	desc = "You can't taste anything! Toxic food will still poison you."
	value = 0
	mob_trait = TRAIT_AGEUSIA
	gain_text = "<span class='notice'>You can't taste anything!</span>"
	lose_text = "<span class='notice'>You can taste again!</span>"
	medical_record_text = "Patient suffers from ageusia and is incapable of tasting food or reagents."

/datum/quirk/snob
	name = "Snob"
	desc = "You care about the finer things, if a room doesn't look nice its just not really worth it, is it?"
	value = 0
	gain_text = "<span class='notice'>You feel like you understand what things should look like.</span>"
	lose_text = "<span class='notice'>Well who cares about deco anyways?</span>"
	medical_record_text = "Patient seems to be rather stuck up."
	mob_trait = TRAIT_SNOB

/datum/quirk/pineapple_liker
	name = "Ananas Affinity"
	desc = "You find yourself greatly enjoying fruits of the ananas genus. You can't seem to ever get enough of their sweet goodness!"
	value = 0
	gain_text = "<span class='notice'>You feel an intense craving for pineapple.</span>"
	lose_text = "<span class='notice'>Your feelings towards pineapples seem to return to a lukewarm state.</span>"
	medical_record_text = "Patient demonstrates a pathological love of pineapple."

/datum/quirk/pineapple_liker/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.liked_food |= PINEAPPLE

/datum/quirk/pineapple_liker/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.liked_food &= ~PINEAPPLE

/datum/quirk/pineapple_hater
	name = "Ananas Aversion"
	desc = "You find yourself greatly detesting fruits of the ananas genus. Serious, how the hell can anyone say these things are good? And what kind of madman would even dare putting it on a pizza!?"
	value = 0
	gain_text = "<span class='notice'>You find yourself pondering what kind of idiot actually enjoys pineapples...</span>"
	lose_text = "<span class='notice'>Your feelings towards pineapples seem to return to a lukewarm state.</span>"
	medical_record_text = "Patient is correct to think that pineapple is disgusting."

/datum/quirk/pineapple_hater/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.disliked_food |= PINEAPPLE

/datum/quirk/pineapple_hater/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.disliked_food &= ~PINEAPPLE

/datum/quirk/deviant_tastes
	name = "Deviant Tastes"
	desc = "You dislike food that most people enjoy, and find delicious what they don't."
	value = 0
	gain_text = "<span class='notice'>You start craving something that tastes strange.</span>"
	lose_text = "<span class='notice'>You feel like eating normal food again.</span>"
	medical_record_text = "Patient demonstrates irregular nutrition preferences."

/datum/quirk/deviant_tastes/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	var/liked = species.liked_food
	species.liked_food = species.disliked_food
	species.disliked_food = liked

/datum/quirk/deviant_tastes/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.liked_food = initial(species.liked_food)
		species.disliked_food = initial(species.disliked_food)

/datum/quirk/monochromatic
	name = "Monochromacy"
	desc = "You suffer from full colorblindness, and perceive nearly the entire world in blacks and whites."
	value = 0
	medical_record_text = "Patient is afflicted with almost complete color blindness."

/datum/quirk/monochromatic/add()
	quirk_holder.add_client_colour(/datum/client_colour/monochrome)

/datum/quirk/monochromatic/post_add()
	if(quirk_holder.mind.assigned_role == "Detective")
		to_chat(quirk_holder, "<span class='boldannounce'>Mmm. Nothing's ever clear on this station. It's all shades of gray...</span>")
		quirk_holder.playsound_local(quirk_holder, 'sound/ambience/ambidet1.ogg', 50, FALSE)

/datum/quirk/monochromatic/remove()
	if(quirk_holder)
		quirk_holder.remove_client_colour(/datum/client_colour/monochrome)

/datum/quirk/maso
	name = "Masochism"
	desc = "You are aroused by pain."
	value = 0
	mob_trait = TRAIT_MASO
	gain_text = "<span class='notice'>You desire to be hurt.</span>"
	lose_text = "<span class='notice'>Pain has become less exciting for you.</span>"

/datum/quirk/libido
	name = "Nymphomaniac"
	desc = "You are much more sensitive to arousal."
	value = 0
	mob_trait = TRAIT_NYMPHO
	gain_text = "<span class='notice'>You are feeling extra wild.</span>"
	lose_text = "<span class='notice'>You don't feel that burning sensation anymore.</span>"

/datum/quirk/libido/add()
	var/mob/living/carbon/human/H = quirk_holder
	H.arousal_rate = 3 * initial(H.arousal_rate)

/datum/quirk/libido/remove()
	var/mob/living/carbon/human/H = quirk_holder
	H.arousal_rate = initial(H.arousal_rate)

/datum/quirk/alcohol_intolerance
	name = "Alcohol Intolerance"
	desc = "You take toxin damage from alcohol rather than getting drunk."
	value = 0
	mob_trait = TRAIT_TOXIC_ALCOHOL
	medical_record_text = "Patient's body does not react properly to ethyl alcohol."

/datum/quirk/alcohol_intolerance/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.disliked_food |= ALCOHOL

/datum/quirk/alcohol_intolerance/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.disliked_food &= ~ALCOHOL

/datum/quirk/longtimer
	name = "Longtimer"
	desc = "You've been around for a long time and seen more than your fair share of action, suffering some pretty nasty scars along the way. For whatever reason, you've declined to get them removed or augmented."
	value = 0
	gain_text = "<span class='notice'>Your body has seen better days.</span>"
	lose_text = "<span class='notice'>Your sins may wash away, but those scars are here to stay...</span>"
	medical_record_text = "Patient has withstood significant physical trauma and declined plastic surgery procedures to heal scarring."
	/// the minimum amount of scars we can generate
	var/min_scars = 3
	/// the maximum amount of scars we can generate
	var/max_scars = 7

/datum/quirk/longtimer/on_spawn()
	var/mob/living/carbon/C = quirk_holder
	C.generate_fake_scars(rand(min_scars, max_scars))

/datum/quirk/trashcan
	name = "Trashcan"
	desc = "You are able to consume and digest trash."
	value = 0
	gain_text = "<span class='notice'>You feel like munching on a can of soda.</span>"
	lose_text = "<span class='notice'>You no longer feel like you should be eating trash.</span>"
	mob_trait = TRAIT_TRASHCAN

/datum/quirk/colorist
	name = "Colorist"
	desc = "You like carrying around a hair dye spray to quickly apply color patterns to your hair."
	value = 0
	medical_record_text = "Patient enjoys dyeing their hair with pretty colors."

/datum/quirk/colorist/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/dyespray/spraycan = new(get_turf(quirk_holder))
	H.equip_to_slot(spraycan, ITEM_SLOT_BACKPACK)
	H.regenerate_icons()

/datum/quirk/colorist/post_add()
	var/mob/living/carbon/human/H = quirk_holder
	SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_SHOW, H)
	to_chat(quirk_holder, "<span class='boldnotice'>You brought some extra dye with you! It's in your bag if you forgot.</span>")

/datum/quirk/salt_sensitive
	name = "Sodium Sensitivity"
	desc = "Your body is sensitive to sodium, and is burnt upon contact. Ingestion or contact with it is not advised."
	value = 0
	medical_record_text = "Patient should not come into contact with sodium."
	mob_trait = TRAIT_SALT_SENSITIVE

/datum/quirk/vampire
	name = "Bloodsucker Fledgeling"
	desc = "you need blood for nutriment, you have fangs to aid with this, the church does not harm you"
	value = 3
	medical_record_text = "this person was partially infected by a bloodsucker"
	mob_trait = BLOODFLEDGE
	gain_text = "<span class='notice'>You feel an otherworldly thirst.</span>"
	lose_text = "<span class='notice'>you feel an otherworldy burden remove itself</span>"
	processing_quirk = TRUE

/datum/quirk/vampire/on_spawn()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	var/mob/living/carbon/C = quirk_holder
	ADD_TRAIT(H,TRAIT_NO_PROCESS_FOOD,SPECIES_TRAIT)
	ADD_TRAIT(H,TRAIT_COLDBLOODED,SPECIES_TRAIT)
	ADD_TRAIT(H,TRAIT_NOBREATH,SPECIES_TRAIT)
	ADD_TRAIT(H,TRAIT_NOTHIRST,SPECIES_TRAIT)
	if(!C.dna.skin_tone_override)
		H.skin_tone = "albino"
	H.grant_ability_from_source(list(INNATE_ABILITY_VBITE),ABILITY_SOURCE_SPECIES)//gives the ability, check innate_abilities for defining new abilities

/datum/quirk/vampire/on_process()
	. = ..()
	var/mob/living/carbon/C = quirk_holder
	var/area/A = get_area(C)
	if(istype(A, /area/service/chapel) && C.mind?.assigned_role != "Chaplain")
		to_chat(C, "<span class='danger'>You don't belong here!</span>")
		C.adjustFireLoss(5)
		C.adjust_fire_stacks(6)

/// quirk actions ///

//vampire bite
/datum/action/vbite
	name = "Bite Victim"
	button_icon_state = "power_feed"
	icon_icon = 'icons/mob/actions/bloodsucker.dmi'
	desc = "bite the person you are grabbing with your fangs"

#define VAMP_DRAIN_AMOUNT 50

/datum/action/vbite/Trigger()
	. = ..()
	var/drain_cooldown = 0
	if(iscarbon(owner))
		var/mob/living/carbon/H = owner
		if(H.nutrition >= 800)
			to_chat(H, "<span class='notice'>You are too full to drain any more.</span>")
			return
		if(drain_cooldown >= world.time)
			to_chat(H, "<span class='notice'>You just drained blood, wait a few seconds.</span>")
			return
		if(H.pulling && iscarbon(H.pulling))
			var/mob/living/carbon/victim = H.pulling
			drain_cooldown = world.time + 40
			if(victim.anti_magic_check(FALSE, TRUE, FALSE, 0))
				to_chat(victim, "<span class='warning'>[H] tries to bite you, but stops before touching you!</span>")
				to_chat(H, "<span class='warning'>[victim] is blessed! You stop just in time to avoid catching fire.</span>")
				return
			//Here we check now for both the garlic cloves on the neck and for blood in the victims bloodstream.
			if(!blood_sucking_checks(victim, TRUE, TRUE))
				return
			if(!do_after(H, 30, target = victim))
				return
			var/blood_volume_difference = BLOOD_VOLUME_MAXIMUM - H.blood_volume //How much capacity we have left to absorb blood
			var/drained_blood = min(victim.blood_volume, VAMP_DRAIN_AMOUNT, blood_volume_difference)
			H.reagents.add_reagent(/datum/reagent/blood/, drained_blood)
			to_chat(victim, "<span class='danger'>[H] is draining your blood!</span>")
			H.visible_message("<span class='danger'>[H] Bites down on [victim]'s neck!</span>")
			to_chat(H, "<span class='notice'>You drain some blood!</span>")
			playsound(H, 'sound/items/drink.ogg', 30, 1, -2)
			victim.blood_volume = clamp(victim.blood_volume - drained_blood, 0, BLOOD_VOLUME_MAXIMUM)
			if(!victim.blood_volume)
				to_chat(H, "<span class='warning'>You finish off [victim]'s blood supply!</span>")

/datum/action/vbite/New(Target)//defines the button
	link_to(Target)
	button = new
	button.linked_action = src
	button.name = name
	button.actiontooltipstyle = buttontooltipstyle
	if(desc)
		button.desc = desc

//put next quirk action here
