GLOBAL_LIST_EMPTY_TYPED(unlocked_droppod_techs, /datum/tech/droppod)

/datum/tech/droppod
	name = "droppod tech"
	desc = "placeholder description"

	var/droppod_name = "tech"

	var/list/already_accessed = list()

/datum/tech/droppod/ui_static_data(mob/user)
	. = ..()
	.["desc"] += "\nRequires an RTO; deployed via droppod."

/datum/tech/droppod/on_unlock()
	. = ..()

	GLOB.unlocked_droppod_techs += src

	for(var/r in GLOB.radio_packs)
		var/atom/radio_pack = r
		playsound(get_turf(radio_pack), 'sound/items/bikehorn.ogg', 75, sound_range = 5)
	return

// Called as to whether on_pod_access should be called
/datum/tech/droppod/proc/can_access(var/mob/living/carbon/human/H, var/obj/structure/droppod/D)
	if(H in already_accessed)
		to_chat(H, SPAN_WARNING("You've already accessed this tech!"))
		return FALSE

	return TRUE

// Called when attack_hand() on a pod, and can_access check has passed
/datum/tech/droppod/proc/on_pod_access(var/mob/living/carbon/human/H, var/obj/structure/droppod/D)
	already_accessed += H
	return

/datum/tech/droppod/proc/on_pod_created(var/obj/structure/droppod/D)
	return
