extends VBoxContainer

func _on_start_button_pressed():
	get_tree().change_scene("res://Main.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
