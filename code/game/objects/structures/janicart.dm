<<<<<<< HEAD
GLOBAL_LIST_BOILERPLATE(all_janitorial_carts, /obj/structure/janitorialcart)

/obj/structure/janitorialcart
	name = "janitorial cart"
	desc = "The ultimate in janitorial carts! Has space for water, mops, signs, trash bags, and more!"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "cart"
	anchored = 0
	density = 1
	climbable = 1
	flags = OPENCONTAINER
	//copypaste sorry
	var/amount_per_transfer_from_this = 5 //shit I dunno, adding this so syringes stop runtime erroring. --NeoFite
	var/obj/item/weapon/storage/bag/trash/mybag	= null
	var/obj/item/weapon/mop/mymop = null
	var/obj/item/weapon/reagent_containers/spray/myspray = null
	var/obj/item/device/lightreplacer/myreplacer = null
	var/signs = 0	//maximum capacity hardcoded below


/obj/structure/janitorialcart/New()
	create_reagents(300)
	..()


/obj/structure/janitorialcart/examine(mob/user)
	if(..(user, 1))
		user << "[src] \icon[src] contains [reagents.total_volume] unit\s of liquid!"
	//everything else is visible, so doesn't need to be mentioned


/obj/structure/janitorialcart/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/storage/bag/trash) && !mybag)
		user.drop_item()
		mybag = I
		I.loc = src
		update_icon()
		updateUsrDialog()
		user << "<span class='notice'>You put [I] into [src].</span>"

	else if(istype(I, /obj/item/weapon/mop))
		if(I.reagents.total_volume < I.reagents.maximum_volume)	//if it's not completely soaked we assume they want to wet it, otherwise store it
			if(reagents.total_volume < 1)
				user << "<span class='warning'>[src] is out of water!</span>"
			else
				reagents.trans_to_obj(I, 5)	//
				user << "<span class='notice'>You wet [I] in [src].</span>"
				playsound(loc, 'sound/effects/slosh.ogg', 25, 1)
				return
		if(!mymop)
			user.drop_item()
			mymop = I
			I.loc = src
			update_icon()
			updateUsrDialog()
			user << "<span class='notice'>You put [I] into [src].</span>"

	else if(istype(I, /obj/item/weapon/reagent_containers/spray) && !myspray)
		user.drop_item()
		myspray = I
		I.loc = src
		update_icon()
		updateUsrDialog()
		user << "<span class='notice'>You put [I] into [src].</span>"

	else if(istype(I, /obj/item/device/lightreplacer) && !myreplacer)
		user.drop_item()
		myreplacer = I
		I.loc = src
		update_icon()
		updateUsrDialog()
		user << "<span class='notice'>You put [I] into [src].</span>"

	else if(istype(I, /obj/item/weapon/caution))
		if(signs < 4)
			user.drop_item()
			I.loc = src
			signs++
			update_icon()
			updateUsrDialog()
			user << "<span class='notice'>You put [I] into [src].</span>"
		else
			user << "<span class='notice'>[src] can't hold any more signs.</span>"

	else if(istype(I, /obj/item/weapon/reagent_containers/glass))
		return // So we do not put them in the trash bag as we mean to fill the mop bucket

	else if(mybag)
		mybag.attackby(I, user)


/obj/structure/janitorialcart/attack_hand(mob/user)
	ui_interact(user)
	return

/obj/structure/janitorialcart/ui_interact(var/mob/user, var/ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	var/data[0]
	data["name"] = capitalize(name)
	data["bag"] = mybag ? capitalize(mybag.name) : null
	data["mop"] = mymop ? capitalize(mymop.name) : null
	data["spray"] = myspray ? capitalize(myspray.name) : null
	data["replacer"] = myreplacer ? capitalize(myreplacer.name) : null
	data["signs"] = signs ? "[signs] sign\s" : null

	ui = GLOB.nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "janitorcart.tmpl", "Janitorial cart", 240, 160)
		ui.set_initial_data(data)
		ui.open()

