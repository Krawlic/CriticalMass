extends Node2D

@export var options_screen: Node2D

@onready var menu_music = $Menu_Music
@onready var start_button = $Control/StartButton
@onready var exitsign = $exitsign
@onready var player_sprite = $PlayerSprite

func _ready():
	menu_music.stream.loop = true
	start_button.grab_focus()
	exitsign.play("default")
	player_sprite.play("suck")

func _process(_delta):
	pass

func regrab_focus():
	start_button.grab_focus()

func _on_start_button_button_down():
	start_button.disabled = true
	SignalBus.fade_to_scene.emit("Runner")

func _on_options_button_button_down():
	options_screen.visible = true

func _on_exit_button_button_down():
	get_tree().quit()
