extends Node2D

@onready var weapon_tip = $WeaponTip
@onready var fire_delay_timer = $FireDelayTimer
@onready var spawner_component = $SpawnerComponent

var can_shoot = true
var damge = 2
var range = 1
var speed = 300

func fire(dmg_mul):
	if(can_shoot):
		var projectile = spawner_component.spawn(weapon_tip.global_position)
		var direction = global_position.direction_to(weapon_tip.global_position)
		projectile.initialize(damge*dmg_mul, range, speed, direction)
		fire_delay_timer.start()
		self.can_shoot = false

func _on_fire_delay_timer_timeout():
	self.can_shoot = true
