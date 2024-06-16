class_name PlayerMovementState
extends State

var velocity: Vector2
var accel = 1000

func enter():
	update_look_direction()
	play_animation("walk")

func physics_update(_delta: float):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction.normalized()
	actor.velocity = (direction * actor.stats.FINAL_SPEED)
	actor.move_and_slide()

	if direction != Vector2.ZERO:
		update_look_direction()
		play_animation("walk") 
	else:
		state_transition.emit(self, "idle")

	if Input.is_action_pressed("dash") and actor.can_dash:
		state_transition.emit(self, "dash")
