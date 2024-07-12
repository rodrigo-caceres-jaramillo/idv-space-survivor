class_name EnemySummonMinionState
extends State

@export var spawnTime: float
@export var minion: PackedScene

func enter(_data):
	animation_player.play("summon_minion")
	await animation_player.animation_finished
	spawn_minion()
	change_to_follow()
	
func spawn_minion():
	var new_minion = minion.instantiate()
	add_child(new_minion)

func change_to_follow():
	state_transition.emit(self, "follow")
