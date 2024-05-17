class_name  MoveToTargetComponent
extends Node

@export var actor: CharacterBody2D
@export var active = true
var target: Node2D
@export var speed = 100000
var velocity = Vector2()

func _process(delta):
	if not active:
		return
	if target: 
		velocity = actor.global_position.direction_to(Global.player.global_position).normalized()
		actor.global_position += velocity * speed * delta
		actor.move_and_slide()
