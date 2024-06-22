class_name HealthBarComponent
extends TextureProgressBar

var stats
var initial_value = 10000

func start():
	self.max_value = stats.HEALTH
	self.value = stats.HEALTH
	self.visible = false
	stats.health_changed.connect(self.update_health)
	
func update_health(new_value):
	self.visible = true
	self.value = new_value
