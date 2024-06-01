extends Node2D

@onready var player = $Player
@onready var wave_manager = $WaveManager
@onready var tile_map = $TileMap

func _ready():
	Global.player = player
	start_game()
	
func start_game():
	wave_manager.start_first_wave()

