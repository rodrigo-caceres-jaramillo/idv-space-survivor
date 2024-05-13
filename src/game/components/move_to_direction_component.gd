class_name MoveToDirectionComponent
extends Node

@export var speed:float = 150
@export var actor: Node2D
var direction = Vector2()

func _process(delta):
	actor.position += direction * speed * delta