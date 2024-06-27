extends CanvasLayer

@onready var start_game_button = $MarginContainer/StartGameButton
@export var char: Resource

func _ready():
	Global.charater_resource = char
	
func start_player():
	Global.set_up()
	
func _on_start_game_button_pressed():
	if (Global.charater_resource):
		start_player()
		get_tree().change_scene_to_file("res://src/main/main.tscn")
		
