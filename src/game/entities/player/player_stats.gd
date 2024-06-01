class_name PlayerStats
extends Resource

@export var HEALTH: int = 1:
	set(value):
		HEALTH = value
		health_changed.emit(value)
		if HEALTH <= 0: no_health.emit()
@export var SPEED: float = 1:
	set(value):
		SPEED = value
		stats_changed.emit()
var FINAL_SPEED: float:
	get: return (200 * SPEED)
@export var DAMAGE = 1:
	set(value):
		DAMAGE = value
		stats_changed.emit()
@export var CRIT_CHANCE = 0:
	set(value):
		CRIT_CHANCE = value
		stats_changed.emit()
@export var CRIT_DAMAGE = 0:
	set(value):
		CRIT_DAMAGE = value
		stats_changed.emit()
@export var RANGE = 1:
	set(value):
		RANGE = value
		stats_changed.emit()
@export var RATE = 1:
	set(value):
		RATE = value
		stats_changed.emit()
@export var KB_RESISTANCE: float = 1

signal stats_changed()
signal health_changed(new_value)
signal no_health()
