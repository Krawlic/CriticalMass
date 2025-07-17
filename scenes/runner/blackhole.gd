extends Node2D

@export var start_speed: float = 15
@export var acceleration: float = .05
@export var player: CharacterBody2D
@export var audio: AudioStreamPlayer

@onready var end_point = $duckbox/end_point
@onready var start_point = $duckbox/start_point

var curr_speed: float
var player_in_duckbox: bool = false

func _ready():
	curr_speed = start_speed
	acceleration = Global.blackhole_acceleration

func _process(delta):
	position.x += curr_speed * delta
	curr_speed += acceleration
	
	if player_in_duckbox:
		var percent = get_percent_between_x(player.global_position.x)
		player.global_position.x += -1 * percent
		var volume_factor = 1.0 - percent
		audio.volume_db = linear_to_db(volume_factor)

func _on_duckbox_body_entered(body):
	if body.is_in_group("Player"):
		player_in_duckbox = true

func _on_duckbox_body_exited(body):
	if body.is_in_group("Player"):
		player_in_duckbox = false
	
func get_percent_between_x(current_x: int) -> float:
	var total_distance = end_point.global_position.x - start_point.global_position.x
	if total_distance == 0:
		return 0.0
	var traveled = current_x - start_point.global_position.x
	return clamp(traveled / total_distance, 0.0, 1.0)

func _on_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		SignalBus.player_escape.emit()
		curr_speed = 0
		acceleration = 0


