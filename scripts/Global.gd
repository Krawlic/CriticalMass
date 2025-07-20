extends Node

var atomic_mass = 0
var max_distance = 0
var blackhole_acceleration = .05
var current_scene = "Splash"

var enable_CA: bool = true

func _ready():
	SignalBus.add_to_score.connect(_add_to_score)
	SignalBus.submit_max_distance.connect(_submit_max_distance)
	SignalBus.create_keybind.connect(_create_keybind)
	SignalBus.remove_keybind.connect(_remove_keybind)
	SignalBus.update_score.emit()
	
func _add_to_score(score: int):
	atomic_mass += score
	SignalBus.update_score.emit()

func _submit_max_distance(new_distance: int):
	if new_distance > max_distance:
		max_distance = new_distance

func set_default():
	atomic_mass = 35
	max_distance = 0
	blackhole_acceleration = .05
	SignalBus.update_score.emit()

func _remove_keybind(action,event):
	InputMap.action_erase_event(action,event)
	
func _create_keybind(action,event):
	InputMap.action_add_event(action,event)
