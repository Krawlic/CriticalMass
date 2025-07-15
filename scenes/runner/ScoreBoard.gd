extends Control

@onready var atomicmass_label = $atomicmass_label
@onready var distance_label = $distance_label

func _ready():
	SignalBus.update_score.connect(_update_score_label)
	SignalBus.update_distance.connect(_update_distance_label)
	
func _update_score_label():
	atomicmass_label.text = str(Global.atomic_mass)
	
func _update_distance_label(distance: int):
	distance_label.text = str(distance)
