extends Node2D

@onready var wave_manager = $WaveManager
@onready var tile_map = $TileMap
var start_position= Vector2(693, 403)

func _ready():
	var player = Global.player
	add_child(Global.pick_up_container)
	add_child(player)
	player.global_position = start_position
	start_game()
	
func start_game():
	wave_manager.start_wave()

