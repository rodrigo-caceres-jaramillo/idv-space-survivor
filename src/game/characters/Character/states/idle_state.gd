class_name PlayerIdle
extends State

@export var weapon_manager: Node2D

func enter(_data):
	update_look_direction()
	play_animation("idle")

func update(_delta : float):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction.normalized()
	if direction != Vector2.ZERO:
		state_transition.emit(self, "movement")
	else:
		update_look_direction()
		play_animation("idle")
