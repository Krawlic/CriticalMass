extends Control

@onready var charges = $charges

func _ready():
	SignalBus.update_repulser_label.connect(_update_repulser_count)
	if(PlayerManager.max_repulsers > 0):
		charges.text = "x"+str(PlayerManager.max_repulsers)
		visible = true
		
func _update_repulser_count(count: int):
	charges.text = "x" + str(count)
