class_name MoveInputComponent
extends Node

@export var actor: Node2D
@export var stats: PlayerStats
var velocity: Vector2

func _process(delta):
	pass
	#velocity.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	#velocity.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	#velocity = velocity.normalized()
	
	#actor.translate(velocity * delta * stats.FINAL_SPEED)
	#actor.move_and_slide()