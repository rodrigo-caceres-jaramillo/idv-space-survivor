class_name  MoveToTargetComponent
extends Node

@export var actor: CharacterBody2D
@export var stats: StatsComponent 
@onready var speed= stats.speed
var target: Node2D
var velocity = Vector2()

func _process(delta):
	velocity = actor.global_position.direction_to(Global.player.global_position).normalized()
	actor.global_position += velocity * speed * delta
	actor.move_and_slide()
