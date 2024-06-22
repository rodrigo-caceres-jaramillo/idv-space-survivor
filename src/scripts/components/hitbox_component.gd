class_name HitboxComponent
extends Area2D

@export var damage: float
@export var damage_type: DamageType
@export var crit_chance: int = 0
@export var crit_damage: float = 1
@export var knockback: float = 1
@export var check_interval: float = 0.1
@export var is_active = true :
	set(value):
		is_active = value
		set_deferred("monitorable", value)
		set_deferred("monitoring", value)
var check_timer: Timer = Timer.new()

func _ready():
	add_child(check_timer)
	check_timer.wait_time = check_interval
	check_timer.timeout.connect(on_check_timer_timeout)
	
	area_entered.connect(on_hurtbox_entered)

func on_check_timer_timeout():
	var overlapping_bodies = get_overlapping_areas()
	for overlapping_body in overlapping_bodies:
		on_hurtbox_entered(overlapping_body)
	if(overlapping_bodies.is_empty()): check_timer.stop()

func on_hurtbox_entered(hurtbox: Area2D):
	if (! hurtbox.has_method("receive_hit")): return
	hit_hurtbox.emit()
	hurtbox.receive_hit(self)
	check_timer.start()

signal hit_hurtbox()
