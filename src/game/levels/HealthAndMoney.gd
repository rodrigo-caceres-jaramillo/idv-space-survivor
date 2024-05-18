extends VBoxContainer

@onready var health_bar = $HealthBar
@onready var health_label = $HealthBar/HealthLabel
@onready var money_label = $MoneyContainer/MoneyLabel
@onready var stats = Global.player.stats
var max_health = 1

func _ready():
	max_health = stats.health
	self.money_label.text = str(Global.money)
	self.health_bar.max_value = max_health
	self.health_bar.value = max_health
	self.health_label.text = (str(stats.health) + "/" + str(max_health))
	stats.health_changed.connect(self.update_health)
	Global.money_changed.connect(self.update_money)
	
func update_money(new_value):
	self.money_label.text = str(new_value)
	
func update_health(new_value):
	self.health_bar.value = new_value
	self.health_label.text = (str(new_value) + "/" + str(max_health))
