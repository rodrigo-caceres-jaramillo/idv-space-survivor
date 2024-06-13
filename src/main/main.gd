extends Node2D

@onready var wave_manager = $WaveManager
@onready var tile_map = $TileMap
var start_position= Vector2(693, 403)
@onready var phantom_camera_2d = $PhantomCamera2D

func _ready():
	print("START GAME")
	var player = Global.player
	add_child(Global.pick_up_container)
	add_child(player)
	phantom_camera_2d.follow_target = player
	player.global_position = start_position
	start_game()
	
func start_game():
	Events.player_ready.emit()
	wave_manager.start_wave()

