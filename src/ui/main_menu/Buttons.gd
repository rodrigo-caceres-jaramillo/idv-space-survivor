extends VBoxContainer

@export var char: Resource


func _ready():
	Global.charater_resource = char
	
func start_player():
	Global.set_up()

func _on_start_button_pressed():
	if (Global.charater_resource):
		start_player()
		get_tree().change_scene_to_file("res://src/main/main.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_options_button_pressed():
	get_tree().show()
