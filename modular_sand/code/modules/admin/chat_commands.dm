//Idk why cit never added this
/datum/tgs_chat_command/revokebunkerbypass
	name = "unwhitelist"
	help_text = "unwhitelist <ckey>"
	admin_only = TRUE

/datum/tgs_chat_command/revokebunkerbypass/Run(datum/tgs_chat_user/sender, params)
	if(!CONFIG_GET(flag/sql_enabled))
		return "The Database is not enabled!"

	GLOB.bunker_passthrough -= ckey(params)
	SSpersistence.SavePanicBunker()
	log_admin("[sender.friendly_name] has removed [params] from the current round's bunker bypass list.")
	message_admins("[sender.friendly_name] has removed [params] from the current round's bunker bypass list.")
	return "[params] has been removed from the current round's bunker bypass list."

