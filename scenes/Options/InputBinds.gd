extends Control

const ACTION_BIND_SET = preload("res://scenes/Options/ActionBindSet.tscn")

var is_remapping = false
var action_to_remap = null
var remapping_button = null
var key_event = null
var joypad_event = null
var bind_enter_or_a = false

func _ready():
	_create_action_list()

func _input(event):
	if is_remapping:
		if event is InputEventKey or (event is InputEventMouseButton and event.pressed) or (event is InputEventJoypadButton and event.pressed):
			if key_event:
				SignalBus.remove_keybind.emit(action_to_remap,key_event)
				_update_action_list(remapping_button,event)
			if joypad_event:
				SignalBus.remove_keybind.emit(action_to_remap,joypad_event)
				_update_action_list(remapping_button,event)
				if event.button_index == 0:
					bind_enter_or_a = true
			SignalBus.create_keybind.emit(action_to_remap,event)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			key_event = null
			joypad_event = null

func _create_action_list():
	#InputMap.load_from_project_settings()
	for item in get_children():
		item.queue_free()
		
	for action in InputMap.get_actions():
		if !action.contains("ui"):
			var events = InputMap.action_get_events(action)
			if events.size() > 0:
				var button = ACTION_BIND_SET.instantiate()
				var action_label = button.get_node("HBoxContainer/Action Name")
				var input_label = button.get_node("HBoxContainer/BindButton")
				var input_label_joypad = button.get_node("HBoxContainer/BindButton_controller")
				var no_change_label = button.get_node("HBoxContainer/no_change")
				var key_event = null
				var joypad_event = null
				input_label.text = ""
				input_label_joypad.text = ""
				action_label.text = action
				
				for event in events:
					if event is InputEventKey:
						input_label.text = event.as_text().replace("(Physical)","")
						key_event = event
					elif event is InputEventJoypadButton:
						joypad_event = event
						input_label_joypad.text = str(event.button_index)
				
				if input_label.text == "":
					input_label.visible = false
					no_change_label.visible = true
				if input_label_joypad.text == "":
					input_label_joypad.visible = false
					no_change_label.visible = true
				
				add_child(button)
				input_label.pressed.connect(_on_input_button_pressed.bind(button,action,key_event))
				input_label_joypad.pressed.connect(_on_input_button_joypad_pressed.bind(button,action,joypad_event))
				
func _on_input_button_pressed(button, action, event):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		key_event = event
		button.get_node("HBoxContainer/BindButton").text = "..."
	pass
	
func _on_input_button_joypad_pressed(button, action, event):
	if !is_remapping and !bind_enter_or_a:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		joypad_event = event
		button.get_node("HBoxContainer/BindButton_controller").text = "..."
		
	if bind_enter_or_a:
		bind_enter_or_a = false
		
	pass

func _update_action_list(button, event):
	if event is InputEventKey:
		button.get_node("HBoxContainer/BindButton").text = event.as_text().replace("(Physical)","")
		key_event = event
	elif event is InputEventJoypadButton:
		joypad_event = event
		print(str(event.button_index))
		button.get_node("HBoxContainer/BindButton_controller").text = str(event.button_index)
