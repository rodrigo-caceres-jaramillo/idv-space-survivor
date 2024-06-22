extends ColorRect

var max_health
func _ready():
	self.max_health = Global.player.stats.MAX_HEALTH
	self.check_low_health(Global.player.stats.HEALTH)
	Global.player.stats.max_health_changed.connect(func (value): self.max_health = value)
	Global.player.stats.health_changed.connect(self.check_low_health)

func check_low_health(value):
	var twentyPercentOfMax = max_health * 0.3
	if(value < twentyPercentOfMax):
		show()
	if(value > twentyPercentOfMax):
		hide()
