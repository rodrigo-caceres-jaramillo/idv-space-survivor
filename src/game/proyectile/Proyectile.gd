class_name Projectile
extends Sprite2D

@onready var life_time = $LifeTime
@onready var hitbox_component = $HitboxComponent
var speed
var dir

func _ready():
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))

func initialize(stats, direction):
	hitbox_component.crit_chance = stats.crit_chance
	hitbox_component.damage = stats.damage
	hitbox_component.crit_damage = stats.crit_damage
	self.speed = stats.projectile_speed
	self.dir = direction
	life_time.start(stats.range)

func _process(delta):
	self.position += dir * speed * delta

func _on_life_time_timeout():
	get_parent().remove_child(self)
	queue_free()
