extends Button

func _ready():
	Events.wave_finished.connect(update_wave)

func _on_pressed():
	Events.start_next_wave.emit()

func update_wave(wave):
	if( wave != 4):
		self.text = "START WAVE ( " + str(wave+1) + " / 5 )"
	else:
		self.text = "START FINAL WAVE"
	
