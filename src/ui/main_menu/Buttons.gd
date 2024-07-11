extends VBoxContainer

@export var char: Resource
@onready var animation_player = $"../CanvasImage/AnimationPlayer"


func _ready():
	Global.charater_resource = char
	animation_player.play("move")
	
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


func _on_test_pressed():
	if (Global.charater_resource):
		start_player()
		get_tree().change_scene_to_file("res://src/main/test/test.tscn")
