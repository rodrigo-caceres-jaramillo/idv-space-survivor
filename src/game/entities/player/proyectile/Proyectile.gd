extends Sprite

onready var life_time = $LifeTime

export (float) var VELOCITY:float = 500.0

var direction:Vector2

func initialize(container, spawn_position:Vector2, direction:Vector2):
	container.add_child(self)
	self.direction = direction
	global_position = spawn_position
	life_time.start()

func _physics_process(delta):
	position += direction * VELOCITY * delta

func _remove():
	get_parent().remove_child(self)
	queue_free()

func _on_LifeTime_timeout():
	_remove()
