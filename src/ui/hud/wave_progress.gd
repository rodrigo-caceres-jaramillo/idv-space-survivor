extends VBoxContainer

@onready var wave = $Wave
@onready var time_left = $TimeLeft

func _ready():
	self.wave.text = "Wave" + str(1)
	Events.wave_started.connect(self.update_wave)
	
func _process(_delta):
	if(Global.wave_timer):
		if(Global.wave_timer.time_left != 0):
			update_color(Global.wave_timer.time_left)
			self.time_left.text = str(ceil(Global.wave_timer.time_left))
		else:
			self.time_left.text = "Finish"
			time_left.set("theme_override_colors/font_color", Color.WHITE)

func update_color(time_check):
	if(time_check < 6):
		var red = Color(1, 0, 0)
		time_left.set("theme_override_colors/font_color", red)
		
func update_wave(new_value):
		self.wave.text = "Wave " + str(new_value)
		
