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
const FLASH_MATERIAL = preload("res://src/game/effects/white_flash_material.tres")

func _ready() -> void:
	add_child(timer)
	hurtbox_component.hurt.connect(apply_damage	)
	
func apply_damage(hitbox: HitboxComponent):
	var damage = hitbox.damage
	var impact_position = hitbox.global_position
	var effectiveness = 0 #-1: ineffective 0: neutral 1: effective
	if(hitbox.damage_type == stats.HEALTH_TYPE.resistance):
		damage *= 0.75
		effectiveness = -1
	if(hitbox.damage_type == stats.HEALTH_TYPE.weakness):
		damage *= 1.25
		effectiveness = 1
	_audio_player(hit_player_sfx)
	var is_critical = false
	if randi_range (1, 100) <= hitbox.crit_chance:
		is_critical = true
		damage *= hitbox.crit_damage
	sprite.material = FLASH_MATERIAL
	timer.start(flash_duration)
	await timer.timeout
	sprite.material = null
	Events.damage_take.emit(impact_position, damage, is_critical, effectiveness)
	stats.HEALTH -= damage

func _audio_player(audio:AudioStream):
	player_sfx.stream = audio
	player_sfx.play()
