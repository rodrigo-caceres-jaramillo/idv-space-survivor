extends Sprite

onready var life_time = $LifeTime

export (float) var VELOCITY:float = 500.0
var DAMAGE=0
var container = null
var direction:Vector2

func initialize(damage, container, spawn_position:Vector2, direction:Vector2):
	container = container
	DAMAGE=damage
	container.add_child(self)
	self.direction = direction
	global_position = spawn_position
	life_time.start()

func _physics_process(delta):
	position += direction * VELOCITY * delta
	
func attack():
	self.remove()
	return self.DAMAGE
	
func remove():
	get_parent().remove_child(self)
	queue_free()

func _on_LifeTime_timeout():
	remove()
