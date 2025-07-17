extends Node2D
class_name upgrade_base

@export var cost: int = 1
@export var description: String = "Double Jump"
@export var icon: AtlasTexture

@onready var upgrade_icon = $Control/upgrade_icon
@onready var label = $Control/Label
@onready var interact_button = $"Interact Button"
@onready var cost_label = $Control/cost_label
@onready var upgrade_particles = $upgrade_terminal/upgrade_particles
@onready var particle_timer = $upgrade_terminal/particle_timer
@onready var upgrade_terminal = $upgrade_terminal
@onready var stand_particles = $upgrade_terminal/stand_particles
@onready var upgrade_particle_sound = $upgrade_particle_sound

var is_overlapping: bool = false
var is_bought: bool = false

func _ready():
	upgrade_terminal.play("default")
	upgrade_icon.texture = icon
	label.text = description
	cost_label.text = "Cost:  " + str(cost)

func _process(delta):
	if is_overlapping and !is_bought:
		label.visible = true
		stand_particles.emitting = true
		cost_label.visible = true
		interact_button.play("selected")
	else:
		interact_button.play("not_selected")
		stand_particles.emitting = false
		label.visible = false
		cost_label.visible = false
	
	if is_overlapping and Input.is_action_just_pressed("interact") and !is_bought:
		if Global.atomic_mass >= cost:
			apply_upgrade()
			particle_timer.start()
			upgrade_terminal.play("used")
			is_bought = true
			upgrade_particles.emitting = true
			upgrade_particle_sound.pitch_scale = randf_range(0.5,1.5)
			upgrade_particle_sound.play()
			stand_particles.emitting = false
			Global._add_to_score(cost * -1)
			SignalBus.update_score.emit()
			SignalBus.update_player_flags.emit()
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


func _on_particle_timer_timeout():
	upgrade_particles.emitting = false
