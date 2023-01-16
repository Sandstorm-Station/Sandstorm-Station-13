//help
/datum/interaction/lewd

	var/unholy = FALSE //Same as extreme but... we don't talk about this one...

	var/require_user_legs
	var/require_user_num_legs

	var/require_target_legs
	var/require_target_num_legs

	var/require_user_belly
	var/require_target_belly

/datum/interaction/lewd/evaluate_user(mob/living/user, silent = TRUE, action_check = TRUE)
	if(require_user_belly)
		switch(require_user_belly)
			if(REQUIRE_EXPOSED)
				if(!user.has_belly(REQUIRE_EXPOSED))
					if(!silent)
						to_chat(user, span_warning("Your belly needs to be exposed."))
					return FALSE
			if(REQUIRE_ANY)
				if(!user.has_belly(REQUIRE_ANY))
					if(!silent)
						to_chat(user, span_warning("Your belly seems to be too flat for that."))
					return FALSE
			if(REQUIRE_UNEXPOSED)
				if(!user.has_belly(REQUIRE_UNEXPOSED))
					if(!silent)
						to_chat(user, span_warning("Your belly needs to be unexposed."))
					return FALSE

	if(require_user_legs)
		switch(require_user_legs)
			if(REQUIRE_EXPOSED)
				if(!user.has_legs(REQUIRE_EXPOSED))
					if(!silent)
						to_chat(user, span_warning("Your legs need to be exposed."))
					return FALSE
			if(REQUIRE_UNEXPOSED)
				if(!user.has_legs(REQUIRE_UNEXPOSED))
					if(!silent)
						to_chat(user, span_warning("Your legs need to be unexposed."))
					return FALSE
			if(REQUIRE_ANY)
				if(!user.has_legs(REQUIRE_ANY))
					if(!silent)
						to_chat(user, span_warning("You don't have enough legs."))
					return FALSE

	if(require_user_num_legs && (user.has_legs() < require_user_num_legs))
		if(!silent)
			to_chat(user, span_warning("Your don't have enough legs."))
		return FALSE


	if(unholy)
		var/client/cli = user.client
		if(cli)
			if(cli.prefs.unholypref == "No")
				if(!silent)
					to_chat(user, span_warning("That's way too much for you."))
				return FALSE
	. = ..()

/datum/interaction/lewd/evaluate_target(mob/living/user, mob/living/target, silent = TRUE)
	if(require_target_belly)
		switch(require_target_belly)
			if(REQUIRE_EXPOSED)
				if(!target.has_belly(REQUIRE_EXPOSED))
					if(!silent)
						to_chat(user, span_warning("Their belly needs to be exposed."))
					return FALSE
			if(REQUIRE_ANY)
				if(!target.has_belly(REQUIRE_ANY))
					if(!silent)
						to_chat(user, span_warning("Their belly seems to be too flat for that."))
					return FALSE
			if(REQUIRE_UNEXPOSED)
				if(!target.has_belly(REQUIRE_UNEXPOSED))
					if(!silent)
						to_chat(user, span_warning("Their belly needs to be unexposed."))
					return FALSE

	if(require_target_legs)
		switch(require_target_legs)
			if(REQUIRE_EXPOSED)
				if(!target.has_legs(REQUIRE_EXPOSED))
					if(!silent)
						to_chat(user, span_warning("[target.p_their()] legs need to be exposed."))
					return FALSE
			if(REQUIRE_UNEXPOSED)
				if(!target.has_legs(REQUIRE_UNEXPOSED))
					if(!silent)
						to_chat(user, span_warning("[target.p_their()] legs need to be unexposed."))
					return FALSE
			if(REQUIRE_ANY)
				if(!target.has_legs(REQUIRE_ANY))
					if(!silent)
						to_chat(user, span_warning("[target.p_they()] [target.p_do()]n't have enough legs."))
					return FALSE

	if(require_target_num_legs && (target.has_legs() < require_target_num_legs))
		if(!silent)
			to_chat(user, span_warning("[target.p_they()] [target.p_do()]n't have enough legs."))
		return FALSE

	if(unholy)
		var/client/cli = target.client
		if(cli)
			if(target.client.prefs.unholypref == "No")
				if(!silent)
					to_chat(user, span_warning("For some reason, you don't want to do this to [target]."))
				return FALSE
	. = ..()

/mob/living/list_interaction_attributes(mob/living/LM)
	. = ..()
	if(has_belly(REQUIRE_EXPOSED))
		. += "...have a belly"
