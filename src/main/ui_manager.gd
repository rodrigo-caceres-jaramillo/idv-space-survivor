extends Node2D

@onready var store = $Store
@onready var ui_layer = $UiLayer
@onready var game_over = $GameOver

func _ready():
	Global.wave_finished.connect(show_store)
	Global.start_wave.connect(show_ui)
	Global.player.stats.no_health.connect(show_game_over)
	
func show_store():
	get_tree().paused = true
	ui_layer.hide()
	store.show()

func show_ui():
	get_tree().paused = false
	ui_layer.show()
	store.hide()
	
func show_game_over():
	get_tree().paused = true
	ui_layer.hide()
	game_over.show()
