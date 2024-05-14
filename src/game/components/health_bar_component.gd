class_name HealthBarComponent
extends ProgressBar

@export var stats_component: StatsComponent
@onready var initial_value = stats_component.health

func _ready():
	self.max_value = initial_value
	self.value = initial_value
	self.visible = false
	stats_component.health_changed.connect(self.update_health)
	
func update_health(new_value):
	self.visible = true
	self.value = new_value
