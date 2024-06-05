class_name Weapon
extends Node2D

@export var weapon_fsx: AudioStreamPlayer

@export var base_stats: RangedWeaponsStats
var player_stats: PlayerStats
var stats: RangedWeaponsStats = RangedWeaponsStats.new()
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
	self.magazine_size = base_stats.MAGAZINE
	self.current_ammo = base_stats.MAGAZINE
	spawn_projectile_component.projectile_scene = base_stats.projectile_scene
	fire_rate_timer.timeout.connect(func(): can_shoot = true)
	reload_timer.timeout.connect(_on_reload_timer_timeout)
	
func set_player_stats(p_stats: PlayerStats):
	player_stats = p_stats
	combine_stats()

func combine_stats():
	stats.DAMAGE = base_stats.DAMAGE * player_stats.DAMAGE
	stats.RATE = base_stats.RATE / player_stats.RATE
	stats.CRIT_CHANCE = base_stats.CRIT_CHANCE * player_stats.CRIT_CHANCE
	stats.CRIT_DAMAGE = base_stats.CRIT_DAMAGE * player_stats.CRIT_DAMAGE
	stats.RANGE = base_stats.RANGE * player_stats.RANGE
	stats.KNOCKBACK = base_stats.KNOCKBACK
	stats.RELOAD = base_stats.RELOAD
	stats.PROJECTILES = base_stats.PROJECTILES
	stats.SPREAD = base_stats.SPREAD
	stats.PRESICION = base_stats.PRESICION
	stats.PENETRATION = base_stats.PENETRATION
	stats.PROJECTILE_SPEED = base_stats.PROJECTILE_SPEED

func fire():
	if self.reloading: return
	if current_ammo > 0: self.shoot()
	else: self.reload()
		
func shoot():
	if not can_shoot: return
	_audio_weapon(base_stats.shoot_sfx)
	self.current_ammo -= 1
	ammo_change.emit(current_ammo)
	var direction = global_position.direction_to(tip.global_position)
	spawn_projectile_component.spawn_projectile(stats, direction, global_rotation, tip.global_position)
	self.can_shoot = false
	fire_rate_timer.start(stats.RATE)
		
func reload():
	if current_ammo <= magazine_size and not reloading:
		_audio_weapon(base_stats.reload_sfx)
		self.reloading = true
		reload_timer.start(stats.RELOAD)
		start_reload.emit(stats.RELOAD)
	
func _on_reload_timer_timeout():
	self.current_ammo = self.magazine_size
	self.reloading = false
	ammo_change.emit(current_ammo)
	reload_timer.stop()
	
signal ammo_change(new_value)
signal start_reload(reload_time)


func _audio_weapon(audio:AudioStream):
	weapon_fsx.stream = audio
	weapon_fsx.play()
