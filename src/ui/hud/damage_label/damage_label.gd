extends Label

var damage_color = "#FFF"
var critical_color = Color.YELLOW

func _ready():
	pass
	
func set_up(value, critical, effectiveness):
	if(effectiveness == 1):
		self.text = str(snapped(value, 1)) + "!"
	elif (effectiveness == -1):
		self.text = str(snapped(value, 1)) + "-"
	else:
		self.text = str(snapped(value, 1))
	if(critical):
		self["theme_override_colors/font_color"] = Color.YELLOW
	else:
		self["theme_override_colors/font_color"] = Color.WHITE
	
	await get_tree().create_timer(0.5).timeout
	self.queue_free()
