extends VBoxContainer

@onready var wave = $Wave
@onready var time_left = $TimeLeft

func _ready():
	self.wave.text = "Wave" + str(1)
	Global.wave_start.connect(self.update_wave)
	
func _process(_delta):
	if(Global.wave_timer):
		if(Global.wave_timer.time_left != 0):
			self.time_left.text = str(ceil(Global.wave_timer.time_left))
		else:
			self.time_left.text = "Finish"

func update_wave(new_value):
		self.wave.text = "Wave " + str(new_value)
