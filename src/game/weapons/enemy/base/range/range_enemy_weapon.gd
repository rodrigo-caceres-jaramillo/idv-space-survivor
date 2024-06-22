extends Sprite2D

@export var projectile: PackedScene
@export var stats: RangedEnemyWeaponStats
@onready var hand_sprite = $HandSprite
@onready var tip = $Tip
@onready var fire_rate = $FireRate
@onready var spawn_projectile_component = $SpawnProjectileComponent
var can_shoot:bool = true

func _ready():
	fire_rate.timeout.connect(func(): can_shoot = true)
	spawn_projectile_component.projectile_scene = projectile

func set_up(hand_texture):
	self.hand_sprite.texture = hand_texture

func attack():
	if can_shoot:
		var direction = global_position.direction_to(tip.global_position)
		spawn_projectile_component.spawn_projectile(stats, direction, global_rotation, tip.global_position)
		self.can_shoot = false
		fire_rate.start(1.0/stats.FIRE_RATE)
