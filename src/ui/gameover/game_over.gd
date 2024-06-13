extends Panel

@onready var last_wave = $LastWave

func _ready():
	self.last_wave.text = "Last Wave: " + str(1)
	Events.wave_started.connect(self.update_wave)

func update_wave(wave_number):
	last_wave.text = "Last Wave: "+ str(wave_number)

func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/ui/main_menu/main_menu.tscn")
	
func _on_try_again_button_pressed():
	Global.set_up()
	get_tree().paused = false
	get_tree().reload_current_scene()

