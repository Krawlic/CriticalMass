extends Node2D

const RUNNER_SCENE = preload("res://scenes/runner/runner_scene.tscn")
const UPGRADE_ROOM = preload("res://scenes/UpgradeRoom/upgrade_room.tscn")
const SPLASH = preload("res://scenes/UI/splash/splash.tscn")
const MENU = preload("res://scenes/menu/menu.tscn")
const OPTIONS_SCREEN = preload("res://scenes/Options/options_screen.tscn")

func _ready():
	SignalBus.progress_scene.connect(_progress_scene)
	SignalBus.restart_game.connect(_restart_game)
	var level_tmp = SPLASH.instantiate()
	add_child(level_tmp)
	pass

func _progress_scene(progress: String):
	match progress:
		"Menu":
			get_tree().get_root().get_node("Master").get_child(1).queue_free()
			var level_tmp = MENU.instantiate()
			self.call_deferred("add_child", level_tmp)
			Global.current_scene = "Menu"
		"Runner":
			get_tree().get_root().get_node("Master").get_child(1).queue_free()
			var level_tmp = RUNNER_SCENE.instantiate()
			self.call_deferred("add_child", level_tmp)
			Global.current_scene = "Runner"
		"Upgrade":
			get_tree().get_root().get_node("Master").get_child(1).queue_free()
			var level_tmp = UPGRADE_ROOM.instantiate()
			self.call_deferred("add_child", level_tmp)
			Global.current_scene = "Upgrade"
		"Option":
			get_tree().get_root().get_node("Master").get_child(1).queue_free()
			var level_tmp = OPTIONS_SCREEN.instantiate()
			self.call_deferred("add_child", level_tmp)
			Global.current_scene = "Option"
	pass

func _restart_game():
	PlayerManager.set_default()
	Global.set_default()
	SignalBus.fade_to_scene.emit("Menu")
