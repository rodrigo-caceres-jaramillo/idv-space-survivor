extends Control

onready var time_counter = $TimeCounter
onready var wave_counter = $WaveCounter

func _process(delta):
	if(Global.timer):
		if(Global.timer.time_left != 0):
			self.time_counter.text = str(ceil(Global.timer.time_left))
		else:
			self.time_counter.text = "Finish"
	wave_counter.text = "Wave " + str(Global.wave)
			
