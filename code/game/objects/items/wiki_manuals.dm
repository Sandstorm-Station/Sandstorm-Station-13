
// Wiki books that are linked to the configured wiki link.

/// The size of the window that the wiki books open in.
#define BOOK_WINDOW_BROWSE_SIZE "970x710"
/// This macro will resolve to code that will open up the associated wiki page in the window.
#define WIKI_PAGE_IFRAME(wikiurl, link_identifier) {"
	<html>
	<head>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<style>
		iframe {
			display: none;
		}
	</style>
	</head>
	<body>
	<script type="text/javascript">
		function pageloaded(myframe) {
			document.getElementById("loading").style.display = "none";
			myframe.style.display = "inline";
	}
	</script>
	<p id='loading'>You start skimming through the manual...</p>
	<iframe width='100%' height='97%' onload="pageloaded(this)" src="[##wikiurl][##link_identifier]?printable=yes&remove_links=1" frameborder="0" id="main_frame"></iframe>
	</body>
	</html>
	"}

// A book that links to the wiki
/obj/item/book/manual/wiki
	starting_content = "Nanotrasen presently does not have any resources on this topic. If you would like to know more, contact your local Central Command representative." // safety
	/// The ending URL of the page that we link to.
	var/page_link = ""

/obj/item/book/manual/wiki/proc/get_link()
	return CONFIG_GET(string/wikiurltg)

/obj/item/book/manual/wiki/display_content(mob/living/user)
	var/wiki_url = get_link()
	if(!wiki_url)
		user.balloon_alert(user, "this book is empty!")
		return

	credit_book_to_reader(user)
	DIRECT_OUTPUT(user, browse(WIKI_PAGE_IFRAME(wiki_url, page_link), "window=manual;size=[BOOK_WINDOW_BROWSE_SIZE]")) // if you change this GUARANTEE that it works.

/obj/item/book/manual/wiki/cit
	name = "Citadel infobook"
	icon_state ="book8"
	starting_author = "Nanotrasen"
	starting_title = "Citadel infobook"
	page_link = ""

/obj/item/book/manual/wiki/cit/get_link()
	return CONFIG_GET(string/wikiurl)

/obj/item/book/manual/wiki/cit/chemistry
	name = "Chemistry Textbook"
	icon_state ="chemistrybook"
	starting_author = "Nanotrasen"
	starting_title = "Chemistry Textbook"
	page_link = "main/guides/guide_chemistry"

/obj/item/book/manual/wiki/cit/chem_recipies
	name = "Chemistry Recipies"
	icon_state ="chemrecibook"
	starting_author = "Chemcat"
	starting_title = "Chemistry Recipies"
	page_link = "main/guides/chem_recipies"

/obj/item/book/manual/wiki/chemistry
	name = "Outdated Chemistry Textbook"
	icon_state ="chemistrybook_old"
	starting_author = "Nanotrasen"
	starting_title = "Outdated Chemistry Textbook"
	page_link = "Guide_to_chemistry"

/obj/item/book/manual/wiki/chemistry/Initialize(mapload)
	. = ..()
	new /obj/item/book/manual/wiki/cit/chemistry(loc)
	new /obj/item/book/manual/wiki/cit/chem_recipies(loc)

/obj/item/book/manual/wiki/engineering_construction
	name = "Station Repairs and Construction"
	icon_state ="bookEngineering"
	starting_author = "Engineering Encyclopedia"
	starting_title = "Station Repairs and Construction"
	page_link = "Guide_to_construction"

/obj/item/book/manual/wiki/engineering_guide
	name = "Engineering Textbook"
	icon_state ="bookEngineering2"
	starting_author = "Engineering Encyclopedia"
	starting_title = "Engineering Textbook"
	page_link = "Guide_to_engineering"

/obj/item/book/manual/wiki/engineering_singulo_tesla
	name = "Singularity and Tesla for Dummies"
	icon_state ="bookEngineeringSingularitySafety"
	starting_author = "Engineering Encyclopedia"
	starting_title = "Singularity and Tesla for Dummies"
	page_link = "Singularity_and_Tesla_engines"

/obj/item/book/manual/wiki/security_space_law
	name = "Space Law"
	desc = "A set of Nanotrasen guidelines for keeping law and order on their space stations."
	icon_state = "bookSpaceLaw"
	starting_author = "Nanotrasen"
	starting_title = "Space Law"
	page_link = "Space_Law"

/obj/item/book/manual/wiki/security_space_law/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] pretends to read \the [src] intently... then promptly dies of laughter!"))
	return OXYLOSS

/obj/item/book/manual/wiki/infections
	name = "Infections - Making your own pandemic!"
	icon_state = "bookInfections"
	starting_author = "Infections Encyclopedia"
	starting_title = "Infections - Making your own pandemic!"
	page_link = "Infections"

/obj/item/book/manual/wiki/telescience
	name = "Teleportation Science - Bluespace for dummies!"
	icon_state = "book7"
	starting_author = "University of Bluespace"
	starting_title = "Teleportation Science - Bluespace for dummies!"
	page_link = "Guide_to_telescience"

/obj/item/book/manual/wiki/engineering_hacking
	name = "Hacking"
	icon_state ="bookHacking"
	starting_author = "Engineering Encyclopedia"
	starting_title = "Hacking"
	page_link = "Hacking"

