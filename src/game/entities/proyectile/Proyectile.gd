extends Sprite2D

@onready var move_to_direction_component = $MoveToDirectionComponent as MoveToDirectionComponent
@onready var life_time = $LifeTime
@onready var hitbox_component = $HitboxComponent as HitboxComponent
var damage
var range

func _ready():
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))

func initialize(damage, range, direction:Vector2):
	self.damage = damage
	self.range = damage
	hitbox_component.damage = damage
	move_to_direction_component.direction = direction
	life_time.start(range)

func _on_life_time_timeout():
	get_parent().remove_child(self)
	queue_free()
