class_name HurtboxComponent
extends Area2D

@export var is_invincible = false :
	set(value):
		is_invincible = value
		set_deferred("monitorable",!value)
		set_deferred("monitoring",!value)

@export var invincibility_duration: float = 0
var invincibility_timer: Timer = Timer.new()

func _ready():
	if(invincibility_duration > 0):
		add_child(invincibility_timer)
		invincibility_timer.timeout.connect(_on_invincibility_timeout)

func receive_hit(hitbox):
	if is_invincible: return
	if(invincibility_duration > 0):
		is_invincible = true
		invincibility_timer.start(invincibility_duration)
	self.hurt.emit(hitbox)

func _on_invincibility_timeout():
	is_invincible = false
	
signal hurt(hitbox: HitboxComponent)


