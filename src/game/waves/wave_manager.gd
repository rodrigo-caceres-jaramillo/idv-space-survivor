class_name WaveManager
extends Node2D

var wave_data:WaveData
var wave_timer:Timer
var spawn_timer:Timer = Timer.new()
var wave_container:Node
var tile_map: TileMap
var max_enemies = 10

func _ready():
	add_child(spawn_timer)
	
func start_wave(_wave_data: WaveData, _wave_timer: Timer, _tile_map: TileMap):
	self.wave_container = Node.new()
	add_child(wave_container)
	self.wave_data = _wave_data
	self.wave_timer = _wave_timer
	self.tile_map = _tile_map
	self.max_enemies = _wave_data.max_enemies
	spawn_timer.timeout.connect(spawn_group)
	spawn_timer.start(_wave_data.wave_intensity)
	wave_timer.timeout.connect(clean_wave)
	
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

func clean_wave():
	wave_container.queue_free()
	
