class_name Weapon
extends Node2D

@export var stats: RangedWeaponsStats
@onready var tip = $Tip
@onready var fire_rate_timer = $FireRateTimer
@onready var spawn_projectile_component = $SpawnProjectileComponent as SpawnProjectileComponent
@onready var sprite = $Sprite
var can_shoot = true

func _ready():
	fire_rate_timer.wait_time = stats.rate
	spawn_projectile_component.projectile_scene = stats.projectile_scene
	
func fire():
	if can_shoot:
		var direction = global_position.direction_to(tip.global_position)
		spawn_projectile_component.spawn_projectile(stats, direction, global_rotation, tip.global_position)
		fire_rate_timer.start(stats.rate)
		self.can_shoot = false
		
func _on_fire_rate_timer_timeout():
	can_shoot = true
