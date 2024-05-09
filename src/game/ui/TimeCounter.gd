extends Label

var round_time = 0
	
func _process(delta):
	if(Global.timer):
d		self.text = str(ceil(Global.timer.time_left))
