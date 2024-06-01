extends Button

func _on_pressed():
	Global.start_wave.emit()
