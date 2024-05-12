extends CharacterBody2D

@export var damage_mul = 1
@export var range_mul = 1
@export var rate_mul = 1
@onready var weapon = $Weapon

func _ready():
	Global.player = self
	
func _process(delta):
	self.aim_and_shoot()

func aim_and_shoot():
	var mouse_position:Vector2 = get_global_mouse_position()
	weapon.look_at(mouse_position)
	if Input.is_action_pressed("fire_weapon"):
		weapon.fire(damage_mul)
