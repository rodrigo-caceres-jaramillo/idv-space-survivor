extends Enemy

@onready var move_to_target_component = $MoveToTargetComponent

func _ready():
	super()
	move_to_target_component.target = Global.player
	spawn_invicibility_component.spawned.connect(
		func():
			move_to_target_component.active = true
	)
	print(stats.speed)
	print(stats.health)
	move_to_target_component.speed = stats.speed
	stats.no_health.connect(in_death)

func in_death():
	spawn_money(10)
	queue_free()
	
