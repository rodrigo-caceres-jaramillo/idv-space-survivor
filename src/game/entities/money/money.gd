extends Sprite2D

@onready var area = $Area
var value: int

func _on_area_area_entered(area):
	if not area is HurtboxComponent: return
	Global.money += value
	queue_free()
