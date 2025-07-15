extends Node2D

var is_overlapping: bool = false

func _process(delta):
	if is_overlapping and Input.is_action_just_pressed("interact"):
		SignalBus.progress_scene.emit("Runner")

func _on_exit_area_body_entered(body):
	if body.is_in_group("Player"):
		is_overlapping = true

func _on_exit_area_body_exited(body):
	if body.is_in_group("Player"):
		is_overlapping = false
