class_name HealthBarComponent
extends ProgressBar

@export var stats: EnemyStats = EnemyStats.new()
var initial_value = 10000

func start():
	self.max_value = initial_value
	self.value = initial_value
	self.visible = false
	stats.health_changed.connect(self.update_health)
	
func update_health(new_value):
	self.visible = true
	self.value = new_value
