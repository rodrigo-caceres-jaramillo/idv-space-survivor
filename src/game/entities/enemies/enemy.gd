class_name Enemy
extends CharacterBody2D

@onready var hitbox_component:HitboxComponent = $HitboxComponent as HitboxComponent
@onready var hurtbox_component:HurtboxComponent = $HurtboxComponent as HurtboxComponent
@onready var stats_component:StatsComponent = $StatsComponent as StatsComponent
@onready var hurt_component:HurtComponent = $HurtComponent as HurtComponent
@onready var spawn_invicibility_component = $SpawnInvicibilityComponent as SpawnInvicibilityComponent
const money = preload("res://src/game/entities/money/money.tscn")

func _ready():
	hurtbox_component.hurt.connect(
		func(hitbox: HitboxComponent):
			print("enemigo golpeado")
			print(stats_component.health)
	)
	stats_component.no_health.connect(queue_free)

func spawn_money(value):
	var spawn_position = self.global_position
	var parent = get_tree().current_scene
	var instance = money.instantiate()
	parent.add_child(instance)
	instance.global_position = spawn_position
	instance.value = value

func _on_spawn_timer_timeout():
	hurtbox_component.is_invincible = false
