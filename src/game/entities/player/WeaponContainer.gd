extends Node2D

@onready var weapon
@export var weapon_resource: WeaponResource

func _ready():
	load_weapon()
	
func shoot_weapon():
	weapon.fire()

func load_weapon():
	weapon = weapon_resource.weapon_scene.instantiate()
	self.add_child(weapon)
	

