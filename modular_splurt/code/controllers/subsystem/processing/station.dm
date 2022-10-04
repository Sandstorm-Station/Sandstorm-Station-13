/datum/controller/subsystem/processing/station/SetupTraits()
	if(fexists(FUTURE_STATION_TRAITS_FILE)) //Station traits were previously configured
		return ..()

	if(!CONFIG_GET(flag/weighted_station_traits)) //Weighted station traits are deactivated
		return

	. = ..()
