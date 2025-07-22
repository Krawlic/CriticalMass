extends Control

@onready var anim = $ColorRect/AnimationPlayer

func _ready():
	SignalBus.fade_to_scene.connect(_fade_to_scene)

func _fade_to_scene(target_scene_path: String):
	anim.play("fade_out")
	await anim.animation_finished
	SignalBus.progress_scene.emit(target_scene_path)
	anim.play("fade_in")
	await anim.animation_finished
