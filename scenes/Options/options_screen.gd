extends Node2D

@onready var volume_slider = $Control/VScrollBar/VBoxContainer/HBoxContainer/volume_slider

func _on_volume_slider_value_changed(value):
	if value > -41:
		AudioServer.set_bus_mute(0, false)
		AudioServer.set_bus_volume_db(0, value)
	else:
		AudioServer.set_bus_mute(0, true)

func _on_back_button_button_down():
	visible = false

func _on_chroma_aberration_toggle_toggled(toggled_on):
	Global.enable_CA = toggled_on

func _on_visibility_changed():
	if visible == true:
		volume_slider.grab_focus()
	else:
		get_parent().regrab_focus()
