/mob/living/proc/do_breastsmother(mob/living/target)
	var/message
	var/u_His = p_their()
	var/titties = list("breasts", "boobs", "milkers", "milktanks", "boobers", "titties", "tits", "tatas", "mammaries")
	var/list/lines = list(
		"squishes <b>[target]</b>'s face [pick(list("in between", "with"))] [u_His] [pick(titties)]",
		"presses [u_His] [pick(titties)] into \the <b>[target]</b>'s face",
		"shoves \the <b>[target]</b>'s whole head into [u_His] cleavage"
		)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(lines)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting())
	playlewdinteractionsound(loc, pick('modular_sand/sound/interactions/bang1.ogg',
						'modular_sand/sound/interactions/bang2.ogg',
						'modular_sand/sound/interactions/bang3.ogg'), 70, 1, -1)

/mob/living/proc/lick_sweat(mob/living/target)
	var/message
	var/t_His = target.p_their()
	var/list/lines = list("licks \the <b>[target]</b>'s sweat off [t_His] body",
							"slurps the salty sweat running through <b>[target]</b>'s skin",
							"has a nice taste of \the <b>[target]</b>'s drenched body",
							"takes a whiff of \the <b>[target]</b>'s musk and drinks [t_His] warm sweat")

	message = "<span class='lewd'>\The <b>[src]</b> [pick(lines)]"
	visible_message(message, ignored_mobs = get_unconsenting())
	playlewdinteractionsound(loc, 'modular_sand/sound/interactions/champ_fingering.ogg', 50, 1, -1)

/mob/living/proc/smother_armpit(mob/living/target)
	var/message
	var/u_His = p_their()
	var/list/musk = list("musky ", "sweaty ", "damp ", "smelly ", "")
	var/list/lines = list(
		"shoves \the <b>[target]</b>'s face in [u_His] [pick(musk)] armpit",
		"squeezes \the <b>[target]</b>'s nose under [u_His] [pick(musk)] pit",
		"makes sure to squeeze \the <b>[target]</b>'s face well under [u_His] [pick(musk)] armpit and let them take a whiff"
		)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(lines)]"
	visible_message(message, ignored_mobs = get_unconsenting())
	playlewdinteractionsound(loc, pick(
		'modular_sand/sound/interactions/squelch1.ogg',
		'modular_sand/sound/interactions/squelch2.ogg',
		'modular_sand/sound/interactions/squelch3.ogg'), 50, 1, -1)

/mob/living/proc/lick_armpit(mob/living/target)
	var/message
	var/u_His = p_their()
	var/list/musk = list("musky ", "sweaty ", "damp ", "smelly ", "")
	var/list/lines = list(
		"shoves [u_His] nose deep into \the <b>[target]</b>'s armpit, giving it a big [pick(list("whiff", "lick", "nuzzle"))].",
		"presses [u_His] face under \the <b>[target]</b>'s [pick(musk)] pit, [pick(list("tasting and lapping it all over", "sniffing its scent"))]",
		"goes face deep into \the <b>[target]</b> [pick(musk)] armpit, worshipping it with [u_His] tongue and nose"
	)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(lines)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting())
	playlewdinteractionsound(loc, pick(
		'modular_sand/sound/interactions/squelch1.ogg',
		'modular_sand/sound/interactions/squelch2.ogg',
		'modular_sand/sound/interactions/squelch3.ogg'), 50, 1, -1)

/mob/living/proc/do_boobjob(mob/living/target)
	var/message
	var/u_His = p_their()
	var/list/tiddies = list("breasts", "boobs", "honkers", "tatas", "tiddies", "milktanks", "mammaries", "milk bags", "boobers", "boobies")
	var/list/lines

	if(target.is_fucking(src, CUM_TARGET_BREASTS))
		lines = list(
			"slides [u_His] [pick(tiddies)], up and down through \the <b>[target]</b>'s throbbing cock",
			"squeezes [u_His] [pick(tiddies)] through all of \the <b>[target]</b>'s lenght",
			"jerks \the <b>[target]</b> off lustfully with [u_His] supple [pick(tiddies)]"
		)
	else
		lines = list(
			"clamps [u_His] [pick(tiddies)] around \the <b>[target]</b>'s throbbing cock, wrapping it in their sheer warmth",
			"envelops \the <b>[target]</b>'s hard member with [u_His] soft [pick(tiddies)], giving it a tight and sloshing squeeze",
			"lets [u_His] [pick(tiddies)] fall into \the <b>[target]</b>'s fat cock, smothering it in [u_His] cleavage"
		)
		target.set_is_fucking(src, CUM_TARGET_BREASTS, getorganslot(ORGAN_SLOT_PENIS))

	message = "<span class='lewd'>\The <b>[src]</b> [pick(lines)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting())
	playlewdinteractionsound(loc, pick('modular_sand/sound/interactions/bang1.ogg',
						'modular_sand/sound/interactions/bang2.ogg',
						'modular_sand/sound/interactions/bang3.ogg'), 70, 1, -1)
	target.handle_post_sex(NORMAL_LUST, CUM_TARGET_BREASTS, src)

