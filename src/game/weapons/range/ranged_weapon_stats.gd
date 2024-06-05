class_name RangedWeaponsStats
extends WeaponStats

@export var projectile_scene: PackedScene
@export var RELOAD: float = 1:
	set(value):
		RELOAD = value
		reload_changed.emit(value)
@export var MAGAZINE: int = 10:
	set(value):
		MAGAZINE = value
		magazine_changed.emit(value)
@export var PROJECTILES: float = 1.0:
	set(value):
		PROJECTILES = value
		projectiles_changed.emit(value)
@export var SPREAD: float = 0.0
@export var PRESICION: float = 1.0
@export var PENETRATION: int = 1
@export var PROJECTILE_SPEED: float = 500.0

var stats = [
	["Damage", DAMAGE, damage_changed],
	["Critical Chance", CRIT_CHANCE, crit_chance_changed],
	["Critical Damage", CRIT_DAMAGE, crit_damage_changed],
	["Fire Rate", RATE, fire_rate_changed],
	["Range", RANGE, range_changed],
	["Magazine", MAGAZINE, magazine_changed],
	["Reload", RELOAD, reload_changed],
]

signal reload_changed(new_value)
signal magazine_changed(new_value)
signal projectiles_changed(new_value)

@export var reload_sfx: AudioStream
@export var shoot_sfx: AudioStream
