/obj/item/pen/attack(mob/living/M, mob/user, stealth)
	if(!istype(M))
		return

	if(!force)
		if(M.can_inject(user, 1))
			if(user.a_intent == "harm") //old poke requires harm intent.
				return ..()

			else //writing time
				var/mob/living/carbon/human/T = M
				if(!T) //not human.
					return
				if(!T.is_chest_exposed())
					to_chat(user, "<span class='warning'>You cannot write on someone with their clothes on.</span>")
					return

				var/obj/item/G = T.pick_receiving_organ(T, NONE, "Pick a genital to write on", "Cancel to write on the targeted body part")

				var/obj/item/BP = (G ? G : T.get_bodypart(user.zone_selected))

				if(!BP)
					return

				var/writting = input(user, "Add writing, doesn't replace current text", "Writing on [T]")  as text|null
				if(!writting)
					return

				if(!(user==T))
					src.visible_message("<span class='notice'>[user] begins to write on [T]'s [BP:name].</span>")
				else
					to_chat(user, "<span class='notice'>You begin to write on your [BP:name].</span>")

				if(do_mob(user, T, 4 SECONDS))
					if((length(BP:writtentext))+(length(writting)) < 100) //100 character limmit to stop spamming.
						BP:writtentext += html_encode(writting) //you can add to text, not remove it.
					else
						to_chat(user, "<span class='notice'>There isnt enough space to write that on [T]'s [BP:name].</span>")
						return

				if(!(user==T))
					to_chat(user, "<span class='notice'>You write on [T]'s [BP:name].</span>")
				else
					to_chat(user, "<span class='notice'>You write on your [BP:name].</span>")
	else
		. = ..()
