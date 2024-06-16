class_name State
extends Node2D

var animation_player: AnimationPlayer
var actor: CharacterBody2D
var blend_position : Vector2 = Vector2.ZERO

signal state_transition

func enter():
	pass

func exit():
	pass

func update(_delta):
	pass

func physics_update(_delta):
	pass

func update_look_direction():
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - actor.global_position).normalized()

	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			blend_position = Vector2.RIGHT
		else:
			blend_position = Vector2.LEFT
	else:
		if direction.y > 0:
			blend_position = Vector2.DOWN
		else:
			blend_position = Vector2.UP

func play_animation(anim_prefix: String):
	var anim_suffix = ""
	match blend_position:
		Vector2.RIGHT:
			anim_suffix = "right"
		Vector2.LEFT:
			anim_suffix = "left"
		Vector2.UP:
			anim_suffix = "back"
		Vector2.DOWN:
			anim_suffix = "front"

	animation_player.play(anim_prefix + "_" + anim_suffix)
