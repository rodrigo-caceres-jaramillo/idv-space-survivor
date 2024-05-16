class_name HitboxComponent
extends Area2D

@export var damage: int = 1
@export var critical = false
@export var check_interval: float = 0.1
@export var is_active = true :
	set(value):
		is_active = value
		for child in get_children():
			if not child is CollisionShape2D and not child is CollisionPolygon2D: continue
			child.set_deferred("disabled", !is_active)
var check_timer: Timer = Timer.new()

func _ready():
	add_child(check_timer)
	check_timer.wait_time = check_interval
	check_timer.timeout.connect(on_check_timer_timeout)
	check_timer.start()
	
	area_entered.connect(on_hurtbox_entered)

func on_check_timer_timeout():
	for overlapping_area in get_overlapping_areas():
		on_hurtbox_entered(overlapping_area)

func on_hurtbox_entered(hurtbox: HurtboxComponent):
	if not hurtbox is HurtboxComponent: return
	if hurtbox.is_invincible: return
	hurtbox.receive_hit(damage, critical)

signal hit_hurtbox(hurtbox)
