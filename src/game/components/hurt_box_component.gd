class_name HurtboxComponent
extends Area2D

@export var is_invincible = false :
	set(value):
		is_invincible = value
		for child in get_children():
			if not child is CollisionShape2D and not child is CollisionPolygon2D: continue
			child.set_deferred("disabled", is_invincible)

@export var invincibility_duration: float = 0
var invincibility_timer: Timer = Timer.new()

func _ready():
	if(invincibility_duration > 0):
		add_child(invincibility_timer)
		invincibility_timer.timeout.connect(_on_invincibility_timeout)

func receive_hit(hitbox_component: HitboxComponent):
	if is_invincible: return
	if(invincibility_duration > 0):
		is_invincible = true
		invincibility_timer.start(invincibility_duration)
	hurt.emit(hitbox_component)

func _on_invincibility_timeout():
	is_invincible = false
	
signal hurt(hitbox)
