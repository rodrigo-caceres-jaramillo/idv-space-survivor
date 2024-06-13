class_name PlayerIdle
extends State

@export var weapon_manager: Node2D

func enter():
	#animator.play("Idle")
	print("enter idle")
	pass
	
func update(_delta : float):
	if(Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()):
		state_transition.emit(self, "movement")
	if Input.is_action_pressed("dash") and actor.can_dash:
		state_transition.emit(self, "dash")

