class_name  WeaponStats
extends Resource

@export var DAMAGE: float = 1.0:
	set(value):
		DAMAGE = value
		damage_changed.emit(value)
@export var RATE: float = 1.0:
	set(value):
		RATE = value
		fire_rate_changed.emit(value)
@export var CRIT_CHANCE: float = 5:
	set(value):
		CRIT_CHANCE = value
		crit_chance_changed.emit(value)
@export var CRIT_DAMAGE: float = 1.5:
	set(value):
		CRIT_DAMAGE = value
		crit_damage_changed.emit(value)
@export var RANGE: float = 20.0:
	set(value):
		RANGE = value
		range_changed.emit(value)
@export var KNOCKBACK: int = 1

signal damage_changed(new_value)
signal crit_chance_changed(new_value)
signal crit_damage_changed(new_value)
signal fire_rate_changed(new_value)
signal range_changed(new_value)
