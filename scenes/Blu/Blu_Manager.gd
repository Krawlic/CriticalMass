extends Node2D

@onready var sprite = $sprite
@onready var speech = $speech

var welcome_talk: Array[String]
var funfacts_array : Array[String]

var is_overlapping : bool = false
var string_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.play("idle")
	
	welcome_talk.append("Hi! Welcome to 'The In-Between Interaction Area' or T.I.B.I.A for short!")
	welcome_talk.append("It seems like you kinda messed up your reality by smashing atoms together...")
	welcome_talk.append("But don't fear! Blu is here to help!")
	welcome_talk.append("I rescued you from being turned into speghetti and...")
	welcome_talk.append("You can buy upgrades with your ATOMIC MASS!")
	welcome_talk.append("You can gather ATOMIC MASS by picking up isotopes when you go back out.")
	welcome_talk.append("So what are you waiting for?! Buy something and get running!")
	
	funfacts_array.append("Test1")
	funfacts_array.append("Test2")
	funfacts_array.append("Test3")
	funfacts_array.append("Test4")
	funfacts_array.append("Test5")

func _process(delta):
	if !is_overlapping:
		speech.text = ""
	
	if is_overlapping and Input.is_action_just_pressed("interact"):
		if !PlayerManager.has_visited_TIBIA:
			if string_index <= welcome_talk.size()-1:
				speech.text = welcome_talk[string_index]
				string_index += 1
			else:
				PlayerManager.has_visited_TIBIA = true
		else:
			speech.text = funfacts_array.pick_random()
		pass

func _on_interact_area_body_entered(body):
	if body.is_in_group("Player"):
		is_overlapping = true

func _on_interact_area_body_exited(body):
	if body.is_in_group("Player"):
		is_overlapping = false
