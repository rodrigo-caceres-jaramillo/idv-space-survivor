extends Control


func _ready():
	show()
	# hide() # ???

func _on_try_again_button_pressed():
	hide() # implementare
	 


func _on_main_menu_button_pressed():
	get_tree().change_scene("res://src/ui/main_menu/main_menu.tscn") # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()