/mob/living/proc/lick_nuts(mob/living/target)
	var/message
	var/u_His = p_their()
	var/t_His = target.p_their()
	var/lust_increase = 1
	var/list/balls = list("balls", "nuts", "[pick(list("cum", "spunk", "nut", "jizz", "seed"))] [pick(list("orbs", "spheres", "tanks", "holders"))]")
	var/list/lines

	if(target.is_fucking(src, NUTS_TO_FACE))
		lines = list(
			"worships \the <b>[target]</b>'s [pick(balls)] with [u_His] tongue",
			"takes a huff of \the <b>[target]</b>'s heavy ball musk and proceeds to lap the sweat off [t_His] [pick(balls)]",
			"plants smooches all over \the <b>[target]</b>'s heavy [pick(balls)], tasting [t_His] nutsack and massaging it with [u_His] lips"
		)
	else
		lines = list(
			"opens [u_His] maw and proceeds to bring \the <b>[target]</b>'s [pick(balls)] right in",
			"uses [u_His] tongue to fit \the <b>[target]</b>'s balls in [u_His] mouth, deeply huffing their scent",
			"willingly lets \the <b>[target]</b>'s [pick(balls)] fall into and fill [u_His] mouth, lustfully sucking into them"
		)
		target.set_is_fucking(src, NUTS_TO_FACE, getorganslot(ORGAN_SLOT_PENIS))

	message = "<span class='lewd'>\The <b>[src]</b> [pick(lines)]"
	visible_message(message, ignored_mobs = get_unconsenting())
	target.handle_post_sex(lust_increase, CUM_TARGET_MOUTH, src)

////////////////////////////////////////////////////////////////////////////////////////////////////////
///////// 									U N H O L Y										   /////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
/mob/living/proc/do_facefart(mob/living/carbon/target)
	var/message
	var/t_His = target.p_their()
	var/u_His = p_their()
	var/u_He = p_they()

	var/list/asscheeks = list("asscheeks", "buttcheeks", "ass buns", "booty pillows", "dumptruck spheres", "[pick(list("jiggly", "bouncy", "wobbly"))] buttocks")
	var/list/ass = list("ass", "butt", "dumptruck", "tush", "badonk", "booty", "rump")
	var/jiggle = "[u_His] [pick(asscheeks)] [pick(list("jiggle", "bounce", "bounce around", "wobble"))] like crazy!"
	var/list/stank = list("rancid", "pungent", "rotten", "boiling hot", "wet", "nose-burning", "heavy", "dense", "thick", "stinky", "stenchy", "warm")
	var/list/braps = list(
		"rips a [pick(list("massive", "fat", "engulfing", "breathtaking"))][pick(list(", [pick(stank)]", ""))] one",
		"[pick(list("", "wetly", "loudly"))] [pick(list("braps", "farts", "rips ass"))]",
		"lets out some of that [pick(stank)] [pick(list("gas", "flatulence", "anal hurricane"))]",
		"lets [u_His] shitter drop a [pick(list("large", "fat", "greasy"))] gas bomb",
		"allows [u_His] [pick(ass)] to rip an enormous, greasy gas cloud"
	)
	var/list/hell = list(
		"'s asshole squints as she shoves \the <b>[target]</b>'s face in between [u_His] sweaty [pick(asscheeks)], letting hell go loose!",
		" pushes [u_His] [pick(ass)] into \the <b>[target]</b>'s face, [pick(list("[t_His] nose shoved deep in [src]'s musky butthole", "[u_His] asshole sqints"))] as [u_He] [pick(braps)][pick(list("", ", [jiggle]"))]",
		" smothers \the [target]'s whole head in between [u_His][pick(list(" sweaty", "", " musky"))] [pick(asscheeks)], pushing out gallons of pure braps. [pick(list("", "[jiggle]"))]",
		"'s [pick(ass)] claps against \the <b>[target]</b>'s nose, right before [u_He] [pick(braps)]"
	)

	message = "<span class='lewd'>\The <b>[src]</b>[pick(hell)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(loc, pick(GLOB.brap_noises), 50, 1, -1, ignored_mobs = get_unconsenting(unholy = TRUE))
	if(!is_fucking(target, GRINDING_FACE_WITH_ANUS))
		set_is_fucking(target, GRINDING_FACE_WITH_ANUS, null)
	handle_post_sex(LOW_LUST, null, src)

