extends Node2D

@onready var sprite = $sprite
@onready var exit_sfx = $exit_sfx

var is_overlapping: bool = false

func _ready():
	sprite.play("not-selected")

func _process(_delta):
	if is_overlapping:
		sprite.play("selected")
		if Input.is_action_just_pressed("interact"):
			exit_sfx.play()
			SignalBus.fade_to_scene.emit("Runner")
	else:
		sprite.play("not-selected")

func _on_exit_area_body_entered(body):
	if body.is_in_group("Player"):
		is_overlapping = true

func _on_exit_area_body_exited(body):
	if body.is_in_group("Player"):
		is_overlapping = false
