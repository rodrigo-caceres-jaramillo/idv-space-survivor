extends ProgressBar

@onready var health_label = $HealthLabel as Label
@onready var stats_component = Global.player.stats_component
var max_health

func _ready():
	max_health = stats_component.health
	self.max_value = max_health
	self.health_label.text = (str(stats_component.health) + "/" + str(max_health))
	stats_component.health_changed.connect(self.update_health)

func update_health():
	self.value = stats_component.health
	self.health_label.text = (str(stats_component.health) + "/" + str(max_health))
