extends Enemy

var active = false

func _ready():
	super()
	spawn_invicibility_component.spawned.connect(
		func():
			active = true
	)
	stats.no_health.connect(in_death)

func in_death():
	spawn_money(randi_range(stats.min_value, stats.max_value))
	queue_free()
