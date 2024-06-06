class_name PlayerStats
extends Resource

@export var MAX_HEALTH: int = 20:
	set(value):
		MAX_HEALTH = value
		max_health_changed.emit(value)
		stats_changed.emit()
var HEALTH: int:
	set(value):
		HEALTH = value
		health_changed.emit(value)
		if HEALTH <= 0: no_health.emit()
		stats_changed.emit()
@export var SPEED: float = 1:
	set(value):
		SPEED = value
		speed_changed.emit(value)
		stats_changed.emit()
var FINAL_SPEED: float:
	get: return (200 * SPEED)
@export var DAMAGE = 1:
	set(value):
		DAMAGE = value
		damage_changed.emit(value)
		stats_changed.emit()
@export var CRIT_CHANCE: float = 1:
	set(value):
		CRIT_CHANCE = value
		crit_chance_changed.emit(value)
		stats_changed.emit()
@export var CRIT_DAMAGE: float = 1:
	set(value):
		CRIT_DAMAGE = value
		crit_damage_changed.emit(value)
		stats_changed.emit()
@export var RANGE: float = 1:
	set(value):
		RANGE = value
		range_changed.emit(value)
		stats_changed.emit()
@export var RATE: float = 1:
	set(value):
		RATE = value
		fire_rate_changed.emit(value)
		stats_changed.emit()
@export var KB_RESISTANCE: float = 1

func get_labels():
	return [
	["Max Health", MAX_HEALTH, 0, max_health_changed],
	["Speed", SPEED, 100, speed_changed],
	["Damage", DAMAGE, 100, damage_changed],
	["Critical Chance", CRIT_CHANCE, 100, crit_chance_changed],
	["Critical Damage", CRIT_DAMAGE, 100, crit_damage_changed],
	["Fire Rate", RATE, 100, fire_rate_changed],
	["Range", RANGE, 100, range_changed],
	]

func _init():
	HEALTH = MAX_HEALTH

signal stats_changed()
signal max_health_changed(new_value)
signal speed_changed(new_value)
signal damage_changed(new_value)
signal crit_chance_changed(new_value)
signal crit_damage_changed(new_value)
signal fire_rate_changed(new_value)
signal range_changed(new_value)
signal health_changed(new_value)
signal no_health()
