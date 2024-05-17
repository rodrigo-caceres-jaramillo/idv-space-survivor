class_name MoveInputComponent
extends Node

@export var actor: Node2D
@export var speed = 10
var velocity: Vector2

func _process(delta):
	velocity.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	velocity = velocity.normalized()
	
	actor.translate(velocity * delta * speed)
	actor.move_and_slide()
