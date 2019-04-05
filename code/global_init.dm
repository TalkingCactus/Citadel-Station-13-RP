<<<<<<< HEAD
=======
/*
	The initialization of the game happens roughly like this:

	1. All global variables are initialized (including the global_init instance).
	2. The map is initialized, and map objects are created.
	3. world/New() runs, creating the process scheduler (and the old master controller) and spawning their setup.
	4. processScheduler/setup() runs, creating all the processes. game_controller/setup() runs, calling initialize() on all movable atoms in the world.
	5. The gameticker is created.

*/
>>>>>>> 8b08e45... Merge pull request #4838 from VOREStation/master
var/global/datum/global_init/init = new ()

/*
	Pre-map initialization stuff should go here.
*/
/datum/global_init/New()
<<<<<<< HEAD
	log_world("global init datum started")
=======
>>>>>>> 8b08e45... Merge pull request #4838 from VOREStation/master

	makeDatumRefLists()
	load_configuration()

<<<<<<< HEAD
	initialize_chemical_reagents()
	initialize_chemical_reactions()
	initialize_integrated_circuits_list()
	log_world("global init datum finished")
=======
	initialize_integrated_circuits_list()

>>>>>>> 8b08e45... Merge pull request #4838 from VOREStation/master
	qdel(src) //we're done

/datum/global_init/Destroy()
	global.init = null
	return 2 // QDEL_HINT_IWILLGC
<<<<<<< HEAD

/proc/load_configuration()
	config = new /datum/configuration()
	config.load("config/config.txt")
	config.load("config/game_options.txt","game_options")
	config.loadsql("config/dbconfig.txt")
	config.loadforumsql("config/forumdbconfig.txt")
=======
>>>>>>> 8b08e45... Merge pull request #4838 from VOREStation/master
