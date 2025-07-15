extends Node2D

@export var player: CharacterBody2D

@onready var camera = $Camera2D
@onready var bgmusic = $bgmusic

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.update_score.emit()
	bgmusic.stream.loop = true
	print(Global.max_distance)

func _process(delta):
	var camera_x = player.global_position.x
	camera.global_position.x = camera_x
	pass
