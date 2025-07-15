extends Node2D

@onready var sprite = $sprite

func _ready():
	sprite.play("default")
	
func _on_pickup_area_body_entered(body):
	if body.is_in_group("Player"):
		SignalBus.add_to_score.emit(1)
		self.queue_free()
