extends CharacterBody2D

@export var damage_mul = 1
@export var range_mul = 1
@export var rate_mul = 1
@onready var weapon = $Weapon
@onready var hurtbox_component = $HurtboxComponent as HurtboxComponent
@onready var stats_component = $StatsComponent as StatsComponent

func _ready():
	hurtbox_component.hurt.connect(
		func(hitbox: HitboxComponent):
			print("player golpeado")
			print(stats_component.health)
	)
	stats_component.no_health.connect(
		func():
		print("player muerto")
		queue_free()
	)
	Global.player = self
	
func _process(delta):
	self.aim_and_shoot()

func aim_and_shoot():
	var mouse_position:Vector2 = get_global_mouse_position()
	weapon.look_at(mouse_position)
	if Input.is_action_pressed("fire_weapon"):
		weapon.fire(damage_mul)