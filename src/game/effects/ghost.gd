extends Sprite2D

func _ready():
	ghost()
	
func set_property(tx_pos, _scale):
	global_position = tx_pos
	scale = _scale

func ghost():
	var tween_fade = get_tree().create_tween()
	tween_fade.tween_property(self, "self_modulate", Color(1,1,1,0), 0.5)
	await  tween_fade.finished
	queue_free()
