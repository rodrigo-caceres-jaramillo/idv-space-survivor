class_name AttackManager
extends Node2D

@onready var hand_position = $HandPosition
var hand_sprite
var weapon

func _process(_delta):
	hand_position.look_at(Global.player.global_position)

func set_up(_weapon, _hand_sprite):
	weapon = _weapon.weapon_scene.instantiate()
	hand_position.add_child(weapon)
	weapon.set_up(_hand_sprite)

func attack():
	weapon.attack()
