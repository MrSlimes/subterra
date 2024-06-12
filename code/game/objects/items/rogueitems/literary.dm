
/obj/item/literary
	name = "novice's guide to literature"
	desc = "A book featuring an alphabet, sentences of varying complexity, and common symbols that, altogether, allow the user to train their reading skills up to a point. The more advanced the guide, the higher the limit and the more literate you must be to study it.."
	icon = 'icons/roguetown/items/books.dmi'
	icon_state = "book_1"
	var/exppercycle = 5
	var/minexp = 0
	var/maxexp = 101
	var/skilltoteach = /datum/skill/misc/reading

/obj/item/literary/apprentice
	name = "apprentice's guide to literature"
	icon_state = "book2_1"
	minexp = 100
	maxexp = 251
	exppercycle = 13

/obj/item/literary/journeyman
	name = "journeyman's guide to literature"
	icon_state = "book3_1"
	minexp = 250
	maxexp = 501
	exppercycle = 25

/obj/item/literary/expert
	name = "expert's guide to literature"
	icon_state = "book4_1"
	minexp = 500
	maxexp = 901
	exppercycle = 45

/obj/item/literary/master
	name = "master's guide to literature"
	icon_state = "book5_1"
	minexp = 900
	maxexp = 1501
	exppercycle = 75

/obj/item/literary/attack_self(mob/user)
	. = ..()
	attemptlearn(user)

/obj/item/literary/proc/attemptlearn(mob/user)
	if(user.mind && ishuman(user))
		var/mob/living/carbon/human/H = user
		var/userskill = H.mind.get_skill_level(skilltoteach)
		var/intbonus = H.STAINT - 10
		if(userskill < minexp)
			to_chat(user, "<span class='warning'>This guide is too advanced for me to study!</span>")
			return
		if(userskill < maxexp)
			to_chat(user, "You begin to study the [src.name]!")
			if(do_after(H, 5 SECONDS))
				user.mind.adjust_experience(skilltoteach, exppercycle + intbonus)
				attemptlearn(user)
		else
			to_chat(user, "<span class='warning'>This guide is too simple for me to learn any more from!</span>")
			return
