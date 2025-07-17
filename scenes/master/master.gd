extends Node2D

const RUNNER_SCENE = preload("res://scenes/runner/runner_scene.tscn")
const UPGRADE_ROOM = preload("res://scenes/UpgradeRoom/upgrade_room.tscn")

func _ready():
	SignalBus.progress_scene.connect(_progress_scene)
	var level_tmp = RUNNER_SCENE.instantiate()
	add_child(level_tmp)
	pass

func _progress_scene(progress: String):
	match progress:
		"Runner":
			get_tree().get_root().get_node("Master").get_child(1).queue_free()
			var level_tmp = RUNNER_SCENE.instantiate()
			self.call_deferred("add_child", level_tmp)
		"Upgrade":
			get_tree().get_root().get_node("Master").get_child(1).queue_free()
			var level_tmp = UPGRADE_ROOM.instantiate()
			self.call_deferred("add_child", level_tmp)
	pass

