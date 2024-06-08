extends CanvasLayer

@onready var start_game_button = $MarginContainer/StartGameButton
@export var char: Resource
func _ready():
	Global.charater_resource = char
	
func start_player():
	var resource = Global.charater_resource
	var player = resource.character_scene.instantiate()
	player.stats = resource.stats
	player.initial_weapon = resource.initial_weapon
	Global.player = player
	
func _on_start_game_button_pressed():
	if (Global.charater_resource):
		print("Start")
		start_player()
		get_tree().change_scene_to_file("res://src/main/main.tscn")
		
