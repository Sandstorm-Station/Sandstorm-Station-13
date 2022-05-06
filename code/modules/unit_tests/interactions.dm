/datum/unit_test/interactions/Run()
	SSinteractions = new()
	SSinteractions.prepare_interactions()
	if(!SSinteractions.interactions || !length(SSinteractions.interactions))
		Fail("make_interactions() was called but SSinteractions.interactions is empty.")
	return
