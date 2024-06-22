class_name AttackManager
extends Node2D

@export var hand_sprite: Texture
@onready var hand_position = $HandPosition
var weapon

func _process(_delta):
	hand_position.look_at(Global.player.global_position)

func set_up(_weapon):
	weapon = _weapon.weapon_scene.instantiate()
	hand_position.add_child(weapon)
	weapon.set_up(hand_sprite)

func attack():
	weapon.attack()
