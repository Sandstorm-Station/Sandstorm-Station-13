// For borg integrated tablets. No downloader.
/obj/item/computer_hardware/hard_drive/small/integrated/install_default_programs()
	store_file(new /datum/computer_file/program/computerconfig(src)) 	// Computer configuration utility, allows hardware control and displays more info than status bar
	store_file(new /datum/computer_file/program/filemanager(src))		// File manager, allows text editor functions and basic file manipulation.
	store_file(new /datum/computer_file/program/robotact(src))
