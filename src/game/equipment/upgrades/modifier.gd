class_name Modifier
extends Resource

enum Stat {
	HEALTH, SPEED, DAMAGE, CRITICAL_CHANCE, CRITICAL_DAMAGE, RANGE, RATE
}
@export var stat: Stat
@export var value: float
@export var positive: bool = true

