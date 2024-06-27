class_name EnemySpawnState
extends State

@export var spawnTime: float

func enter(_data):
	animation_player.play("idle_down")
	get_tree().create_timer(spawnTime).timeout.connect(change_to_follow)

func change_to_follow():
	state_transition.emit(self, "follow")
