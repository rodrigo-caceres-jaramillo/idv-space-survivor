extends Area2D

var value: int
var is_magnetized: bool = false
var target_position: Vector2
var magnet_speed: float = 300.0

func _physics_process(delta):
	var bodies = get_overlapping_areas()
	for body in bodies:
		if body.name =="PickUpArea":
			global_position = global_position.move_toward(Global.player.global_position, magnet_speed * delta)
		if body.name =="HurtboxComponent":
			Global.money += value
			queue_free()
