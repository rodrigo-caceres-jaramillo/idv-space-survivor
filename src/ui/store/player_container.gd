extends PanelContainer

@onready var health = $HBoxContainer/stats/GridContainer/Health
@onready var speed = $HBoxContainer/stats/GridContainer/Speed
var stats: PlayerStats

func _ready():
	Events.player_ready.connect(update_stats)
	Global.upgrade_resource_selected.connect(show_upgrade_stats)
	
func update_stats():
	stats = Global.player.stats
	health.set_up("Health", stats.MAX_HEALTH)
	speed.set_up("Speed", stats.SPEED)

func show_upgrade_stats(upgrade_resource):
	update_stats()
	for modifier in upgrade_resource.modifiers:
		if(modifier.stat == Modifier.Stat.HEALTH):
			health.show_upgrade(stats.MAX_HEALTH, modifier.value)
		if(modifier.stat == Modifier.Stat.SPEED):
			speed.show_upgrade(stats.SPEED, modifier.value)
