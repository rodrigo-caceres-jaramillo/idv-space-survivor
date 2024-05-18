class_name Projectile
extends Sprite2D

@onready var life_time = $LifeTime
@onready var hitbox_component = $HitboxComponent
var speed
var dir

func _ready():
	hitbox_component.hit_hurtbox.connect(queue_free)
	life_time.timeout.connect(queue_free)
	
func initialize(stats, direction):
	hitbox_component.crit_chance = stats.crit_chance
	hitbox_component.damage = stats.damage
	hitbox_component.crit_damage = stats.crit_damage
	hitbox_component.knockback = stats.knockback
	self.speed = stats.projectile_speed
	self.dir = direction
	life_time.start(stats.range)

func _process(delta):
	self.position += dir * speed * delta
