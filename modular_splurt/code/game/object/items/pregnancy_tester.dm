/obj/item/pregnancytest
	name = "pregnancy test"
	desc = "A one time use small device, used to determine whether someone is pregnant or not."
	icon = 'modular_splurt/icons/obj/pregnancytest.dmi'
	throwforce= 0
	icon_state = "ptest"
	custom_price = PRICE_REALLY_CHEAP
	var/results
	w_class = WEIGHT_CLASS_TINY

/obj/item/pregnancytest/attack_self(mob/user)
	if(QDELETED(src))
		return
	if(!isliving(user))
		return
	if(user.stat > CONSCIOUS)//unconscious or dead
		return
	if(results)
		to_chat(user, span_warning("The display reads [results], you can't use this tester anymore!"))
		return

	test(user)

/obj/item/pregnancytest/proc/test(mob/living/user)
	if(user.GetComponent(/datum/component/pregnancy))
		results = "positive"
	else
		results = "negative"

	icon_state = results
	name = "[results] pregnancy test"

	update_appearance()

	if(user)
		to_chat(user, span_notice("You use the pregnancy test, the display reads [results]!"))
