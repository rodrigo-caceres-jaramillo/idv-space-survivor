extends Node2D

@onready var weapon = get_children()[0]
	
	
func shoot_weapon():
	weapon.fire()
