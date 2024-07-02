class_name RangeWeapon
extends Node2D

@export var projectile: PackedScene
@export var muzzle_flash: PackedScene
@export var two_hands: bool
@onready var tip = $Tip
@onready var main_hand = $MainHand
@onready var second_hand = $SecondHand
var base_stats
var stats: RangeWeaponsStats
var player_stats: PlayerStats
var can_shoot:bool = true
var reloading:bool = false
var magazine_size: int
var current_ammo: int

func change_active_state(value):
	change_state.emit(value)

func set_up(b_stast:RangeWeaponsStats, p_stats: PlayerStats, hand_texture):
	base_stats = b_stast
	stats = b_stast
	player_stats = p_stats
	self.main_hand.texture = hand_texture
	if two_hands == true: self.second_hand.texture = hand_texture
	update_stats()
	Events.wave_started.connect(update_stats.unbind(1))
	self.magazine_size = stats.MAGAZINE
	self.current_ammo = stats.MAGAZINE
	change_active_state(false)

func update_stats():
	stats.DAMAGE = base_stats.DAMAGE * player_stats.DAMAGE
	stats.FIRE_RATE = base_stats.FIRE_RATE * player_stats.RATE
	stats.CRITICAL_CHANCE = base_stats.CRITICAL_CHANCE * player_stats.CRIT_CHANCE
	stats.CRITICAL_DAMAGE = base_stats.CRITICAL_DAMAGE * player_stats.CRIT_DAMAGE
	stats.RANGE = base_stats.RANGE * player_stats.RANGE

signal change_state(value: bool)
signal shoot_try()
signal reload_try()
