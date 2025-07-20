extends Node2D

@export var player: CharacterBody2D

var upgrade_scenes: Array[PackedScene] = [preload("res://scenes/UpgradeRoom/upgrades/coyote_time.tscn"),
	preload("res://scenes/UpgradeRoom/upgrades/double_jump.tscn"),
	preload("res://scenes/UpgradeRoom/upgrades/slide.tscn"),
	preload("res://scenes/UpgradeRoom/upgrades/speed_up.tscn"),
	preload("res://scenes/UpgradeRoom/upgrades/blackhole_speed_down.tscn"),
	preload("res://scenes/UpgradeRoom/upgrades/repulser.tscn")
]

@onready var camera = $Camera2D
@onready var bgmusic = $bgmusic
@onready var upgrade_slots = $Upgrade_Slots

func _ready():
	SignalBus.update_score.emit()
	bgmusic.stream.loop = true
	spawn_upgrades()

func _process(_delta):
	var camera_x = player.global_position.x
	camera.global_position.x = camera_x

func spawn_upgrades():
	
	if PlayerManager.has_slide:
		upgrade_scenes.remove_at(2)
	if PlayerManager.max_jumps >= 3:
		upgrade_scenes.remove_at(1)
	if PlayerManager.max_repulsers >= 3:
		upgrade_scenes.remove_at(5)
	
	randomize()
	for slot in upgrade_slots.get_children():
		var scene = upgrade_scenes[randi() % upgrade_scenes.size()]
		upgrade_scenes.erase(scene)
		var upgrade_instance = scene.instantiate()
		slot.add_child(upgrade_instance)
