/datum/asset/simple/namespaced/fonts
	parents = list("fonts.css" = 'interface/fonts/fonts.css')

/datum/asset/simple/namespaced/fonts/New()
	for(var/datum/font/font as anything in subtypesof(/datum/font))
		var/file = "[initial(font.font_family)]"
		var/file_name = copytext(file, findlasttext(file, "/") + 1)
		assets[file_name] = file
	return ..()
