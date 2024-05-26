extends VBoxContainer

@onready var wave = $Wave
@onready var time_left = $TimeLeft

func _ready():
	self.wave.text = "Wave" + str(Global.wave)
	Global.wave_changed.connect(self.update_wave)
	
func _process(delta):
	if(Global.timer):
		if(Global.timer.time_left != 0):
			self.time_left.text = str(ceil(Global.timer.time_left))
		else:
			self.time_left.text = "Finish"

func update_wave(new_value):
		self.wave.text = "Wave" + str(new_value)
