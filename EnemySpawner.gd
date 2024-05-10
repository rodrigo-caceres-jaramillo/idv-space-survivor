extends Node

onready var spawn_timer = $SpawnTimer
onready var round_timer = $RoundTimer
var enemy_scene = preload("res://src/game/entities/enemies/Minion.tscn")
var spawn_time = 3
var round_time = 10
var enemy_spawn = 1

func _ready():
	start_wave()
	
func start_wave():
	round_timer.start(round_time)
	spawn_timer.start(spawn_time)

func spanw_enemies():
	for spawn in (self.enemy_spawn):
		var enemy_position = Vector2(rand_range(0, 1500), rand_range(0, 1500))
		Global.instance_wave_node(enemy_scene, enemy_position)

func set_next_wave():
	self.spawn_time = spawn_time * 0.8
	self.round_time += 10
	self.enemy_spawn += 1
	Global.wave += 1
	print(Global.wave)

func clean_wave():
	spawn_timer.stop()
	for enemy in Global.wave_container.get_children():
		enemy.queue_free()
	Global.player.heal_to_max()
		
func _on_SpawnTimer_timeout():
	var enemy_position = Vector2(rand_range(0, 1150), rand_range(0, 850))
	Global.instance_wave_node(enemy_scene, enemy_position)

func _on_RoundTimer_timeout():
	self.clean_wave()
	self.set_next_wave()
	self.start_wave()

	
