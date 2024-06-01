class_name StoreUpgrade
extends StoreResource

enum Effect {
	HP, RATE, DAMAGE, RANGE, HEALTH, SPEED
}

@export var plus_effect: Effect
@export var plus: float
@export var minus_effect: Effect
@export var minus: float
