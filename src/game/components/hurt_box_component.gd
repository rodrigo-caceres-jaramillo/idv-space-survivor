class_name HurtboxComponent
extends Area2D

@export var damage_interval = 1

@export var is_invincible = false :
	set(value):
		is_invincible = value
		for child in get_children():
			if not child is CollisionShape2D and not child is CollisionPolygon2D: continue
			child.set_deferred("disabled", is_invincible)

signal hurt(hitbox)
