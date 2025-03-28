GLOBAL_LIST_EMPTY(admin_ranks)								//list of all admin_rank datums
GLOBAL_PROTECT(admin_ranks)

GLOBAL_LIST_EMPTY(protected_ranks)								//admin ranks loaded from txt
GLOBAL_PROTECT(protected_ranks)

/datum/admin_rank
	var/name = "NoRank"
	var/rights = R_DEFAULT
	var/exclude_rights = 0
	var/include_rights = 0
	var/can_edit_rights = 0

/datum/admin_rank/New(init_name, init_rights, init_exclude_rights, init_edit_rights)
	if(IsAdminAdvancedProcCall())
		alert_to_permissions_elevation_attempt(usr)
		if (name == "NoRank") //only del if this is a true creation (and not just a New() proc call), other wise trialmins/coders could abuse this to deadmin other admins
			QDEL_IN(src, 0)
			CRASH("Admin proc call creation of admin datum")
		return
	name = init_name
	if(!name)
		qdel(src)
		CRASH("Admin rank created without name.")
	if(init_rights)
		rights = init_rights
	include_rights = rights
	if(init_exclude_rights)
		exclude_rights = init_exclude_rights
		rights &= ~exclude_rights
	if(init_edit_rights)
		can_edit_rights = init_edit_rights

/datum/admin_rank/Destroy()
	if(IsAdminAdvancedProcCall())
		alert_to_permissions_elevation_attempt(usr)
		return QDEL_HINT_LETMELIVE
	. = ..()

/datum/admin_rank/vv_edit_var(var_name, var_value)
	return FALSE

/datum/admin_rank/CanProcCall(procname)
	. = ..()
	if(!check_rights(R_SENSITIVE))
		return FALSE

/proc/admin_keyword_to_flag(word, previous_rights=0)
	var/flag = 0
	switch(ckey(word))
		if("buildmode","build")
			flag = R_BUILDMODE
		if("admin")
			flag = R_ADMIN
		if("ban")
			flag = R_BAN
		if("fun")
			flag = R_FUN
		if("server")
			flag = R_SERVER
		if("debug")
			flag = R_DEBUG
		if("permissions","rights")
			flag = R_PERMISSIONS
		if("possess")
			flag = R_POSSESS
		if("stealth")
			flag = R_STEALTH
		if("poll")
			flag = R_POLL
		if("varedit")
			flag = R_VAREDIT
		if("everything","host","all")
			flag = R_EVERYTHING
		if("sound","sounds")
			flag = R_SOUNDS
		if("spawn","create")
			flag = R_SPAWN
		if("autologin", "autoadmin")
			flag = R_AUTOLOGIN
		if("dbranks")
			flag = R_DBRANKS
		if("sensitive")
			flag = R_SENSITIVE
		if("@","prev")
			flag = previous_rights
	return flag

// Adds/removes rights to this admin_rank
/datum/admin_rank/proc/process_keyword(word, previous_rights=0)
	if(IsAdminAdvancedProcCall())
		alert_to_permissions_elevation_attempt(usr)
		return
	var/flag = admin_keyword_to_flag(word, previous_rights)
	if(flag)
		switch(text2ascii(word,1))
			if(43)
				rights |= flag	//+
				include_rights	|= flag
			if(45)
				rights &= ~flag	//-
				exclude_rights	|= flag
			if(42)
				can_edit_rights |= flag	//*

// Checks for (keyword-formatted) rights on this admin
/datum/admins/proc/check_keyword(word)
	var/flag = admin_keyword_to_flag(word)
	if(flag)
		return ((rank.rights & flag) == flag) //true only if right has everything in flag

