extends Enemy

var death_sfx : AudioStream = load("res://assets/sound/kill_monster.wav")
var active = false

func _ready():
	super()
	spawn_invicibility_component.spawned.connect(
		func():
			active = true
	)
	stats.no_health.connect(in_death)

func in_death():
	_audio_enemy(death_sfx)
	spawn_money(randi_range(stats.min_value, stats.max_value))
	queue_free()
	
#func _physics_process(_delta):
#	if not active:
#		return
#	if stun:
#		move_and_slide()
