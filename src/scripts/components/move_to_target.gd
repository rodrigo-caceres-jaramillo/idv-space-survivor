class_name  MoveToTargetComponent
extends Node

@export var actor: CharacterBody2D
@export var active = true
var target: Node2D
@export var speed = 100000

func _physics_process(delta):
	if not active:
		return
	if target: 
		actor.velocity = actor.global_position.direction_to(Global.player.global_position).normalized()
		actor.move_and_slide()
