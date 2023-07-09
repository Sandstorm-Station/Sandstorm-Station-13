/datum/element/flavor_text/Attach(datum/target, text = "", _name = "Flavor Text", _addendum, _max_len = MAX_FLAVOR_LEN, _always_show = FALSE, _edit = TRUE, _save_key, _examine_no_preview = FALSE, _show_on_naked)
	. = ..()

	if(. == ELEMENT_INCOMPATIBLE || !isatom(target)) //no reason why this shouldn't work on atoms too.
		return ELEMENT_INCOMPATIBLE

	if(_max_len)
		max_len = _max_len
	texts_by_atom[target] = copytext(text, 1, max_len)
	if(_name)
		flavor_name = _name
	if(!isnull(addendum))
		addendum = _addendum
	show_on_naked = _show_on_naked
	always_show = _always_show
	if(flavor_name == "OOC Notes")
		always_show = TRUE
	can_edit = _edit
	save_key = _save_key
	examine_no_preview = _examine_no_preview

	RegisterSignal(target, COMSIG_PARENT_EXAMINE, .proc/show_flavor)

	if(can_edit && ismob(target)) //but only mobs receive the proc/verb for the time being
		var/mob/M = target
		LAZYOR(GLOB.mobs_with_editable_flavor_text[M], src)
		add_verb(M, /mob/proc/manage_flavor_tests)

	if(save_key && ishuman(target))
		RegisterSignal(target, COMSIG_HUMAN_PREFS_COPIED_TO, .proc/update_prefs_flavor_text)
