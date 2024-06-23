class_name Enemy
extends CharacterBody2D

@onready var enemy_sfx = $EnemySfx
@export var stats: EnemyStats
@export var weapon: EnemyWeapon
@export var hand_sprite: Texture
@export var money: PackedScene
@onready var health_bar_component = $HealthBarComponent as HealthBarComponent
@onready var hurtbox_component:HurtboxComponent = $HurtboxComponent as HurtboxComponent
@onready var hurt_component = $HurtComponent
@onready var attack_manager = $AttackManager
var stun = false

func _ready():
		hurt_component.stats = stats
		health_bar_component.stats = stats
		attack_manager.set_up(weapon, hand_sprite)
		health_bar_component.start()
		Events.wave_finished.connect(die.unbind(1))
		stats.no_health.connect(in_death)

func in_death():
	spawn_money(randi_range(stats.min_value, stats.max_value))
	die()

func die():
	queue_free()
	
func spawn_money(value):
	var spawn_position = self.global_position
	var parent = Global.pick_up_container
	var instance = money.instantiate()
	instance.global_position = spawn_position
	instance.value = value
	parent.call_deferred("add_child", instance)

func _on_spawn_timer_timeout():
	hurtbox_component.is_invincible = false
	
func _audio_enemy(audio:AudioStream):
	enemy_sfx.stream = audio
	enemy_sfx.play()
