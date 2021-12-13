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
	playlewdinteractionsound(loc, pick(GLOB.brap_noises), 50, 1, -1)
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
	playlewdinteractionsound(loc, pick(GLOB.brap_noises), 50, 1, -1)
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
	var/jiggle = "[u_His] [pick(asscheeks)] [pick(list("jiggle", "bounce", "bounce around", "wobble"))] like crazy!"
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
		hell = pick(list(
			"thrusts in and out of \the <b>[target]</b>'s [pick(stankhole)] pucker, making it [pick("fumigate <b>[src]</b>'s cock with farts", "push out an unholy amount of ass gas")].",
			"pounds \the <b>[target]</b>'s ass. [t_He] [pick(braps)]",
			"slams [u_His] hips up against \the <b>[target]</b>'s [pick(stankhole)] [pick(ass)] hard, causing a massive surge of [pick(list("farts", "butt methane", "brap", "ass gas", "shit winds", "thick flatulence"))] from [t_His] [pick(list("crack", "canyon"))][prob(50) ? ". [jiggle]" : ""]",
			"goes balls deep into \the <b>[target]</b>'s [pick(ass)] over and over again. [t_He] can't stop pumping out [pick("", "[pick(stank)] ")] [pick(list("farts", "butt methane", "brap", "ass gas", "shit winds", "thick flatulence"))] from his wobbling [pick(asscheeks)]"))
	else
		hell = pick(list(
			"can already smell the stench as [u_He] works [u_His] cock into \the <b>[target]</b>'s brap hole, being received by a long and warm backblast.",
			"grabs the base of [u_His] twitching cock and presses the tip into \the <b>[target]</b>'s asshole, acting like a valve that unearths impossible amounts of pure, [pick(stank)] flatulence.",
			"shoves their dick deep inside of \the <b>[target]</b>'s [pick(ass)], [t_He] [pick(braps)][pick("", ". [jiggle]")]"))
		set_is_fucking(target, CUM_TARGET_ANUS, getorganslot(ORGAN_SLOT_PENIS) ? getorganslot(ORGAN_SLOT_PENIS) : null)

	message = "<span class='lewd'>\The <b>[src]</b> [pick(hell)]"
	visible_message(message, ignored_mobs = get_unconsenting(unholy = TRUE))
	playlewdinteractionsound(loc, pick(GLOB.brap_noises), 50, 1, -1)
	handle_post_sex(NORMAL_LUST, CUM_TARGET_ANUS, target)
	target.handle_post_sex(NORMAL_LUST, null, src)
