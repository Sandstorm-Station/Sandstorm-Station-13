/datum/tgs_chat_command/tidi
	name = "tidi"
	help_text = "Current station Time Dilation"
	admin_only = FALSE

/datum/tgs_chat_command/tidi/Run(datum/tgs_chat_user/sender, params)
	return "Time Dilation: [round(SStime_track.time_dilation_current,1)]% AVG:([round(SStime_track.time_dilation_avg_fast,1)]%, [round(SStime_track.time_dilation_avg,1)]%, [round(SStime_track.time_dilation_avg_slow,1)]%)"

/datum/tgs_chat_command/splashsauce
	name = "splashsauce"
	help_text = "Sauce of the current splashscreen"

/datum/tgs_chat_command/splashsauce/Run(datum/tgs_chat_user/sender, params)
	//Check if the sauce system is turned on
	if(!CONFIG_GET(flag/sauce_command_enabled))
		return "This command is not enabled!"

	//Get the current splashscreen
	var/list/raw_path = splittext(SStitle.file_path, "/")
	var/current_splashscreen = raw_path[raw_path.len]

	//Get the info of all splashscreens
	var/list/splashinfo = safe_json_decode(rustg_file_read("[global.config.directory]/splurt/title_screens_sources.json"))

	//Find the info of the current splashscreen
	if(!splashinfo.Find(current_splashscreen))
		return "The current splashscreen has no info set up yet!"
	return "*[splashinfo[current_splashscreen]["name"]] by* **[splashinfo[current_splashscreen]["author"]]**\n[splashinfo[current_splashscreen]["link"]]"

/datum/tgs_chat_command/allsplashscreens
	name = "allsplashscreens"
	help_text = "All info for all splashscreens currently in the server"

/datum/tgs_chat_command/allsplashscreens/Run(datum/tgs_chat_user/sender, params)
	//Check if the sauce system is turned on
	if(!CONFIG_GET(flag/sauce_command_enabled))
		return "This command is not enabled!"

	//Get the info of all splashscreens
	var/list/splashinfo = safe_json_decode(rustg_file_read("[global.config.directory]/splurt/title_screens_sources.json"))
	if(!splashinfo.len)
		return "There are no splashscreens set up yet!"

	//Organize the splashscreen info
	var/list/data = list()
	for(var/pic in splashinfo)
		var/list/info = splashinfo[pic]
		var/text = "- [info.Join(" - ")]"
		LAZYADD(data, text)
	return "Currently active splashscreens: ```yaml\n[data.Join("\n")]```"
