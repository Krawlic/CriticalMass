extends RigidBody2D

@export var launch_power := 300.0

@onready var ripple = $ripple
@onready var bomb = $bomb
@onready var explosion_sfx = $explosion_sfx

func _ready():
	var impulse = Vector2(randf_range(-50, 50), -launch_power)
	apply_impulse(impulse)
	

func _on_explosion_timer_timeout():
	ripple.play("default")
	explosion_sfx.play()
	bomb.visible = false
	SignalBus.repulse_blackhole.emit()

func _on_ripple_animation_finished():
	queue_free()
