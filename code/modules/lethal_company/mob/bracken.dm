/mob/living/simple_animal/hostile/bracken
	name = "bracken"
	desc = "Walking plantperson that will snap your neck."
	icon = 'bracken.dmi'
	icon_state = "bracken"
	icon_dead = "bracken_dead"

	environment_smash = ENVIRONMENT_SMASH_NONE
	search_objects = 1

	dodge_prob = 40
	health = 400
	maxHealth = 400

	dextrous = TRUE
	AIStatus = AI_OFF
	can_have_ai = FALSE
	flip_on_death = TRUE

	var/datum/action/innate/bracken_snap/bracksnap

/mob/living/simple_animal/hostile/bracken/Initialize()
	. = ..()
	bracksnap.Grant(src)


/datum/action/innate/bracken_snap
	name = "Neck Snap"
	desc = "Turn people into vegetables"
	icon_icon = 'bracken.dmi'
	button_icon_state = "snap"

/datum/action/innate/bracken_snap/Trigger(var/mob/living/carbon/victim)
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>You can't snap necks while you're incapacitated.</span>")
		return
	if(owner.pulling != victim)
		to_chat(owner, "<span class='warning'>You're not pulling your victim!</span>")
		return

	bracken_snap(owner, victim)

/datum/proc/bracken_snap(mob/living/A, mob/living/carbon/human/D)
	D.visible_message("<span class='warning'>[A] snaps [D]'s neck!</span>", "<span class='userdanger'>Your neck is snap by [A], rendering you a vegetable!</span>", "<span class='hear'>You hear a sickening sound of a snapping spine.</span>", COMBAT_MESSAGE_RANGE, A)
	to_chat(A, "<span class='danger'>You snap [D]'s neck, rendering [D.p_them()] a vegetable!</span>")
	playsound(get_turf(A), 'necksnap.ogg', 50, TRUE, -1)
	D.apply_damage(150, BRUTE, BODY_ZONE_HEAD)
	D.Paralyze(300)
	log_combat(A, D, "neck snapped")
	return 1