/mob/living/proc/do_crotchfart(mob/living/carbon/target)
	var/message
	var/u_His = p_their()

	var/obj/item/organ/genital/brap_catcher = target.has_penis(REQUIRE_EXPOSED) && target.has_vagina(REQUIRE_EXPOSED) ? pick(list(target.getorganslot(ORGAN_SLOT_PENIS), target.getorganslot(ORGAN_SLOT_VAGINA))) : (target.has_penis(REQUIRE_EXPOSED) ? target.getorganslot(ORGAN_SLOT_PENIS) : (target.has_vagina(REQUIRE_EXPOSED) ? target.getorganslot(ORGAN_SLOT_VAGINA) : null))
	var/list/asscheeks = list("asscheeks", "buttcheeks", "ass buns", "booty pillows", "dumptruck spheres", "[pick(list("jiggly", "bouncy", "wobbly"))] buttocks")
	var/list/ass = list("ass", "butt", "dumptruck", "tush", "badonk", "booty", "rump")
	var/jiggle = "[u_His] [pick(asscheeks)] [pick(list("jiggle", "bounce", "bounce around", "wobble"))] like crazy!"
	var/list/stank = list("rancid", "pungent", "rotten", "boiling hot", "wet", "nose-burning", "heavy", "dense", "thick", "stinky", "stenchy", "warm")
	var/list/braps = list(
		"rips a [pick(list("massive", "fat", "engulfing", "breathtaking"))][pick(list(", [pick(stank)]", ""))] one",
		"[pick(list("", "wetly", "loudly"))] [pick(list("braps", "farts", "rips ass"))]",
		"lets out some of that [pick(stank)] [pick(list("gas", "flatulence", "anal hurricane"))]",
		"lets [u_His] shitter drop a [pick(list("large", "fat", "greasy"))] gas bomb",
		"allows [u_His] [pick(ass)] to rip an enormous, greasy gas cloud."
	)
	var/list/hell = list(
		" pushes [u_His] [pick(ass)] into \the <b>[target]</b>'s crotch, [pick(list("ripping a fat[pick(list("", " and [pick(stank)]"))] one", " and subsequently [pick(braps)]"))][pick(list("", ". [jiggle]"))]",
		" and \the <b>[target]</b> can smell the [prob(50) ? pick(stank) : "flatulent"] gas fill the room ass it seeps in between \the <b>[target]</b>'s thighs!",
		" [pick(braps)] into \the <b>[target]</b>'s [brap_catcher ? brap_catcher : "crotch"]"
	)

	message = "<span class='lewd'>\The <b>[src]</b>[pick(hell)]"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(loc, pick(GLOB.brap_noises), 50, 1, -1, ignored_mobs = get_unconsenting(unholy = TRUE))
	if(!target.is_fucking(src, CUM_TARGET_ANUS))
		target.set_is_fucking(src, CUM_TARGET_ANUS, target.has_penis(REQUIRE_EXPOSED) ? target.getorganslot(ORGAN_SLOT_PENIS) : (target.has_vagina(REQUIRE_EXPOSED) ? target.getorganslot(ORGAN_SLOT_VAGINA) : null))
	target.handle_post_sex(NORMAL_LUST, CUM_TARGET_ANUS, src)
	handle_post_sex(NORMAL_LUST, null, target)

