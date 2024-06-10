class_name HurtComponent
extends Node

@export var hit_player_sfx: AudioStream 
@export var player_sfx : AudioStreamPlayer

@export var hurtbox_component: HurtboxComponent
@export var sprite: Sprite2D
@export var actor: CharacterBody2D
@export var flash_duration: = 0.1
@export var show_number = true
var stats
var original_sprite_material: Material
var timer: Timer = Timer.new()
var stun_timer: Timer = Timer.new()
const FLASH_MATERIAL = preload("res://src/game/effects/white_flash_material.tres")
var damage_color = "#FFF"
var critical_color = Color.YELLOW

func _ready() -> void:
	add_child(timer)
	add_child(stun_timer)
	stun_timer.timeout.connect(func(): actor.stun= false)
	hurtbox_component.hurt.connect(apply_damage	)
	
func apply_damage(hitbox: HitboxComponent):
	var damage = hitbox.damage
	if(!actor.stun):
		apply_knockback(hitbox)
	if(hitbox.damage_type == stats.HEALTH_TYPE.resistance):
		damage *= 0.75
	if(hitbox.damage_type == stats.HEALTH_TYPE.weakness):
		damage *= 1.25
	_audio_player(hit_player_sfx)
	var is_critical = false
	if randi_range (1, 100) <= hitbox.crit_chance:
		is_critical = true
		damage *= hitbox.crit_damage
	stats.HEALTH -= damage
	if(show_number):
		show_damage_numbers(damage, is_critical)
	sprite.material = FLASH_MATERIAL
	timer.start(flash_duration)
	await timer.timeout
	sprite.material = null
	
func apply_knockback(hitbox):
	var knockback = hitbox.knockback - stats.KB_RESISTANCE
	if (knockback > 0): 
		actor.stun = true
		stun_timer.start(0.05 * knockback)
		var direction = (actor.global_position - hitbox.global_position).normalized()
		actor.velocity = -direction * knockback * 10
		actor.move_and_slide()
	
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
	await get_tree().create_timer(0.5).timeout
	label.queue_free()

func _audio_player(audio:AudioStream):
	player_sfx.stream = audio
	player_sfx.play()
