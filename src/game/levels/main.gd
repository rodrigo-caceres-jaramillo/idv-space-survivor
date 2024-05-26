extends Node2D

@onready var player = $Player
@export var game_data: GameData
@onready var wave_manager = $WaveManager
@onready var tile_map = $TileMap
var wave_timer:Timer = Timer.new()
var wave_container:Node = Node.new()

func _ready():
	Global.player = player
	Global.timer = wave_timer
	add_child(wave_container)
	Global.wave_container = wave_container
	add_child(wave_timer)
	var wave_1 = game_data.waves_data[0]
	wave_timer.one_shot = true
	wave_timer.start(wave_1.wave_duration)
	wave_manager.start_wave(wave_1, tile_map)
	wave_timer.timeout.connect(start_next_wave)
	
func start_next_wave():
	wave_manager.clean_wave()
	Global.next_wave()
	var next_wave_container = Node.new()
	add_child(next_wave_container)
	Global.wave_container = next_wave_container
	var next_wave = game_data.waves_data[Global.wave-1]
	wave_timer.start(next_wave.wave_duration)
	wave_manager.start_wave(next_wave, tile_map)

