<<<<<<< HEAD
/obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector
	name = "empty hypo"
	desc = "A refined version of the standard autoinjector, allowing greater capacity."
	icon_state = "autoinjector"
	amount_per_transfer_from_this = 15
	volume = 15
	origin_tech = list(TECH_BIO = 4)
	filled_reagents = list("inaprovaline" = 15)

/obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/initialize()
	..()


=======
>>>>>>> 8b08e45... Merge pull request #4838 from VOREStation/master
/datum/technomancer/consumable/hypo_brute
	name = "Trauma Hypo"
	desc = "A extended capacity hypo which can treat blunt trauma."
	cost = 25
	obj_path = /obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/brute

/datum/technomancer/consumable/hypo_burn
	name = "Burn Hypo"
	desc = "A extended capacity hypo which can treat severe burns."
	cost = 25
	obj_path = /obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/burn

/datum/technomancer/consumable/hypo_tox
	name = "Toxin Hypo"
	desc = "A extended capacity hypo which can treat various toxins."
	cost = 25
	obj_path = /obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/toxin

/datum/technomancer/consumable/hypo_oxy
	name = "Oxy Hypo"
	desc = "A extended capacity hypo which can treat oxygen deprivation."
	cost = 25
	obj_path = /obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/oxy

/datum/technomancer/consumable/hypo_purity
	name = "Purity Hypo"
	desc = "A extended capacity hypo which can remove various inpurities in the system such as viruses, infections, \
	radiation, and genetic problems."
	cost = 25
	obj_path = /obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/purity

/datum/technomancer/consumable/hypo_pain
	name = "Pain Hypo"
	desc = "A extended capacity hypo which contains potent painkillers."
	cost = 25
	obj_path = /obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/pain

/datum/technomancer/consumable/hypo_organ
	name = "Organ Hypo"
	desc = "A extended capacity hypo which is designed to fix internal organ problems."
	cost = 50
	obj_path = /obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/organ

/datum/technomancer/consumable/hypo_combat
	name = "Combat Hypo"
	desc = "A extended capacity hypo containing a dangerous cocktail of various combat stims."
	cost = 75
	obj_path = /obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/combat
