extends Sprite2D

@onready var area = $Area
var value: int

func _on_area_area_entered(hurt_area):
	if not hurt_area is HurtboxComponent: return
	Global.money += value
	queue_free()
