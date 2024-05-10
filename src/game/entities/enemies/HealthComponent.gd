extends Node

export (float) var MAX_HEALTH = 200
var health: float

func _ready():
	self.healh = MAX_HEALTH

func damage(damge):
	health -= damge
	
	if health <= 0:
		get_parent().queue_free()
