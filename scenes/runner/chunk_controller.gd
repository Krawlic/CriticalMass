extends Node2D

@export var chunk_scenes: Array[PackedScene] = []
@export var chunk_width: int = 320
@export var num_start_chunks: int = 4
@export var recycle_distance: int = 640

@onready var player = $Player
@onready var camera = $Camera2D
@onready var blackhole = $blackhole
@onready var music = $AudioStreamPlayer
@onready var start_dist_node = $Start_dist_node

var curr_chunks = []
var last_chunk_x: float = 0

func _ready():
	music.stream.loop = true
	blackhole.position = Vector2(camera.global_position.x - 350, 0)
	SignalBus.update_score.emit()
	
	last_chunk_x = (chunk_width * 2) * -1
	
	for i in num_start_chunks:
		spawn_chunk(last_chunk_x)
		last_chunk_x += chunk_width

func _process(delta):
	var camera_x = player.global_position.x
	camera.global_position.x = camera_x
	
	set_distance_score(camera_x)
		
	while last_chunk_x < camera_x + recycle_distance:
		spawn_chunk(last_chunk_x)
		last_chunk_x += chunk_width

func spawn_chunk(x_pos):
	var scene = chunk_scenes[randi() % chunk_scenes.size()]
	var chunk = scene.instantiate()
	chunk.position = Vector2(x_pos, 0)
	add_child(chunk)
	curr_chunks.append(chunk)

func set_distance_score(current_x: int):
	var traveled = current_x - start_dist_node.global_position.x
	if traveled == 0:
		SignalBus.update_distance.emit(0)
	var composite_distance = traveled/10
	SignalBus.update_distance.emit(composite_distance)
	SignalBus.submit_max_distance.emit(composite_distance)
