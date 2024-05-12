class_name Enemy
extends CharacterBody2D

@onready var hitbox_component:HitboxComponent = $HitboxComponent as HitboxComponent
@onready var hurtbox_component:HurtboxComponent = $HurtboxComponent as HurtboxComponent
@onready var stats_component:StatsComponent = $StatsComponent as StatsComponent
@onready var hurt_component:HurtboxComponent = $HurtComponent as HurtboxComponent

func _ready():
	hurtbox_component.hurt.connect(
		func(hitbox: HitboxComponent):
			print("enemigo golpeado")
			print(stats_component.health)
	)
	stats_component.no_health.connect(
		func():
		print("enemigo muerto")
		queue_free()
	)
