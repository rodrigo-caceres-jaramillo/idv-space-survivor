class_name CharacterStats
extends Resource

@export var HP: int = 1:
	set(value):
		HP = value
		health_changed.emit(value)
		if HP <= 0: no_health.emit()
@export var SPEED: float = 1
@export var knockback_resistance: float = 1

signal health_changed(new_value)
signal no_health()
