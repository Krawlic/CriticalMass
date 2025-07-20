extends Node2D

@onready var splash_timer = $splash_timer

# Called when the node enters the scene tree for the first time.
func _ready():
	splash_timer.start()

func _on_splash_timer_timeout():
	SignalBus.progress_scene.emit("Menu")
