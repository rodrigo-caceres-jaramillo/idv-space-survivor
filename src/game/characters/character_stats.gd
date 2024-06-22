class_name PlayerStats
extends Resource

@export var MAX_HEALTH: int = 20:
	set(value):
		MAX_HEALTH = value
		max_health_changed.emit(value)
		stats_changed.emit()
var HEALTH_TYPE = HealthType.new()
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
	get: return (100 * SPEED)
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
