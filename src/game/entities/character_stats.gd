class_name CharacterStats
extends Resource

@export var health: int = 1:
	set(value):
		health = value
		health_changed.emit(value)
		if health <= 0: no_health.emit()
@export var speed: int = 50

signal health_changed(new_value)
signal no_health()
