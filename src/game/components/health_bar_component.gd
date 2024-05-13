class_name HealthBarComponent
extends ProgressBar

@export var stats_component: StatsComponent
var show

func _ready():
	self.max_value = stats_component.health
	self.value = stats_component.health
	self.visible = false
	stats_component.health_changed.connect(func():
		self.visible = true
		print("health")
		self.value = (stats_component.health)
	)
