extends Node

var atomic_mass = 10
var max_distance = 0

func _ready():
	SignalBus.add_to_score.connect(_add_to_score)
	SignalBus.submit_max_distance.connect(_submit_max_distance)
	SignalBus.update_score.emit()
	
func _add_to_score(score: int):
	atomic_mass += score
	SignalBus.update_score.emit()

func _submit_max_distance(new_distance: int):
	if new_distance > max_distance:
		max_distance = new_distance
