extends Node
onready var spawn_timer = $SpawnTimer
var enemy_scene = preload("res://src/game/entities/enemies/Minion.tscn")
onready var round_timer = $"../RoundTimer"

func _ready():
	spawn_timer.start()

func _on_SpawnTimer_timeout():
	var enemy_position = Vector2(rand_range(0, 1500), rand_range(0, 1500))
	var enemy = enemy_scene.instance()
	add_child(enemy)
	enemy.position = enemy_position


func _on_RoundTimer_ready():
	print("Comienza la ronda")
	_ready()


func _on_RoundTimer_timeout():
	print("Termina la ronda")
	spawn_timer.stop()
	for enemy in get_children():
		enemy.queue_free() 
	
