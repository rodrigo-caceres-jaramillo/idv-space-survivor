class_name Enemy
extends CharacterBody2D

@export var stats: EnemyStats
@onready var health_bar_component = $HealthBarComponent as HealthBarComponent
@onready var hitbox_component:HitboxComponent = $HitboxComponent as HitboxComponent
@onready var hurtbox_component:HurtboxComponent = $HurtboxComponent as HurtboxComponent
@onready var hurt_component = $HurtComponent
@onready var spawn_invicibility_component = $SpawnInvicibilityComponent as SpawnInvicibilityComponent
const money = preload("res://src/game/entities/money/money.tscn")
	
func _ready():
		hurt_component.stats = stats
		health_bar_component.initial_value = stats.health
		health_bar_component.stats = stats
		health_bar_component.start()
		
func spawn_money(value):
	var spawn_position = self.global_position
	var parent = get_tree().current_scene
	var instance = money.instantiate()
	parent.add_child(instance)
	instance.global_position = spawn_position
	instance.value = value

func _on_spawn_timer_timeout():
	hurtbox_component.is_invincible = false
