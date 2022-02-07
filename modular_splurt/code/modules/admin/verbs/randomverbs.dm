/client/proc/breadify(atom/movable/target)
	var/obj/item/reagent_containers/food/snacks/store/bread/plain/funnyBread = new(get_turf(target))
	target.forceMove(funnyBread)

/client/proc/bookify(atom/movable/target)
	var/obj/item/reagent_containers/food/snacks/store/book/funnyBook = new(get_turf(target))
	target.forceMove(funnyBook)
	funnyBook.name = "Book of " + target.name
