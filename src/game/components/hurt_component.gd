class_name HurtComponent
extends Node

@export var stats_component: StatsComponent
@export var hurtbox_component: HurtboxComponent
@export var sprite: Sprite2D
@export var flash_duration: = 0.1
@export var show_number = true
var original_sprite_material: Material
var timer: Timer = Timer.new()
const FLASH_MATERIAL = preload("res://src/game/effects/white_flash_material.tres")
var damage_color = "#FFF"
var critical_color = Color.YELLOW

func _ready() -> void:
	add_child(timer)
	hurtbox_component.hurt.connect(apply_damage	)
	
func apply_damage(damage, critical):
	stats_component.health -= damage
	if(show_number):
		show_damage_numbers(damage, critical)
	sprite.material = FLASH_MATERIAL
	timer.start(flash_duration)
	await timer.timeout
	sprite.material = null
	
func show_damage_numbers(value, critical):
	var label = Label.new()
	label.global_position = self.sprite.global_position
	label.text = str(value)
	label.z_index = 5
	label.label_settings = LabelSettings.new()
	label.label_settings.outline_color = Color.BLACK
	label.label_settings.outline_size = 1
	if(critical):
		label.label_settings.font_color = critical_color
	else:
		label.label_settings.font_color = damage_color
	add_child(label)
	
	var twenn = get_tree().create_tween()
	twenn.set_parallel(true)
	twenn.tween_property(
		label, "position:y", label.position.y - 10, 0.2
	).set_ease(Tween.EASE_OUT)
	twenn.tween_property(
		label, "position:y", label.position.y, 0.5
	).set_ease(Tween.EASE_IN).set_delay(0.2)
	twenn.tween_property(
		label, "scale", Vector2.ZERO, 0.2
	).set_ease(Tween.EASE_IN).set_delay(0.5)
	
	await twenn.finished
	label.queue_free()
