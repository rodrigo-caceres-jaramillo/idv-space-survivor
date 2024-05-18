extends Enemy

@export var active = false
var target: Node2D
var speed
func _ready():
	super()
	target = Global.player
	spawn_invicibility_component.spawned.connect(
		func():
			active = true
	)
	speed = stats.speed
	stats.no_health.connect(in_death)

func in_death():
	spawn_money(randi_range(stats.min_value, stats.max_value))
	queue_free()
	
func _physics_process(delta):
	if not active:
		return
	if !stun:	
		self.velocity = speed * global_position.direction_to(Global.player.global_position).normalized()
		move_and_slide()
	