/mob/living/proc/do_fartfuck(mob/living/target)
	var/message
	var/list/hell
	var/t_He = target.p_they()
	var/t_His = target.p_their()
	var/u_His = p_their()
	var/u_He = p_they()

	var/list/asscheeks = list("asscheeks", "buttcheeks", "ass buns", "booty pillows", "dumptruck spheres", "[pick(list("jiggly", "bouncy", "wobbly"))] buttocks")
	var/list/ass = list("ass", "butt", "dumptruck", "tush", "badonk", "booty", "rump")
	var/jiggle = "[t_His] [pick(asscheeks)] [pick(list("jiggle", "bounce", "bounce around", "wobble"))] like crazy!"
	var/list/stank = list("rancid", "pungent", "rotten", "boiling hot", "wet", "nose-burning", "heavy", "dense", "thick", "stinky", "stenchy", "warm")
	var/list/stankhole = list("stinky", "dirty", "gassy", "brapping", "noisy", "quaking", "musky")
	var/list/braps = list(
		"rips a [pick(list("massive", "fat", "engulfing", "breathtaking"))][pick(list(", [pick(stank)]", ""))] one",
		"[pick(list("", "wetly", "loudly"))] [pick(list("braps", "farts", "rips ass"))]",
		"lets out some of that [pick(stank)] [pick(list("gas", "flatulence", "anal hurricane"))]",
		"lets [u_His] shitter drop a [pick(list("large", "fat", "greasy"))] gas bomb",
		"allows [u_His] [pick(ass)] to rip an enormous, greasy gas cloud."
	)
	if(is_fucking(target, CUM_TARGET_ANUS))
		hell = list(
			"thrusts in and out of \the <b>[target]</b>'s [pick(stankhole)] pucker, making it [pick("fumigate <b>[src]</b>'s cock with farts", "push out an unholy amount of ass gas")].",
			"pounds \the <b>[target]</b>'s ass. [t_He] [pick(braps)]",
			"slams [u_His] hips up against \the <b>[target]</b>'s [pick(stankhole)] [pick(ass)] hard, causing a massive surge of [pick(list("farts", "butt methane", "brap", "ass gas", "shit winds", "thick flatulence"))] from [t_His] [pick(list("crack", "canyon"))][prob(50) ? ". [jiggle]" : ""]",
			"goes balls deep into \the <b>[target]</b>'s [pick(ass)] over and over again. [t_He] can't stop pumping out [pick("", "[pick(stank)] ")] [pick(list("farts", "butt methane", "brap", "ass gas", "shit winds", "thick flatulence"))] from his wobbling [pick(asscheeks)]")
	else
		hell = list(
			"can already smell the stench as [u_He] works [u_His] cock into \the <b>[target]</b>'s brap hole, being received by a long and warm backblast.",
			"grabs the base of [u_His] twitching cock and presses the tip into \the <b>[target]</b>'s asshole, acting like a valve that unearths impossible amounts of pure, [pick(stank)] flatulence.",
			"shoves their dick deep inside of \the <b>[target]</b>'s [pick(ass)], [t_He] [pick(braps)][pick("", ". [jiggle]")]")
		set_is_fucking(target, CUM_TARGET_ANUS, getorganslot(ORGAN_SLOT_PENIS) ? getorganslot(ORGAN_SLOT_PENIS) : null)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(hell)]"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(target.loc, pick(GLOB.brap_noises), 50, 1, -1, ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(target.loc, pick('modular_sand/sound/interactions/bang1.ogg',
						'modular_sand/sound/interactions/bang2.ogg',
						'modular_sand/sound/interactions/bang3.ogg',
						'modular_sand/sound/interactions/bang4.ogg',
						'modular_sand/sound/interactions/bang5.ogg',
						'modular_sand/sound/interactions/bang6.ogg'), 70, 1, -1)
	handle_post_sex(NORMAL_LUST, CUM_TARGET_ANUS, target)
	target.handle_post_sex(NORMAL_LUST, null, src)