/obj/structure/janitorialcart/Topic(href, href_list)
	if(!in_range(src, usr))
		return
	if(!isliving(usr))
		return
	var/mob/living/user = usr

	if(href_list["take"])
		switch(href_list["take"])
			if("garbage")
				if(mybag)
					user.put_in_hands(mybag)
					user << "<span class='notice'>You take [mybag] from [src].</span>"
					mybag = null
			if("mop")
				if(mymop)
					user.put_in_hands(mymop)
					user << "<span class='notice'>You take [mymop] from [src].</span>"
					mymop = null
			if("spray")
				if(myspray)
					user.put_in_hands(myspray)
					user << "<span class='notice'>You take [myspray] from [src].</span>"
					myspray = null
			if("replacer")
				if(myreplacer)
					user.put_in_hands(myreplacer)
					user << "<span class='notice'>You take [myreplacer] from [src].</span>"
					myreplacer = null
			if("sign")
				if(signs)
					var/obj/item/weapon/caution/Sign = locate() in src
					if(Sign)
						user.put_in_hands(Sign)
						user << "<span class='notice'>You take \a [Sign] from [src].</span>"
						signs--
					else
						warning("[src] signs ([signs]) didn't match contents")
						signs = 0

	update_icon()
	updateUsrDialog()


/obj/structure/janitorialcart/update_icon()
	overlays = null
	if(mybag)
		overlays += "cart_garbage"
	if(mymop)
		overlays += "cart_mop"
	if(myspray)
		overlays += "cart_spray"
	if(myreplacer)
		overlays += "cart_replacer"
	if(signs)
		overlays += "cart_sign[signs]"


//old style retardo-cart
/obj/structure/bed/chair/janicart
	name = "janicart"
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "pussywagon"
	anchored = 1
	density = 1
	flags = OPENCONTAINER
	//copypaste sorry
	var/amount_per_transfer_from_this = 5 //shit I dunno, adding this so syringes stop runtime erroring. --NeoFite
	var/obj/item/weapon/storage/bag/trash/mybag	= null
	var/callme = "pimpin' ride"	//how do people refer to it?


/obj/structure/bed/chair/janicart/New()
	create_reagents(300)
	update_layer()


/obj/structure/bed/chair/janicart/examine(mob/user)
	if(!..(user, 1))
		return

	user << "\icon[src] This [callme] contains [reagents.total_volume] unit\s of water!"
	if(mybag)
		user << "\A [mybag] is hanging on the [callme]."


/obj/structure/bed/chair/janicart/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/mop))
		if(reagents.total_volume > 1)
			reagents.trans_to_obj(I, 2)
			user << "<span class='notice'>You wet [I] in the [callme].</span>"
			playsound(loc, 'sound/effects/slosh.ogg', 25, 1)
		else
			user << "<span class='notice'>This [callme] is out of water!</span>"
	else if(istype(I, /obj/item/key))
		user << "Hold [I] in one of your hands while you drive this [callme]."
	else if(istype(I, /obj/item/weapon/storage/bag/trash))
		user << "<span class='notice'>You hook the trashbag onto the [callme].</span>"
		user.drop_item()
		I.loc = src
		mybag = I


/obj/structure/bed/chair/janicart/attack_hand(mob/user)
	if(mybag)
		mybag.loc = get_turf(user)
		user.put_in_hands(mybag)
		mybag = null
	else
		..()


/obj/structure/bed/chair/janicart/relaymove(mob/living/user, direction)
	if(user.stat || user.stunned || user.weakened || user.paralysis)
		unbuckle_mob()
	if(user.get_type_in_hands(/obj/item/key))
		step(src, direction)
		update_mob()
	else
		user << "<span class='notice'>You'll need the keys in one of your hands to drive this [callme].</span>"


/obj/structure/bed/chair/janicart/Move()
	..()
	if(has_buckled_mobs())
		for(var/A in buckled_mobs)
			var/mob/living/L = A
			if(L.buckled == src)
				L.loc = loc


