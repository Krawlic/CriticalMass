extends Node2D

@onready var switch_monitor = $switch_monitor
@onready var max_distance_label = $max_distance_label
@onready var monitor_label = $monitor_label

func _ready():
	switch_monitor.start()
	max_distance_label.text = str(Global.max_distance) + "m"

func _process(_delta):
	pass

func _on_switch_monitor_timeout():
	if max_distance_label.visible == true:
		max_distance_label.visible = false
		monitor_label.visible = true
	else:
		max_distance_label.text = str(Global.max_distance) + "m"
		max_distance_label.visible = true
		monitor_label.visible = false
	
	switch_monitor.start()
