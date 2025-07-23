extends Node

#Mechanic Upgrades
var max_jumps: int = 1
var coyote_time: float = 0
var has_rewind: bool = false
var has_jump_acceleration: bool = false
var has_run_momentum: bool = true
var has_slide: bool = false
var max_repulsers = 0

var has_visited_TIBIA = false

var speed : float = 150.0
var max_speed: float = 300.0

func set_default():
	max_jumps = 1
	coyote_time = 0
	has_rewind = false
	has_jump_acceleration = false
	has_run_momentum = true
	has_slide = false
	max_repulsers = 0
	has_visited_TIBIA = false
	speed = 150.0
	max_speed = 300.0
