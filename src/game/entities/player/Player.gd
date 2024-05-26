extends CharacterBody2D

@onready var hurt_component = $HurtComponent
@export var stats: PlayerStats
@onready var hurtbox_component = $HurtboxComponent as HurtboxComponent
@onready var weapon_container = $WeaponContainer
@onready var move_input_component = $MoveInputComponent
var stun = false

func _ready():
	hurt_component.stats = stats
	move_input_component.speed = stats.speed
	stats.no_health.connect(
		func():
		queue_free()
	)
	Global.player = self
	
func _process(delta):
	var mouse_position:Vector2 = get_global_mouse_position()
	weapon_container.look_at(mouse_position)
	if Input.is_action_pressed("fire_weapon"):
		weapon_container.shoot_weapon()
	
