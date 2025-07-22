extends Node2D

@onready var sprite = $sprite
@onready var speech = $speech
@onready var meow_sfx = $meow_sfx

var welcome_talk: Array[String]
var funfacts_array : Array[String]

var is_overlapping : bool = false
var string_index = 0
var amount_of_chat = 0

func _ready():
	sprite.play("idle")
	
	#Yikes this is very PirateSoftware-esc huh... maybe I should refactor this later... XD
	welcome_talk.append("Hi! Welcome to 'The In-Between Interaction Area' or T.I.B.I.A for short!")
	welcome_talk.append("It seems like you kinda messed up your reality by smashing atoms together...")
	welcome_talk.append("But don't fear! Blu is here to help!")
	welcome_talk.append("I rescued you from being turned into speghetti and...")
	welcome_talk.append("Anyways...")
	welcome_talk.append("In the TIBIA you can buy upgrades with your ATOMIC MASS!")
	welcome_talk.append("You can gather ATOMIC MASS by picking up isotopes when you go back out.")
	welcome_talk.append("So what are you waiting for?! Buy something and get running!")
	
	funfacts_array.append("Neutrinos zip through you by the trillions. Creepy, huh?")
	funfacts_array.append("Near blackholes, time slows. Great place for cat naps!")
	funfacts_array.append("Atoms never actually touch. So technically, you float!")
	funfacts_array.append("Light is both wave and particle. Try catching that, human.")
	funfacts_array.append("Gravity warps space. I warp hearts. Same thing, right?")
	funfacts_array.append("Cosmic rays smash DNA. Explains my weird whiskers.")
	funfacts_array.append("Atoms dance, blackholes feast, quantum foam under my feet.")
	funfacts_array.append("So a proton, an electron, and a neutrino walk into a bar… Only the neutrino left unchanged.")
	funfacts_array.append("The Higgs gives mass. So basically it’s the cosmic donut shop.")
	funfacts_array.append("...")
	funfacts_array.append("Meow... I mean Hello there!")
	funfacts_array.append("")

func _process(_delta):
	if !is_overlapping:
		speech.text = ""
	
	if is_overlapping and Input.is_action_just_pressed("interact"):
		meow_sfx.pitch_scale = randf_range(0.75,1.25)
		if !PlayerManager.has_visited_TIBIA:
			if string_index <= welcome_talk.size()-1:
				speech.text = welcome_talk[string_index]
				string_index += 1
				meow_sfx.play()
			else:
				PlayerManager.has_visited_TIBIA = true
				speech.text = "..."
		else:
			match amount_of_chat:
				10:
					speech.text = "It's fun chatting but you have some isotopes to collect! Get going!"
					meow_sfx.play()
				11:
					speech.text = "..."
				20:
					speech.text = "What do you want a cookie or something??"
					meow_sfx.play()
				30:
					speech.text = "Fine, take this spare coyote time upgrade I have.."
					meow_sfx.play()
					PlayerManager.coyote_time += 0.1
				var n when n > 30:
					speech.text = "..."
				_:
					speech.text = funfacts_array.pick_random()
					meow_sfx.play()
			amount_of_chat += 1
		pass

func _on_interact_area_body_entered(body):
	if body.is_in_group("Player"):
		is_overlapping = true
		sprite.play("idle_select")

func _on_interact_area_body_exited(body):
	if body.is_in_group("Player"):
		is_overlapping = false
		sprite.play("idle")