/mob/living/proc/do_faceshit(mob/living/carbon/target)
	var/message
	var/u_His = p_their()
	var/t_His = target.p_their()

	var/list/asscheeks = list("asscheeks", "buttcheeks", "ass buns", "booty pillows", "dumptruck spheres", "[pick(list("jiggly", "bouncy", "wobbly"))] buttocks")
	var/list/ass = list("ass", "butt", "dumptruck", "tush", "badonk", "booty", "rump")
	var/jiggle = "[u_His] [pick(asscheeks)] [pick(list("jiggle", "bounce", "bounce around", "wobble"))] like crazy!"
	var/list/stank = list("rancid", "pungent", "rotten", "boiling hot", "wet", "nose-burning", "heavy", "dense", "thick", "stinky", "stenchy", "warm")
	var/list/stankhole = list("stinky", "dirty", "gassy", "shitting", "noisy", "quaking", "musky", "messy", "shitcaked", "nasty")

	var/list/hell = list(
		"presses [u_His] [pick(stankhole)] [pick(ass)] into \the <b>[target]</b>'s face, coating it in a [pick(stank)] layer of brown",
		"makes sure \the <b>[target]</b>'s mouth is wide open, letting out a greasy, [pick(stank)] log of manure right into it. [jiggle]",
		"smothers \the <b>[target]</b>'s face in between [u_His] musky, dirty asscheeks, [pick(list("", "letting out a [pick(stank)] fart and"))] sliding a monster turd right into [t_His] mouth"
	)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(hell)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(loc, pick(GLOB.brap_noises), 50, 1, -1, ignored_mobs = get_unconsenting(unholy = TRUE))
	if(!is_fucking(target, GRINDING_FACE_WITH_ANUS))
		set_is_fucking(target, GRINDING_FACE_WITH_ANUS, null)
	handle_post_sex(LOW_LUST, null, src)

/mob/living/proc/do_crotchshit(mob/living/carbon/target)
	var/message
	var/t_His = target.p_their()
	var/u_His = p_their()

	var/obj/item/organ/genital/brap_catcher = (target.has_penis(REQUIRE_EXPOSED) ? target.getorganslot(ORGAN_SLOT_PENIS) : (target.has_vagina(REQUIRE_EXPOSED) ? target.getorganslot(ORGAN_SLOT_VAGINA) : null))
	var/list/asscheeks = list("asscheeks", "buttcheeks", "ass buns", "booty pillows", "dumptruck spheres", "[pick(list("jiggly", "bouncy", "wobbly"))] buttocks")
	var/list/ass = list("ass", "butt", "dumptruck", "tush", "badonk", "booty", "rump")
	var/jiggle = "[u_His] [pick(asscheeks)] [pick(list("jiggle", "bounce", "bounce around", "wobble"))] like crazy!"
	var/list/stank = list("rancid", "pungent", "rotten", "boiling hot", "wet", "nose-burning", "heavy", "dense", "thick", "stinky", "stenchy", "warm")
	var/list/stankhole = list("stinky", "dirty", "gassy", "shitting", "noisy", "quaking", "musky", "messy", "shitcaked", "nasty")

	var/list/hell = list(
		"presses [u_His] [pick(stankhole)] [pick(asscheeks)] right against \the <b>[target]</b>'s crotch, unleashing pounds of warm crap all over [brap_catcher ? "[t_His] [brap_catcher]" : "it"] [prob(50) ? ". [jiggle]" : ""]",
		"shoves [u_His][pick(list("", " [pick(stank)],"))] shitting [pick(ass)] into \the <b>[target]</b>'s thighs and coats everything in between them with [pick("", "gas and ")] slick slop",
		"shits uncontrollably all over \the <b>[target]</b>'s [brap_catcher ? brap_catcher : "crotch"][prob(50) ? "" : ". [jiggle]"]"
	)

	message = "<span class='lewd'>\The <b>[src]</b>[pick(hell)]"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(loc, pick(GLOB.brap_noises), 50, 1, -1, ignored_mobs = get_unconsenting(unholy = TRUE))
	if(!target.is_fucking(src, CUM_TARGET_ANUS))
		target.set_is_fucking(src, CUM_TARGET_ANUS, brap_catcher)
	target.handle_post_sex(NORMAL_LUST, CUM_TARGET_ANUS, src)
	handle_post_sex(NORMAL_LUST, null, target)

