class_name HurtComponent
extends Node

@export var stats_component: StatsComponent
@export var hurtbox_component: HurtboxComponent
@export var sprite: Sprite2D
@export var flash_duration: = 0.1
var original_sprite_material: Material
var timer: Timer = Timer.new()
const FLASH_MATERIAL = preload("res://src/game/effects/white_flash_material.tres")

func _ready() -> void:
	add_child(timer)
	hurtbox_component.hurt.connect(func(hitbox_component: HitboxComponent):
		stats_component.health -= hitbox_component.damage
		sprite.material = FLASH_MATERIAL
		timer.start(flash_duration)
		await timer.timeout
		sprite.material = null
	)
