class_name Weapon
extends Node2D

@export var weapon_fsx: AudioStreamPlayer
@export var projectile: PackedScene
@export var two_hands: bool
@onready var tip = $Tip
@onready var fire_rate_timer = $FireRateTimer
@onready var reload_timer = $ReloadTimer
@onready var spawn_projectile_component = $SpawnProjectileComponent as SpawnProjectileComponent
@onready var main_hand = $MainHand
@onready var second_hand = $SecondHand
var base_stats
var stats: RangedWeaponsStats
var player_stats: PlayerStats
var can_shoot:bool = true
var reloading:bool = false
var magazine_size: int
var current_ammo: int

func _ready():
	fire_rate_timer.timeout.connect(func(): can_shoot = true)
	reload_timer.timeout.connect(_on_reload_timer_timeout)
	spawn_projectile_component.projectile_scene = projectile

func set_up(b_stast:RangedWeaponsStats, p_stats: PlayerStats, hand_texture):
	base_stats = b_stast
	stats = b_stast
	player_stats = p_stats
	self.main_hand.texture = hand_texture
	if two_hands == true: self.second_hand.texture = hand_texture
	update_stats()
	Events.wave_started.connect(update_stats.unbind(1))
	self.magazine_size = stats.MAGAZINE
	self.current_ammo = stats.MAGAZINE

func update_stats():
	stats.DAMAGE = base_stats.DAMAGE * player_stats.DAMAGE
	stats.FIRE_RATE = base_stats.FIRE_RATE * player_stats.RATE
	stats.CRITICAL_CHANCE = base_stats.CRITICAL_CHANCE * player_stats.CRIT_CHANCE
	stats.CRITICAL_DAMAGE = base_stats.CRITICAL_DAMAGE * player_stats.CRIT_DAMAGE
	stats.RANGE = base_stats.RANGE * player_stats.RANGE

func fire():
	if self.reloading: return
	if current_ammo > 0: self.shoot()
	else: self.reload()
		
func shoot():
	if not can_shoot: return
	Global.camera.shake(0.1, stats.KNOCKBACK*0.3)
	_audio_weapon(stats.shoot_sfx)
	self.current_ammo -= 1
	Events.weapon_ammo_changed.emit(current_ammo)
	var direction = global_position.direction_to(tip.global_position)
	spawn_projectile_component.spawn_projectile(stats, direction, global_rotation, tip.global_position)
	self.can_shoot = false
	fire_rate_timer.start(1.0/stats.FIRE_RATE)
		
func reload():
	if current_ammo <= magazine_size and not reloading:
		_audio_weapon(stats.reload_sfx)
		self.reloading = true
		reload_timer.start(stats.RELOAD)
		Events.weapon_reload_start.emit(stats.RELOAD)
	
func _on_reload_timer_timeout():
	self.current_ammo = self.magazine_size
	self.reloading = false
	Events.weapon_ammo_changed.emit(current_ammo)
	reload_timer.stop()

func _audio_weapon(audio:AudioStream):
	weapon_fsx.stream = audio
	weapon_fsx.play()
