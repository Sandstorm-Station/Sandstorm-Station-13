/proc/_isclown(mob/honker)
	var/datum/job/clowncheck = SSjob.GetJob(honker.job)
	return istype(clowncheck, /datum/job/clown)
