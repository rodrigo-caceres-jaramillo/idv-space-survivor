class_name Weapon
extends Node2D

@export var base_stats: RangedWeaponsStats
var player_stats: PlayerStats
var final_stats: RangedWeaponsStats = RangedWeaponsStats.new()
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
	self.magazine_size = base_stats.magazine
	self.current_ammo = base_stats.magazine
	spawn_projectile_component.projectile_scene = base_stats.projectile_scene
	fire_rate_timer.timeout.connect(func(): can_shoot = true)
	reload_timer.timeout.connect(_on_reload_timer_timeout)
	
func set_player_stats(p_stats: PlayerStats):
	player_stats = p_stats
	combine_stats()
	#fire_rate_timer.wait_time = final_stats.rate

func combine_stats():
	final_stats.damage = base_stats.damage * player_stats.DAMAGE
	final_stats.rate = base_stats.rate / player_stats.RATE
	final_stats.crit_chance = base_stats.crit_chance * player_stats.CRIT_CHANCE
	final_stats.crit_damage = base_stats.crit_damage * player_stats.CRIT_DAMAGE
	final_stats.range = base_stats.range * player_stats.RANGE
	final_stats.knockback = base_stats.knockback
	final_stats.reload = base_stats.reload
	final_stats.projectiles = base_stats.projectiles
	final_stats.spread = base_stats.spread
	final_stats.precision = base_stats.precision
	final_stats.penetration = base_stats.penetration
	final_stats.projectile_speed = base_stats.projectile_speed

	
func fire():
	if self.reloading: return
	if current_ammo > 0: self.shoot()
	else: self.reload()
		
func shoot():
	if not can_shoot: return
	self.current_ammo -= 1
	ammo_change.emit(current_ammo)
	var direction = global_position.direction_to(tip.global_position)
	spawn_projectile_component.spawn_projectile(final_stats, direction, global_rotation, tip.global_position)
	self.can_shoot = false
	fire_rate_timer.start(final_stats.rate)
		
func reload():
	if current_ammo <= magazine_size and not reloading:
		self.reloading = true
		reload_timer.start(final_stats.reload)
		start_reload.emit(final_stats.reload)
	
func _on_reload_timer_timeout():
	self.current_ammo = self.magazine_size
	self.reloading = false
	ammo_change.emit(current_ammo)
	reload_timer.stop()
	
signal ammo_change(new_value)
signal start_reload(reload_time)