/mob/living/proc/do_shitfuck(mob/living/carbon/target)
	var/message
	var/t_He = target.p_they()
	var/t_His = target.p_their()
	var/u_His = p_their()
	var/u_He = p_they()

	var/list/hell
	var/list/asscheeks = list("asscheeks", "buttcheeks", "ass buns", "booty pillows", "dumptruck spheres", "[pick(list("jiggly", "bouncy", "wobbly"))] buttocks")
	var/list/ass = list("ass", "butt", "dumptruck", "tush", "badonk", "booty", "rump")
	var/jiggle = "[t_His] [pick(asscheeks)] [pick(list("jiggle", "bounce", "bounce around", "wobble"))] like crazy!"
	var/list/stank = list("rancid", "pungent", "rotten", "boiling hot", "wet", "nose-burning", "heavy", "dense", "thick", "stinky", "stenchy", "warm")
	var/list/stankhole = list("stinky", "dirty", "gassy", "shitting", "noisy", "quaking", "musky", "messy", "shitcaked", "nasty")

	if(is_fucking(target, CUM_TARGET_ANUS))
		hell = list(
			"thrusts in and out of \the <b>[target]</b>'s [pick(stank)] shit-lubed pucker, making it squeak and expulse heavy gases and waste.",
			"pounds \the <b>[target]</b>'s ass. [t_He] just can't stop pumping out slop!",
			"slams [u_His] hips up against \the <b>[target]</b>'s [pick(stankhole)] [pick(ass)] hard, causing a massive surge of manure from [t_His] [pick(list("crack", "canyon"))][prob(50) ? ". [jiggle]" : ""]",
			"goes balls deep into \the <b>[target]</b>'s dirty [pick(ass)] over and over again. [u_His] cock comes completely coated brown from in between the bouncing [pick(asscheeks)]")
	else
		hell = list(
			"can already smell the stench as [u_He] works [u_His] cock into \the <b>[target]</b>'s dung hole, being received by warm, wet and nasty feeling all over it.",
			"grabs the base of [u_His] twitching cock and presses the tip into \the <b>[target]</b>'s asshole, immediately shoving it right into a fat and moisty log",
			"shoves  dick deep inside of \the <b>[target]</b>'s [pick(ass)], [t_He] releases a massive amount of mush to greet the rod[pick("", ". [jiggle]")]")
		set_is_fucking(target, CUM_TARGET_ANUS, getorganslot(ORGAN_SLOT_PENIS) ? getorganslot(ORGAN_SLOT_PENIS) : null)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(hell)]"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE), ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(target.loc, pick(GLOB.brap_noises), 70, 1, -1)
	playlewdinteractionsound(target.loc, pick('modular_sand/sound/interactions/bang1.ogg',
						'modular_sand/sound/interactions/bang2.ogg',
						'modular_sand/sound/interactions/bang3.ogg',
						'modular_sand/sound/interactions/bang4.ogg',
						'modular_sand/sound/interactions/bang5.ogg',
						'modular_sand/sound/interactions/bang6.ogg'), 70, 1, -1)
	handle_post_sex(NORMAL_LUST, CUM_TARGET_ANUS, target)
	target.handle_post_sex(NORMAL_LUST, null, src)

/mob/living/proc/piss_over(mob/living/target)
	var/message
	var/u_His = p_their()
	var/list/hell = list(
		"relieves [u_His] bladder all over \the <b>[target]</b>[pick(list("", "'s body"))]",
		"starts coating all of \the <b>[target]</b>'s body in warm piss",
		"lets out a moan of relief as yellow rain starts pouring over \the <b>[target]</b>"
	)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(hell)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE))
	if(get_lust() < 10)
		add_lust(10)

/mob/living/carbon/proc/piss_mouth(mob/living/target)
	var/message
	var/pee_pee = (has_penis(REQUIRE_EXPOSED) ? getorganslot(ORGAN_SLOT_PENIS) : (has_vagina(REQUIRE_EXPOSED) ? getorganslot(ORGAN_SLOT_VAGINA) : null))
	var/u_His = p_their()
	var/t_Him = target.p_them()
	var/list/hell = list(
		"relieves [u_His] bladder inside \the <b>[target]</b>'s mouth [pick(list("filling it with [pick(list("warm", "salty"))] yellow goodness", "making [t_Him] taste all of that piss"))]",
		"coats the back of \the <b>[target]</b>'s throat with [u_His] golden treat",
		"lets out a moan of relief as yellow rain starts pouring in between \the <b>[target]</b>'s lips"
	)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(hell)]</span>"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE))
	if(!is_fucking(target, CUM_TARGET_MOUTH))
		set_is_fucking(target, CUM_TARGET_MOUTH, pee_pee)
	handle_post_sex(NORMAL_LUST, CUM_TARGET_MOUTH, target)
