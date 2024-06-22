class_name WaveManager
extends Node2D

@export var game_data: GameData
@onready var wave_timer = $WaveTimer
@onready var spawn_timer = $SpawnTimer
@onready var enemies_container = $EnemiesContainer
var wave_data: WaveData
var current_wave = 1

func _ready():
	Global.wave_timer = wave_timer
	spawn_timer.timeout.connect(spawn_group)
	wave_timer.timeout.connect(finish_wave)
	Events.start_next_wave.connect(start_wave)
	
func start_wave():
	self.wave_data = game_data.waves_data[current_wave-1]
	spawn_timer.start(wave_data.wave_intensity)
	wave_timer.start(wave_data.wave_duration)
	Events.wave_started.emit(current_wave)

func finish_wave():
	spawn_timer.stop()
	Events.wave_finished.emit(current_wave)
	if game_data.waves_data.size() == current_wave :
		Events.game_finish.emit()
	self.current_wave += 1
	
func spawn_group():
	for wave_enemy in wave_data.wave_enemies:
		self.spawn_enemy(wave_enemy)

func spawn_enemy(wave_enemy):
	for spawn in wave_enemy.quantity:
		if(wave_data.max_enemies > self.enemies_container.get_child_count()):
			var enemy = wave_enemy.enemy_scene.instantiate()
			enemies_container.add_child(enemy)
			enemy.global_position = self.get_spawn_position()
		
func get_spawn_position():
	return Vector2(randf_range(16, 624), randf_range(-40, 336))
