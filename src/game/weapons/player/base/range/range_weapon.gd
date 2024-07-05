class_name RangeWeapon
extends Node2D

@export var projectile: PackedScene
@export var muzzle_flash: PackedScene
@export var two_hands: bool
@export var crosshair: Texture
@onready var tip = $Tip
@onready var main_hand = $MainHand
@onready var second_hand = $SecondHand
@onready var upgrade_manager = $UpgradeManager
var base_stats
var stats
var can_shoot:bool = true
var reloading:bool = false
var magazine_size: int
var current_ammo: int

func change_active_state(value):
	change_state.emit(value)

func set_up(b_stast:RangeWeaponsStats, upgrades, hand_texture):
	base_stats = b_stast
	self.main_hand.texture = hand_texture
	if two_hands == true: self.second_hand.texture = hand_texture
	upgrade_manager.upgrades = upgrades
	upgrade_manager.apply_upgrades()
	self.magazine_size = stats.MAGAZINE
	self.current_ammo = stats.MAGAZINE
	change_active_state(false)

signal change_state(value: bool)
signal shoot_try()
signal reload_try()
