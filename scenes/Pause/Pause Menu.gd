extends CanvasLayer

@export var options_screen: Node2D

@onready var resume_button = $overlay/TextureRect/VBoxContainer/ResumeButton

func _process(_delta):
	if Input.is_action_just_pressed("pause") and Global.current_scene != "Menu" and Global.current_scene != "Option" and Global.current_scene != "Splash":
		if get_tree().paused:
			get_tree().paused = false
			options_screen.visible = false
			visible = false
		else:
			get_tree().paused = true
			visible = true

func regrab_focus():
	resume_button.grab_focus()

func _on_resume_button_button_down():
	visible = false
	get_tree().paused = false


func _on_options_button_button_down():
	options_screen.visible = true


func _on_menu_button_button_down():
	get_tree().paused = false
	visible = false
	SignalBus.restart_game.emit()

func _on_exit_button_button_down():
	get_tree().quit()

func _on_visibility_changed():
	if visible == true:
		regrab_focus()