/obj/item/book/manual/wiki/detective
	name = "The Film Noir: Proper Procedures for Investigations"
	icon_state ="bookDetective"
	starting_author = "Nanotrasen"
	starting_title = "The Film Noir: Proper Procedures for Investigations"
	page_link = "Detective"

/obj/item/book/manual/wiki/barman_recipes
	name = "Barman Recipes: Mixing Drinks and Changing Lives"
	icon_state = "barbook"
	starting_author = "Sir John Rose"
	starting_title = "Barman Recipes: Mixing Drinks and Changing Lives"
	page_link = "Guide_to_food_and_drinks"

/obj/item/book/manual/wiki/robotics_cyborgs
	name = "Robotics for Dummies"
	icon_state = "borgbook"
	starting_author = "XISC"
	starting_title = "Robotics for Dummies"
	page_link = "Guide_to_robotics"

/obj/item/book/manual/wiki/research_and_development
	name = "Research and Development 101"
	icon_state = "rdbook"
	starting_author = "Dr. L. Ight"
	starting_title = "Research and Development 101"
	page_link = "Guide_to_Research_and_Development"

/obj/item/book/manual/wiki/experimentor
	name = "Mentoring your Experiments"
	icon_state = "rdbook"
	starting_author = "Dr. H.P. Kritz"
	starting_title = "Mentoring your Experiments"
	page_link = "Experimentor"

/obj/item/book/manual/wiki/medical_cloning
	name = "Cloning techniques of the 26th century"
	icon_state ="bookCloning"
	starting_author = "Medical Journal, volume 3"
	starting_title = "Cloning techniques of the 26th century"
	page_link = "Guide_to_genetics#Cloning"

/obj/item/book/manual/wiki/cooking_to_serve_man
	name = "To Serve Man"
	desc = "It's a cookbook!"
	icon_state ="cooked_book"
	starting_author = "the Kanamitan Empire"
	starting_title = "To Serve Man"
	page_link = "Guide_to_food_and_drinks"

/obj/item/book/manual/wiki/circuitry
	name = "Circuitry for Dummies"
	icon_state = "book1"
	starting_author = "Dr. Hans Asperger"
	starting_title = "Circuitry for Dummies"
	page_link = "Guide_to_circuits"

/obj/item/book/manual/wiki/tcomms
	name = "Subspace Telecommunications And You"
	icon_state = "book3"
	starting_author = "Engineering Encyclopedia"
	starting_title = "Subspace Telecommunications And You"
	page_link = "Guide_to_Telecommunications"

/obj/item/book/manual/wiki/atmospherics
	name = "Lexica Atmosia"
	icon_state = "book5"
	starting_author = "the City-state of Atmosia"
	starting_title = "Lexica Atmosia"
	page_link = "Guide_to_Atmospherics"

/obj/item/book/manual/wiki/medicine
	name = "Medical Space Compendium, Volume 638"
	icon_state = "book8"
	starting_author = "Medical Journal"
	starting_title = "Medical Space Compendium, Volume 638"
	page_link = "Guide_to_medicine"

/obj/item/book/manual/wiki/surgery
	name = "Brain Surgery for Dummies"
	icon_state = "book4"
	starting_author = "Dr. F. Fran"
	starting_title = "Brain Surgery for Dummies"
	page_link = "Surgery"

/obj/item/book/manual/wiki/grenades
	name = "DIY Chemical Grenades"
	icon_state = "book2"
	starting_author = "W. Powell"
	starting_title = "DIY Chemical Grenades"
	page_link = "Grenade"

/obj/item/book/manual/wiki/toxins
	name = "Toxins or: How I Learned to Stop Worrying and Love the Maxcap"
	icon_state = "book6"
	starting_author = "Cuban Pete"
	starting_title = "Toxins or: How I Learned to Stop Worrying and Love the Maxcap"
	page_link = "Guide_to_toxins"

/obj/item/book/manual/wiki/rbmk
	name = "\improper Haynes nuclear reactor owner's manual"
	icon_state = "bookEngineering2"
	starting_author = "CogWerk Engineering Reactor Design Department"
	starting_title = "Haynes nuclear reactor owner's manual"
	page_link = "Guide_to_the_Nuclear_Reactor"

/obj/item/book/manual/wiki/rbmk/get_link()
	return "https://nsv.beestation13.com/wiki/"

/obj/item/book/manual/wiki/toxins/suicide_act(mob/user)
	var/mob/living/carbon/human/H = user
	user.visible_message(span_suicide("[user] starts dancing to the Rhumba Beat! It looks like [user.p_theyre()] trying to commit suicide!"))
	playsound(loc, 'sound/effects/spray.ogg', 10, 1, -3)
	if (!QDELETED(H))
		H.emote("spin")
		sleep(2 SECONDS)
		for(var/obj/item/W in H)
			H.dropItemToGround(W)
			if(prob(50))
				step(W, pick(GLOB.alldirs))
		ADD_TRAIT(H, TRAIT_DISFIGURED, TRAIT_GENERIC)
		for(var/i in H.bodyparts)
			var/obj/item/bodypart/BP = i
			BP.generic_bleedstacks += 5
		H.gib_animation()
		sleep(0.3 SECONDS)
		H.adjustBruteLoss(1000) //to make the body super-bloody
		// if we use gib() then the body gets deleted
		H.spawn_gibs()
		H.spill_organs()
		H.spread_bodyparts()
	return BRUTELOSS
