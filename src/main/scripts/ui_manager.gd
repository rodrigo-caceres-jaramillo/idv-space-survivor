extends Node2D

@onready var pause_menu = $PauseMenu
@onready var store = $Store
@onready var ui_layer = $UiLayer
@onready var game_over = $GameOver
var paused = false
const CROSSHAIR = preload("res://assets/textures/hud/crooshair/crosshair.png")

func _ready():
	Events.wave_finished.connect(show_store.unbind(1))
	Events.wave_started.connect(show_ui.unbind(1))
	Global.player.stats.no_health.connect(show_game_over)
	Events.game_finish.connect(show_game_finish.unbind(1))
	Input.set_custom_mouse_cursor(CROSSHAIR, Input.CURSOR_ARROW, Vector2(8,8))

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		show_pause_menu()
		
func show_pause_menu():
	if(paused):
		pause_menu.hide()
		get_tree().paused = false
	else:
		pause_menu.show()
		get_tree().paused = true
	paused = !paused
	
func show_game_finish():
	show_game_over()
	store.hide()
	
func show_store():
	await get_tree().create_timer(2).timeout
	get_tree().paused = true
	ui_layer.hide()
	store.show()
	Input.set_custom_mouse_cursor(null)

func show_ui():
	get_tree().paused = false
	ui_layer.show()
	store.hide()
	Input.set_custom_mouse_cursor(CROSSHAIR, Input.CURSOR_ARROW, Vector2(8,8))
	
func show_game_over():
	get_tree().paused = true
	ui_layer.hide()
	store.hide()
	game_over.show()
	Input.set_custom_mouse_cursor(null)