/obj/structure/bed/chair/janicart/post_buckle_mob(mob/living/M)
	update_mob()
	return ..()


/obj/structure/bed/chair/janicart/update_layer()
	if(dir == SOUTH)
		layer = FLY_LAYER
	else
		layer = OBJ_LAYER


/obj/structure/bed/chair/janicart/unbuckle_mob()
	var/mob/living/M = ..()
	if(M)
		M.pixel_x = 0
		M.pixel_y = 0
	return M


/obj/structure/bed/chair/janicart/set_dir()
	..()
	update_layer()
	if(has_buckled_mobs())
		for(var/A in buckled_mobs)
			var/mob/living/L = A
			if(L.loc != loc)
				L.buckled = null //Temporary, so Move() succeeds.
				L.buckled = src //Restoring

	update_mob()


/obj/structure/bed/chair/janicart/proc/update_mob()
	if(has_buckled_mobs())
		for(var/A in buckled_mobs)
			var/mob/living/L = A
			L.set_dir(dir)
			switch(dir)
				if(SOUTH)
					L.pixel_x = 0
					L.pixel_y = 7
				if(WEST)
					L.pixel_x = 13
					L.pixel_y = 7
				if(NORTH)
					L.pixel_x = 0
					L.pixel_y = 4
				if(EAST)
					L.pixel_x = -13
					L.pixel_y = 7


/obj/structure/bed/chair/janicart/bullet_act(var/obj/item/projectile/Proj)
	if(has_buckled_mobs())
		if(prob(85))
			var/mob/living/L = pick(buckled_mobs)
			return L.bullet_act(Proj)
	visible_message("<span class='warning'>[Proj] ricochets off the [callme]!</span>")


/obj/item/key
	name = "key"
	desc = "A keyring with a small steel key, and a pink fob reading \"Pussy Wagon\"."
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "keys"
	w_class = ITEMSIZE_TINY
=======
GLOBAL_LIST_BOILERPLATE(all_janitorial_carts, /obj/structure/janitorialcart)

/obj/structure/janitorialcart
	name = "janitorial cart"
	desc = "The ultimate in janitorial carts! Has space for water, mops, signs, trash bags, and more!"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "cart"
	anchored = 0
	density = 1
	climbable = 1
	flags = OPENCONTAINER
	//copypaste sorry
	var/amount_per_transfer_from_this = 5 //shit I dunno, adding this so syringes stop runtime erroring. --NeoFite
	var/obj/item/weapon/storage/bag/trash/mybag	= null
	var/obj/item/weapon/mop/mymop = null
	var/obj/item/weapon/reagent_containers/spray/myspray = null
	var/obj/item/device/lightreplacer/myreplacer = null
	var/signs = 0	//maximum capacity hardcoded below


/obj/structure/janitorialcart/New()
	create_reagents(300)
	..()


/obj/structure/janitorialcart/examine(mob/user)
	if(..(user, 1))
		user << "[src] \icon[src] contains [reagents.total_volume] unit\s of liquid!"
	//everything else is visible, so doesn't need to be mentioned


