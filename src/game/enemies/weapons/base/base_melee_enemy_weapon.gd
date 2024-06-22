extends Sprite2D

@onready var animation_player = $AnimationPlayer
@onready var hitbox_component = $HitboxComponent
@onready var hand_sprite = $HandSprite
@onready var attack_rate = $AttackRate
@export var stats: MeleeWeaponStats
var can_attack= true

func _ready():
	attack_rate.timeout.connect(func(): can_attack = true)
	
func set_up(hand_texture):
	hitbox_component.is_active = false
	hitbox_component.damage = stats.DAMAGE
	hitbox_component.damage_type = stats.DAMAGE_TYPE
	hand_sprite.texture = hand_texture
	
func attack():
	if(can_attack):
		hitbox_component.is_active = true
		attack_rate.start(stats.ATTACK_RATE)
		animation_player.play("attack")
		await animation_player.animation_finished
		hitbox_component.is_active = false

