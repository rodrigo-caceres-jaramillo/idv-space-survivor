class_name PlayerMovementState
extends State

var velocity: Vector2
var friction = 0.5

func enter():
	print("enter movement")
	pass

func physics_update(_delta : float):
	var direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up"),
	)
	direction.normalized()
	actor.velocity = actor.velocity.lerp(direction * actor.stats.FINAL_SPEED, 0.1)
	actor.velocity *= 1.0 - (friction *_delta)
	actor.move_and_slide()
	if Input.is_action_pressed("dash") and actor.can_dash:
		state_transition.emit(self, "dash")
