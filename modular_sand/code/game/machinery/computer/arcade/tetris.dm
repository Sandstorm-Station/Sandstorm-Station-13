// The machine awards prizes based on score divided by this value
#define TETRIS_REWARD_DIVISOR 1000

// Score required to message admins
#define TETRIS_SCORE_HIGH 10000

// Maximum score accepted
#define TETRIS_SCORE_MAX 100000

// Maximum score to be used for research
#define TETRIS_SCORE_MAX_SCI 10000

// Time between dispensing prizes
#define TETRIS_TIME_COOLDOWN 600 // One minute

/obj/machinery/computer/arcade/tetris
	name = "T.E.T.R.I.S."
	desc = "The pinnacle of human technology."
	icon = 'icons/obj/computer.dmi'
	icon_state = "arcade"
	circuit = /obj/item/circuitboard/computer/arcade/tetris
	light_color = LIGHT_COLOR_GREEN
	var/cooldown_timer = 0

/obj/machinery/computer/arcade/tetris/Topic(href, href_list)
	if(..())
		return 1
	else
		usr.set_machine(src)
		if(href_list["tetrisScore"])
			// Sanitize score as an integer
			// Restricts maximum score to (default) 100,000
			var/temp_score = sanitize_num_clamp(text2num(href_list["tetrisScore"]), max=TETRIS_SCORE_MAX)

			// Check for high score
			if(temp_score > TETRIS_SCORE_HIGH)
				// Alert admins
				message_admins("[ADMIN_LOOKUPFLW(usr)] [ADMIN_KICK(usr)] has achieved a score of [temp_score] on [src] in [get_area(src.loc)]! Score exceeds configured suspicion threshold.")

			// Round and clamp prize count from 0 to 5
			var/reward_count = clamp(round(temp_score/TETRIS_REWARD_DIVISOR), 0, 5)

			// Define score text
			var/score_text = (reward_count ? temp_score : "PATHETIC! TRY HARDER")

			// Display normal message
			say("YOUR SCORE: [score_text]!")

			// Check if any prize would be vended
			if(!reward_count)
				// Return without further effects
				return

			// Check cooldown
			if(world.time < cooldown_timer)
				// Play a fake prize vend effect based on prizevend()
				playsound(src, 'sound/machines/machine_vend.ogg', 50, TRUE, extrarange = -3)
				visible_message(span_notice("[src] sputters for a moment before going quiet."))

				// Return with no further effects
				return

			// Set cooldown time
			cooldown_timer = world.time + TETRIS_TIME_COOLDOWN

			// Vend prizes
			prizevend(usr, reward_count)

			// Define user ID card
			var/obj/item/card/id/user_id = usr.get_idcard()

			// Check if ID exists
			// Check if ID has science access
			if(istype(user_id) && (ACCESS_RESEARCH in user_id.access))
				// Check if science exists
				if(SSresearch.science_tech)
					// Limit maximum research points to (default) 10,000
					var/score_research_points = clamp(temp_score, 0, TETRIS_SCORE_MAX_SCI)

					// Add science points based on score
					SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = score_research_points))

					// Announce points earned
					say("Research personnel detected. Applying gathered data to algorithms...")

	return

/obj/machinery/computer/arcade/tetris/attack_ai(user as mob)
	return src.attack_hand(user)

/obj/machinery/computer/arcade/tetris/attack_hand(mob/user as mob)
	if(..())
		return
	add_fingerprint(user)

	if(stat & (BROKEN|NOPOWER))
		return

	if(user.client)
		var/datum/asset/simple/assets = get_asset_datum(/datum/asset/simple/tetris)
		assets.send(user.client)

	var/dat = {"
	<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN'>
	<html><head>
	<META NAME='description' content='Tetris is a PC-Game, which is a part of the '7 by one stroke' package, written in HTML and JavaScript'>
	<META NAME='author' content='Lutz Tautenhahn'>
	<META NAME='keywords' content='Game, Tetris, Streich, Stroke, JavaScript'>
	<META HTTP-EQUIV='Content-Type' CONTENT='text/html; charset=iso-8859-1'>
	<title>Telemetry Enhanced Testing and Research Informatic Simulator</title>
	<script language='JavaScript'>
	function submitScore(s){
		window.location.href = 'byond://?src=\ref[src];tetrisScore=' + s;
	}
	</script>
	<script language='JavaScript1.2'>
	if (navigator.appName != 'Microsoft Internet Explorer')
	  document.captureEvents(Event.KEYDOWN)
	document.onkeydown = NetscapeKeyDown;
	function NetscapeKeyDown(key)
	{ KeyDown(key.which);
	}
	</script>
	<script for=document event='onkeydown()' language='JScript'>
	if (window.event) KeyDown(window.event.keyCode);
	</script>
	<script language='JavaScript' src='tetris.js'></script>
	</head>
	<BODY bgcolor=#E0A060>
	<form name='ScoreForm'>
	<DIV ALIGN=center>
	<table noborder><tr><td>
	<script language='JavaScript' src='tetris2.js'></script>
	</td>
	<td>&nbsp;&nbsp;&nbsp;</td>
	<td valign=top>
	<table border=4 cellpadding=4 cellspacing=6  bgcolor=#C0B0A0><tr><td>
	<table noborder cellpadding=2 cellspacing=2>
	<tr><td align=center><input type=button width='70' style='width:70;' value='Pause' onClick='Pause()'></td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td align=center><input type=button width='70' style='width:70;' value='New' onClick='New()'></td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td align=center>Score:</td></tr>
	<tr><td align=center><input type=button width='70' style='width:70; background-color:#ffffff' name='Score'></td></tr>
	<tr><td align=center>Level:</td></tr>
	<tr><td align=center><input type=button width='70' style='width:70; background-color:#ffffff' name='Level' onClick='IncreaseDifficulty()'></td></tr>
	<tr><td align=center>Lines:</td></tr>
	<tr><td align=center><input type=button width='70' style='width:70; background-color:#ffffff' name='Lines''></td></tr>
	<tr><td align=center><table border=2 cellpadding=0 cellspacing=3><tr><td><img src='tetrisp0.gif' border=0></td></tr></table></td></tr>
	</table></td></tr></table>
	</td></tr></table>
	<script language='JavaScript'>
	Init(true);
	</script>
	</DIV>
	</form>
	</BODY>
	</HTML>
	"}
	user << browse(dat, "window=tetris;size=435x550")
	user.set_machine(src)
	onclose(user, "tetris")

// Remove defines
#undef TETRIS_REWARD_DIVISOR
#undef TETRIS_SCORE_HIGH
#undef TETRIS_SCORE_MAX
#undef TETRIS_SCORE_MAX_SCI
#undef TETRIS_TIME_COOLDOWN
