class_name SpawnInvicibilityComponent
extends Node

@export var hurtbox_component: HurtboxComponent
@export var spawn_duration = 10.0
var timer: Timer = Timer.new()

func _ready():
	add_child(timer)
	hurtbox_component.is_invincible = true
	timer.start(spawn_duration)
	await timer.timeout
	hurtbox_component.is_invincible = false
	spawned.emit()
	
signal spawned()
