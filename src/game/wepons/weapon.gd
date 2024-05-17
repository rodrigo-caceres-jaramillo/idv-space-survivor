class_name Weapon
extends Node2D

@export var stats: RangedWeaponsStats
@onready var tip = $Tip
@onready var fire_rate_timer = $FireRateTimer
@onready var spawn_projectile_component = $SpawnProjectileComponent as SpawnProjectileComponent
var can_shoot = true

func fire():
	if can_shoot:
		var direction = global_position.direction_to(tip.global_position)
		var rotation = global_rotation
		spawn_projectile_component.spawn_projectile(stats, direction, rotation, tip.global_position)
		fire_rate_timer.start(stats.rate)
		self.can_shoot = false
		
func _on_fire_rate_timer_timeout():
	can_shoot = true
