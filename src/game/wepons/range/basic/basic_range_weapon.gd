class_name Weapon
extends Node2D

@export var stats: RangedWeaponsStats
@onready var tip = $Tip
@onready var fire_rate_timer = $FireRateTimer
@onready var reload_timer = $ReloadTimer
@onready var spawn_projectile_component = $SpawnProjectileComponent as SpawnProjectileComponent
@onready var sprite = $Sprite
var can_shoot:bool = true
var reloading:bool = false
var magazine_size: int
var current_ammo: int

func _ready():
	fire_rate_timer.wait_time = stats.rate
	spawn_projectile_component.projectile_scene = stats.projectile_scene
	self.magazine_size = stats.magazine
	self.current_ammo = stats.magazine
	fire_rate_timer.timeout.connect(func(): can_shoot = true)
	reload_timer.timeout.connect(_on_reload_timer_timeout)

func fire():
	if self.reloading:
		return
	if current_ammo > 0:
		self.shoot()
	else:
		self.reload()
		
func shoot():
	if not can_shoot:
		return
	self.current_ammo -= 1
	ammo_change.emit(current_ammo)
	var direction = global_position.direction_to(tip.global_position)
	spawn_projectile_component.spawn_projectile(stats, direction, global_rotation, tip.global_position)
	self.can_shoot = false
	fire_rate_timer.start(stats.rate)
		
func reload():
	if current_ammo <= magazine_size and not reloading:
		self.reloading = true
		reload_timer.start(stats.reload)
	
func _on_reload_timer_timeout():
	self.current_ammo = self.magazine_size
	self.reloading = false
	ammo_change.emit(current_ammo)
	reload_timer.stop()
	
signal ammo_change(new_value)
