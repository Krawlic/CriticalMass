extends Node2D
class_name upgrade_base

@export var cost: int = 1
@export var description: String = "Double Jump"
@export var icon: AtlasTexture

@onready var upgrade_icon = $Control/upgrade_icon
@onready var label = $Control/upgrade_label/Label
@onready var interact_button = $"Interact Button"

var is_overlapping: bool = false

func _ready():
	upgrade_icon.texture = icon
	label.text = description

func _process(delta):
	if is_overlapping:
		label.visible = true
		interact_button.play("selected")
	else:
		interact_button.play("not_selected")
		label.visible = false
	
	if is_overlapping and Input.is_action_just_pressed("interact"):
		if Global.atomic_mass >= cost:
			apply_upgrade()
			Global._add_to_score(cost * -1)
			SignalBus.update_score.emit()
		pass

func apply_upgrade():
	print("base upgrade applied")
	pass

func _on_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		is_overlapping = true
			

func _on_hitbox_body_exited(body):
	if body.is_in_group("Player"):
		is_overlapping = false
