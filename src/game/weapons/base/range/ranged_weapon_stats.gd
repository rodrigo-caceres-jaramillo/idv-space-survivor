class_name RangedWeaponsStats
extends WeaponStats

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
@export var PENETRATION: int = 1
@export var PROJECTILE_SPEED: float = 500.0

func get_labels(): 
	return [
	["Damage", DAMAGE, 0, damage_changed],
	["Critical Chance", CRIT_CHANCE, 0, crit_chance_changed],
	["Critical Damage", CRIT_DAMAGE, 0, crit_damage_changed],
	["Fire Rate", RATE, 0, fire_rate_changed],
	["Range", RANGE, 0, range_changed],
	["Magazine", MAGAZINE, 0, magazine_changed],
	["Reload", RELOAD, 0, reload_changed],
]

signal reload_changed(new_value)
signal magazine_changed(new_value)
signal projectiles_changed(new_value)

@export var reload_sfx: AudioStream
@export var shoot_sfx: AudioStream
