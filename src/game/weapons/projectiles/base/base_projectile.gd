class_name Projectile
extends Sprite2D

@onready var hitbox_component = $HitboxComponent
var speed
var direction := Vector2.ZERO
var max_distance
var traveled_distance := 0.0
var max_penetration
var enemies_penetrated := 0

func _ready():
	set_as_top_level(true)
	hitbox_component.hit_hurtbox.connect(check_penetration)
	hitbox_component.hit_hurtbox.connect(func(): Events.projectile_impacted.emit(global_position, direction))
	
func _process(delta):
	var move_vector = direction * speed * delta
	self.position += move_vector
	traveled_distance += move_vector.length()
	
	if traveled_distance >= max_distance:
		queue_free()
		
	look_at(position + direction)
	
func initialize(stats, _global_position, _direction):
	self.global_position = _global_position
	hitbox_component.damage = stats.DAMAGE
	hitbox_component.damage_type = stats.DAMAGE_TYPE
	hitbox_component.crit_chance = stats.CRITICAL_CHANCE 
	hitbox_component.crit_damage = stats.CRITICAL_DAMAGE
	hitbox_component.knockback = stats.KNOCKBACK
	self.speed = stats.PROJECTILE_SPEED
	self.direction = _direction
	self.max_penetration = stats.PENETRATION
	self.max_distance = (stats.RANGE * 5)
	
func check_penetration():
	if(max_penetration == 0):
		queue_free()
	else:
		enemies_penetrated += 1
		if(max_penetration < enemies_penetrated):
			queue_free()


