class_name StatsComponent
extends Node

@export var speed: float
@export var health: int = 1:
	set(value):
		health = value
		health_changed.emit(value)
		if health <= 0: no_health.emit()

signal health_changed(new_value)
signal no_health()
