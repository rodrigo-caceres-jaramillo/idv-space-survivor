class_name Player
extends CharacterBody2D

@onready var hurtbox_component = $HurtboxComponent as HurtboxComponent
@onready var stats_component = $StatsComponent as StatsComponent
@onready var weapon_container = $WeaponContainer
@export var rate_mul = 1
@export var damage_mul = 1
@export var range_mul = 1
@export var max_health = 1000

func _ready():
	Global.player = self
	stats_component.no_health.connect(
		func():
		queue_free()
	)
	stats_component.health = max_health
	
func _process(_delta):
	self.aim_and_shoot()

func aim_and_shoot():
	var mouse_position:Vector2 = get_global_mouse_position()
	weapon_container.look_at(mouse_position)
	if Input.is_action_pressed("fire_weapon"):
		weapon_container.shoot_weapon()