/proc/sync_ranks_with_db()
	set waitfor = FALSE

	if(IsAdminAdvancedProcCall())
		to_chat(usr, "<span class='admin prefix'>Admin rank DB Sync blocked: Advanced ProcCall detected.</span>", confidential = TRUE)
		return

	var/list/sql_ranks = list()
	for(var/datum/admin_rank/R in GLOB.protected_ranks)
		sql_ranks += list(list("rank" = R.name, "flags" = R.include_rights, "exclude_flags" = R.exclude_rights, "can_edit_flags" = R.can_edit_rights))
	SSdbcore.MassInsert(format_table_name("admin_ranks"), sql_ranks, duplicate_key = TRUE)

//load our rank - > rights associations
/proc/load_admin_ranks(dbfail, no_update)
	if(IsAdminAdvancedProcCall())
		to_chat(usr, "<span class='admin prefix'>Admin Reload blocked: Advanced ProcCall detected.</span>")
		return
	GLOB.admin_ranks.Cut()
	GLOB.protected_ranks.Cut()
	var/previous_rights = 0
	//load text from file and process each line separately
	for(var/line in world.file2list("[global.config.directory]/admin_ranks.txt"))
		if(!line || findtextEx_char(line,"#",1,2))
			continue
		var/next = findtext(line, "=")
		var/datum/admin_rank/R = new(ckeyEx(copytext(line, 1, next)))
		if(!R)
			continue
		GLOB.admin_ranks += R
		GLOB.protected_ranks += R
		var/prev = findchar(line, "+-*", next, 0)
		while(prev)
			next = findchar(line, "+-*", prev + length(line[prev]), 0)
			R.process_keyword(copytext(line, prev, next), previous_rights)
			prev = next
		previous_rights = R.rights
	if(!CONFIG_GET(flag/admin_legacy_system) || dbfail)
		if(CONFIG_GET(flag/load_legacy_ranks_only))
			if(!no_update)
				sync_ranks_with_db()
		else
			var/datum/db_query/query_load_admin_ranks = SSdbcore.NewQuery("SELECT `rank`, flags, exclude_flags, can_edit_flags FROM [format_table_name("admin_ranks")]")
			if(!query_load_admin_ranks.Execute())
				message_admins("Error loading admin ranks from database. Loading from backup.")
				log_sql("Error loading admin ranks from database. Loading from backup.")
				dbfail = 1
			else
				while(query_load_admin_ranks.NextRow())
					var/skip
					var/rank_name = query_load_admin_ranks.item[1]
					for(var/datum/admin_rank/R in GLOB.admin_ranks)
						if(R.name == rank_name) //this rank was already loaded from txt override
							skip = 1
							break
					if(!skip)
						var/rank_flags = text2num(query_load_admin_ranks.item[2])
						var/rank_exclude_flags = text2num(query_load_admin_ranks.item[3])
						var/rank_can_edit_flags = text2num(query_load_admin_ranks.item[4])
						var/datum/admin_rank/R = new(rank_name, rank_flags, rank_exclude_flags, rank_can_edit_flags)
						if(!R)
							continue
						GLOB.admin_ranks += R
			qdel(query_load_admin_ranks)
	//load ranks from backup file
	if(dbfail)
		var/backup_file = file2text("data/admins_backup.json")
		if(backup_file == null)
			log_world("Unable to locate admins backup file.")
			return FALSE
		var/list/json = json_decode(backup_file)
		for(var/J in json["ranks"])
			var/skip
			for(var/datum/admin_rank/R in GLOB.admin_ranks)
				if(R.name == "[J]") //this rank was already loaded from txt override
					skip = TRUE
			if(skip)
				continue
			var/datum/admin_rank/R = new("[J]", json["ranks"]["[J]"]["include rights"], json["ranks"]["[J]"]["exclude rights"], json["ranks"]["[J]"]["can edit rights"])
			if(!R)
				continue
			GLOB.admin_ranks += R
		return json
	#ifdef TESTING
	var/msg = "Permission Sets Built:\n"
	for(var/datum/admin_rank/R in GLOB.admin_ranks)
		msg += "\t[R.name]"
		var/rights = rights2text(R.rights,"\n\t\t")
		if(rights)
			msg += "\t\t[rights]\n"
	testing(msg)
	#endif

