extends Node

onready var spawn_timer = $SpawnTimer
onready var round_timer = $RoundTimer
var enemy_scene = preload("res://src/game/entities/enemies/Minion.tscn")

func _ready():
	spawn_timer.start()

func _on_SpawnTimer_timeout():
	var enemy_position = Vector2(rand_range(0, 1500), rand_range(0, 1500))
	Global.instance_wave_node(enemy_scene, enemy_position)

func _on_RoundTimer_ready():
	print("Comienza la ronda")
	_ready()

func _on_RoundTimer_timeout():
	spawn_timer.stop()
	for enemy in Global.wave_container.get_children():
		enemy.queue_free()
	print("Termina la ronda")

	
