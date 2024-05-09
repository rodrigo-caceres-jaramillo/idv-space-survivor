extends Sprite

var VALUE = 1

func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		Global.money += VALUE
		queue_free()
