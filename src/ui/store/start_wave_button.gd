extends Button

func _on_pressed():
	Events.start_next_wave.emit()
