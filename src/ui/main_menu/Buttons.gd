extends VBoxContainer

@onready var options_menu = $"../../OptionsMenu"

func _on_start_button_pressed():
	get_tree().change_scene("res://Main.tscn")

func _on_quit_button_pressed():
	get_tree().quit()


func _on_options_button_pressed():
	options_menu.show()