/obj/structure/janitorialcart/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/storage/bag/trash) && !mybag)
		user.drop_item()
		mybag = I
		I.loc = src
		update_icon()
		updateUsrDialog()
		user << "<span class='notice'>You put [I] into [src].</span>"

	else if(istype(I, /obj/item/weapon/mop))
		if(I.reagents.total_volume < I.reagents.maximum_volume)	//if it's not completely soaked we assume they want to wet it, otherwise store it
			if(reagents.total_volume < 1)
				user << "<span class='warning'>[src] is out of water!</span>"
			else
				reagents.trans_to_obj(I, 5)	//
				user << "<span class='notice'>You wet [I] in [src].</span>"
				playsound(loc, 'sound/effects/slosh.ogg', 25, 1)
				return
		if(!mymop)
			user.drop_item()
			mymop = I
			I.loc = src
			update_icon()
			updateUsrDialog()
			user << "<span class='notice'>You put [I] into [src].</span>"

	else if(istype(I, /obj/item/weapon/reagent_containers/spray) && !myspray)
		user.drop_item()
		myspray = I
		I.loc = src
		update_icon()
		updateUsrDialog()
		user << "<span class='notice'>You put [I] into [src].</span>"

	else if(istype(I, /obj/item/device/lightreplacer) && !myreplacer)
		user.drop_item()
		myreplacer = I
		I.loc = src
		update_icon()
		updateUsrDialog()
		user << "<span class='notice'>You put [I] into [src].</span>"

	else if(istype(I, /obj/item/weapon/caution))
		if(signs < 4)
			user.drop_item()
			I.loc = src
			signs++
			update_icon()
			updateUsrDialog()
			user << "<span class='notice'>You put [I] into [src].</span>"
		else
			user << "<span class='notice'>[src] can't hold any more signs.</span>"

	else if(istype(I, /obj/item/weapon/reagent_containers/glass))
		return // So we do not put them in the trash bag as we mean to fill the mop bucket

	else if(mybag)
		mybag.attackby(I, user)


/obj/structure/janitorialcart/attack_hand(mob/user)
	ui_interact(user)
	return

/obj/structure/janitorialcart/ui_interact(var/mob/user, var/ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	var/data[0]
	data["name"] = capitalize(name)
	data["bag"] = mybag ? capitalize(mybag.name) : null
	data["mop"] = mymop ? capitalize(mymop.name) : null
	data["spray"] = myspray ? capitalize(myspray.name) : null
	data["replacer"] = myreplacer ? capitalize(myreplacer.name) : null
	data["signs"] = signs ? "[signs] sign\s" : null

	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "janitorcart.tmpl", "Janitorial cart", 240, 160)
		ui.set_initial_data(data)
		ui.open()

/obj/structure/janitorialcart/Topic(href, href_list)
	if(!in_range(src, usr))
		return
	if(!isliving(usr))
		return
	var/mob/living/user = usr

	if(href_list["take"])
		switch(href_list["take"])
			if("garbage")
				if(mybag)
					user.put_in_hands(mybag)
					user << "<span class='notice'>You take [mybag] from [src].</span>"
					mybag = null
			if("mop")
				if(mymop)
					user.put_in_hands(mymop)
					user << "<span class='notice'>You take [mymop] from [src].</span>"
					mymop = null
			if("spray")
				if(myspray)
					user.put_in_hands(myspray)
					user << "<span class='notice'>You take [myspray] from [src].</span>"
					myspray = null
			if("replacer")
				if(myreplacer)
					user.put_in_hands(myreplacer)
					user << "<span class='notice'>You take [myreplacer] from [src].</span>"
					myreplacer = null
			if("sign")
				if(signs)
					var/obj/item/weapon/caution/Sign = locate() in src
					if(Sign)
						user.put_in_hands(Sign)
						user << "<span class='notice'>You take \a [Sign] from [src].</span>"
						signs--
					else
						warning("[src] signs ([signs]) didn't match contents")
						signs = 0

	update_icon()
	updateUsrDialog()


/obj/structure/janitorialcart/update_icon()
	overlays = null
	if(mybag)
		overlays += "cart_garbage"
	if(mymop)
		overlays += "cart_mop"
	if(myspray)
		overlays += "cart_spray"
	if(myreplacer)
		overlays += "cart_replacer"
	if(signs)
		overlays += "cart_sign[signs]"


//old style retardo-cart
/obj/structure/bed/chair/janicart
	name = "janicart"
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "pussywagon"
	anchored = 1
	density = 1
	flags = OPENCONTAINER
	//copypaste sorry
	var/amount_per_transfer_from_this = 5 //shit I dunno, adding this so syringes stop runtime erroring. --NeoFite
	var/obj/item/weapon/storage/bag/trash/mybag	= null
	var/callme = "pimpin' ride"	//how do people refer to it?


