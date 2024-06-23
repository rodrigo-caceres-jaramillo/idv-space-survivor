class_name EnemyStats
extends Resource

@export var HEALTH: int = 1:
	set(value):
		HEALTH = value
		health_changed.emit(value)
		if HEALTH <= 0: no_health.emit()
@export var HEALTH_TYPE: HealthType
@export var SPEED: float = 1
var FINAL_SPEED: float:
	get: return (100 * SPEED)
@export var KB_RESISTANCE: float = 1
@export var min_value: int = 1
@export var max_value: int = 2

signal health_changed(new_value)
signal no_health()
