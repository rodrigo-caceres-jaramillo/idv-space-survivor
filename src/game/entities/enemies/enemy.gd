class_name Enemy
extends CharacterBody2D

@export var stats: EnemyStats
@onready var health_bar_component = $HealthBarComponent as HealthBarComponent
@onready var hitbox_component:HitboxComponent = $HitboxComponent as HitboxComponent
@onready var hurtbox_component:HurtboxComponent = $HurtboxComponent as HurtboxComponent
@onready var hurt_component = $HurtComponent
@onready var spawn_invicibility_component = $SpawnInvicibilityComponent as SpawnInvicibilityComponent
@export var money = preload("res://src/game/entities/money/money.tscn")
var stun = false

func _ready():
		hurt_component.stats = stats
		health_bar_component.initial_value = stats.health
		health_bar_component.stats = stats
		health_bar_component.start()
		hitbox_component.damage = stats.damage
		
func spawn_money(value):
	var spawn_position = self.global_position
	var parent = Global.wave_container
	var instance = money.instantiate()
	instance.global_position = spawn_position
	instance.value = value
	parent.call_deferred("add_child", instance)

func _on_spawn_timer_timeout():
	hurtbox_component.is_invincible = false
