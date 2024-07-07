extends Node2D

@export var upgrades: Array[Upgrade]
@export var player: Character

func add_upgrade(upgrade):
	upgrades.append(upgrade)
	apply_upgrades()
	
func apply_upgrades():
	for upgrade in upgrades:
		for modifier in upgrade.modifiers:
			match modifier.stat:
				modifier.Stat.HEALTH:
					if(!modifier.positive and modifier.value >= player.stats.MAX_HEALTH):
						player.stats.MAX_HEALTH = 1
					else:
						player.stats.MAX_HEALTH += modifier.value if modifier.positive else -modifier.value
				modifier.Stat.SPEED:
					player.stats.SPEED *= 1.0 + (modifier.value / 100.0) if modifier.positive else 1.0 - (modifier.value / 100.0)
	Events.player_stats_changed.emit()
