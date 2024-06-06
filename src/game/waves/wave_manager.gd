class_name WaveManager
extends Node2D

@export var game_data: GameData
var wave_data:WaveData
var spawn_timer:Timer = Timer.new()
var wave_container: Node = Node.new()
var max_enemies = 10
var wave_timer:Timer = Timer.new()
var current_wave = 1

func _ready():
	add_child(spawn_timer)
	add_child(wave_timer)
	Global.wave_timer = wave_timer
	wave_timer.one_shot = true
	add_child(wave_container)
	Global.wave_container = wave_container
	spawn_timer.timeout.connect(spawn_group)
	wave_timer.timeout.connect(finish_wave)
	Global.start_wave.connect(start_next_wave)
	
func start_first_wave():
	self.wave_data = game_data.waves_data[0]
	self.max_enemies = wave_data.max_enemies
	spawn_timer.start(wave_data.wave_intensity)
	wave_timer.start(wave_data.wave_duration)
	Global.wave_start.emit(self.current_wave)
	
func start_next_wave():
	self.wave_data = game_data.waves_data[self.current_wave]
	self.current_wave += 1
	self.max_enemies = wave_data.max_enemies
	wave_timer.start(wave_data.wave_duration)
	spawn_timer.start(wave_data.wave_intensity)
	Global.wave_start.emit(self.current_wave)

func finish_wave():
	spawn_timer.stop()
	wave_container.queue_free()
	self.wave_container = Node.new()
	add_child(wave_container)
	Global.wave_container = wave_container
	Global.wave_finished.emit()
	print(game_data.waves_data.size())
	print(current_wave)
	if game_data.waves_data.size() == current_wave :
		get_tree().change_scene_to_file("res://src/ui/gameover/game_over.tscn") 
	
func spawn_group():
	for wave_enemy in wave_data.wave_enemies:
		self.spawn_enemy(wave_enemy)

func spawn_enemy(wave_enemy):
	for spawn in wave_enemy.quantity:
		if(max_enemies > self.wave_container.get_child_count()):
			var enemy = wave_enemy.enemy_scene.instantiate()
			wave_container.add_child(enemy)
			enemy.global_position = self.get_spawn_position()
		
func get_spawn_position():
	return Vector2(randf_range(-260, 1080), randf_range(-160, 640))


	
