extends Node2D

@onready var sprite = $sprite
@onready var get_sfx = $get_sfx

func _ready():
	sprite.play("default")
	
func _on_pickup_area_body_entered(body):
	if body.is_in_group("Player"):
		get_sfx.pitch_scale = randf_range(0.5,1)
		get_sfx.play()
		SignalBus.add_to_score.emit(1)
		await get_sfx.finished
		self.queue_free()
