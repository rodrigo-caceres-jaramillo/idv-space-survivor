extends Label

var round_time = 0

func _process(delta):
	if(Global.timer):
		if(Global.timer.time_left != 0):
			self.text = str(ceil(Global.timer.time_left))
		else:
			self.text = "Finish"
