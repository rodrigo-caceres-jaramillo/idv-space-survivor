class_name HitboxComponent
extends Area2D

@export var damage = 1.0
@export var is_active = true :
	set(value):
		is_active = value
		for child in get_children():
			if not child is CollisionShape2D and not child is CollisionPolygon2D: continue
			child.set_deferred("disabled", !is_active)
			
func _ready():
	area_entered.connect(_on_hurtbox_entered)

func _on_hurtbox_entered(hurtbox: HurtboxComponent):
	if not hurtbox is HurtboxComponent: return
	if hurtbox.is_invincible: return
	hit_hurtbox.emit(hurtbox)
	hurtbox.hurt.emit(self)

signal hit_hurtbox(hurtbox)
