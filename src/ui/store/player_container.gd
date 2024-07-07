extends PanelContainer

@onready var health = $HBoxContainer/stats/GridContainer/Health
@onready var speed = $HBoxContainer/stats/GridContainer/Speed
var stats: PlayerStats

func _ready():
	Events.player_ready.connect(update_stats)
	Events.player_stats_changed.connect(update_stats)
	Global.upgrade_resource_selected.connect(show_upgrade_stats)
	Global.weapon_resource_selected.connect(update_stats)

func set_up():
	update_stats()

func update_stats():
	health.show_stat("Health", Global.player.stats.MAX_HEALTH)
	speed.show_stat("Speed", Global.player.stats.SPEED)

func show_upgrade_stats(upgrade: Upgrade):
	update_stats()
	if(upgrade.upgrade_type == 0):
		for modifier in upgrade.modifiers:
			var factor = 1.0 + (modifier.value / 100.0) if modifier.positive else 1.0 - (modifier.value / 100.0)
			match modifier.stat:
				modifier.Stat.HEALTH:
					if(!modifier.positive and modifier.value >= Global.player.stats.MAX_HEALTH):
						health.show_upgrade(Global.player.stats.MAX_HEALTH, 1)
					else:
						var new = Global.player.stats.MAX_HEALTH + modifier.value if modifier.positive else -modifier.value
						print(Global.player.stats.MAX_HEALTH)
						print(modifier.value)
						print(new)
						health.show_upgrade(Global.player.stats.MAX_HEALTH, new)
				modifier.Stat.SPEED:
					var new = Global.player.stats.SPEED * factor
					speed.show_upgrade(Global.player.stats.SPEED, new)