/proc/load_admins(no_update)
	var/dbfail
	if(!CONFIG_GET(flag/admin_legacy_system) && !SSdbcore.Connect())
		message_admins("Failed to connect to database while loading admins. Loading from backup.")
		log_sql("Failed to connect to database while loading admins. Loading from backup.")
		dbfail = 1
	//clear the datums references
	GLOB.admin_datums.Cut()
	for(var/client/C in GLOB.admins)
		C.remove_admin_verbs()
		C.holder = null
	GLOB.admins.Cut()
	GLOB.protected_admins.Cut()
	GLOB.deadmins.Cut()
	var/list/backup_file_json = load_admin_ranks(dbfail, no_update)
	dbfail = backup_file_json != null
	//Clear profile access
	for(var/A in world.GetConfig("admin"))
		world.SetConfig("APP/admin", A, null)
	var/list/rank_names = list()
	for(var/datum/admin_rank/R in GLOB.admin_ranks)
		rank_names[R.name] = R
	//ckeys listed in admins.txt are always made admins before sql loading is attempted
	var/admins_text = file2text("[global.config.directory]/admins.txt")
	var/regex/admins_regex = new(@"^(?!#)(.+?)\s+=\s+(.+)", "gm")
	while(admins_regex.Find(admins_text))
		new /datum/admins(rank_names[admins_regex.group[2]], ckey(admins_regex.group[1]), FALSE, TRUE)
	if(!CONFIG_GET(flag/admin_legacy_system) || dbfail)
		var/datum/db_query/query_load_admins = SSdbcore.NewQuery("SELECT ckey, `rank` FROM [format_table_name("admin")] ORDER BY `rank`")
		if(!query_load_admins.Execute())
			message_admins("Error loading admins from database. Loading from backup.")
			log_sql("Error loading admins from database. Loading from backup.")
			dbfail = 1
		else
			while(query_load_admins.NextRow())
				var/admin_ckey = ckey(query_load_admins.item[1])
				var/admin_rank = query_load_admins.item[2]
				var/skip
				if(rank_names[admin_rank] == null)
					message_admins("[admin_ckey] loaded with invalid admin rank [admin_rank].")
					skip = 1
				if(GLOB.admin_datums[admin_ckey] || GLOB.deadmins[admin_ckey])
					skip = 1
				if(!skip)
					new /datum/admins(rank_names[admin_rank], admin_ckey)
		qdel(query_load_admins)
	//load admins from backup file
	if(dbfail)
		if(!backup_file_json)
			if(backup_file_json != null)
				//already tried
				return
			var/backup_file = file2text("data/admins_backup.json")
			if(backup_file == null)
				log_world("Unable to locate admins backup file.")
				return
			backup_file_json = json_decode(backup_file)
		for(var/J in backup_file_json["admins"])
			var/skip
			for(var/A in GLOB.admin_datums + GLOB.deadmins)
				if(A == "[J]") //this admin was already loaded from txt override
					skip = TRUE
			if(skip)
				continue
			new /datum/admins(rank_names[ckeyEx(backup_file_json["admins"]["[J]"])], ckey("[J]"))
	#ifdef TESTING
	var/msg = "Admins Built:\n"
	for(var/ckey in GLOB.admin_datums)
		var/datum/admins/D = GLOB.admin_datums[ckey]
		msg += "\t[ckey] - [D.rank.name]\n"
	testing(msg)
	#endif
	return dbfail

#ifdef TESTING
/client/verb/changerank(newrank in GLOB.admin_ranks)
	if(holder)
		holder.rank = newrank
	else
		holder = new /datum/admins(newrank, ckey)
	remove_admin_verbs()
	holder.associate(src)

/client/verb/changerights(newrights as num)
	if(holder)
		holder.rank.rights = newrights
	else
		holder = new /datum/admins("testing", newrights, ckey)
	remove_admin_verbs()
	holder.associate(src)
#endif