/obj/structure/bed/chair/janicart/New()
	create_reagents(300)
	update_layer()


/obj/structure/bed/chair/janicart/examine(mob/user)
	if(!..(user, 1))
		return

	user << "\icon[src] This [callme] contains [reagents.total_volume] unit\s of water!"
	if(mybag)
		user << "\A [mybag] is hanging on the [callme]."


/obj/structure/bed/chair/janicart/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/mop))
		if(reagents.total_volume > 1)
			reagents.trans_to_obj(I, 2)
			user << "<span class='notice'>You wet [I] in the [callme].</span>"
			playsound(loc, 'sound/effects/slosh.ogg', 25, 1)
		else
			user << "<span class='notice'>This [callme] is out of water!</span>"
	else if(istype(I, /obj/item/key))
		user << "Hold [I] in one of your hands while you drive this [callme]."
	else if(istype(I, /obj/item/weapon/storage/bag/trash))
		user << "<span class='notice'>You hook the trashbag onto the [callme].</span>"
		user.drop_item()
		I.loc = src
		mybag = I


/obj/structure/bed/chair/janicart/attack_hand(mob/user)
	if(mybag)
		mybag.loc = get_turf(user)
		user.put_in_hands(mybag)
		mybag = null
	else
		..()


/obj/structure/bed/chair/janicart/relaymove(mob/living/user, direction)
	if(user.stat || user.stunned || user.weakened || user.paralysis)
		unbuckle_mob()
	if(user.get_type_in_hands(/obj/item/key))
		step(src, direction)
		update_mob()
	else
		user << "<span class='notice'>You'll need the keys in one of your hands to drive this [callme].</span>"


/obj/structure/bed/chair/janicart/Move()
	..()
	if(has_buckled_mobs())
		for(var/A in buckled_mobs)
			var/mob/living/L = A
			if(L.buckled == src)
				L.loc = loc


/obj/structure/bed/chair/janicart/post_buckle_mob(mob/living/M)
	update_mob()
	return ..()


/obj/structure/bed/chair/janicart/update_layer()
	if(dir == SOUTH)
		layer = FLY_LAYER
	else
		layer = OBJ_LAYER


/obj/structure/bed/chair/janicart/unbuckle_mob()
	var/mob/living/M = ..()
	if(M)
		M.pixel_x = 0
		M.pixel_y = 0
	return M


/obj/structure/bed/chair/janicart/set_dir()
	..()
	update_layer()
	if(has_buckled_mobs())
		for(var/A in buckled_mobs)
			var/mob/living/L = A
			if(L.loc != loc)
				L.buckled = null //Temporary, so Move() succeeds.
				L.buckled = src //Restoring

	update_mob()


/obj/structure/bed/chair/janicart/proc/update_mob()
	if(has_buckled_mobs())
		for(var/A in buckled_mobs)
			var/mob/living/L = A
			L.set_dir(dir)
			switch(dir)
				if(SOUTH)
					L.pixel_x = 0
					L.pixel_y = 7
				if(WEST)
					L.pixel_x = 13
					L.pixel_y = 7
				if(NORTH)
					L.pixel_x = 0
					L.pixel_y = 4
				if(EAST)
					L.pixel_x = -13
					L.pixel_y = 7


/obj/structure/bed/chair/janicart/bullet_act(var/obj/item/projectile/Proj)
	if(has_buckled_mobs())
		if(prob(85))
			var/mob/living/L = pick(buckled_mobs)
			return L.bullet_act(Proj)
	visible_message("<span class='warning'>[Proj] ricochets off the [callme]!</span>")


/obj/item/key
	name = "key"
	desc = "A keyring with a small steel key, and a pink fob reading \"Pussy Wagon\"."
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "keys"
	w_class = ITEMSIZE_TINY
>>>>>>> 8b08e45... Merge pull request #4838 from VOREStation/master
