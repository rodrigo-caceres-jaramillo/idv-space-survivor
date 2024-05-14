class_name SpawnInvicibilityComponent
extends Node

@export var hurtbox_component: HurtboxComponent
@export var hitbox_component: HitboxComponent
@export var spawn_duration = 10.0
var timer: Timer = Timer.new()

func _ready():
	add_child(timer)
	hurtbox_component.is_invincible = true
	hitbox_component.is_active = false
	timer.start(spawn_duration)
	await timer.timeout
	hurtbox_component.is_invincible = false
	hitbox_component.is_active = true
	spawned.emit()
	
signal spawned()
