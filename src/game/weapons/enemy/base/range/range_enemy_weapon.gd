extends Sprite2D

@export var projectile: PackedScene
@export var stats: RangeEnemyWeaponStats
@export var two_hands: bool
@export var shoot_audio: AudioStream
@onready var animation_player = $AnimationPlayer
@onready var main_hand = $MainHand
@onready var second_hand = $SecondHand
@onready var tip = $Tip
@onready var fire_rate = $FireRate
@onready var spawn_projectile_component = $SpawnProjectileComponent
@onready var audio_player = $AudioPlayer
var can_shoot:bool = true

func _ready():
	fire_rate.timeout.connect(func(): can_shoot = true)
	spawn_projectile_component.projectile_scene = projectile
	audio_player.stream = shoot_audio

func set_up(hand_texture):
	self.main_hand.texture = hand_texture
	if two_hands: self.second_hand.texture = hand_texture

func attack():
	if can_shoot:
		audio_player.play()
		var direction = global_position.direction_to(tip.global_position)
		animation_player.play("shot")
		spawn_projectile_component.spawn_projectile(stats, direction, global_rotation, tip.global_position)
		self.can_shoot = false
		fire_rate.start(1.0/stats.FIRE_RATE)