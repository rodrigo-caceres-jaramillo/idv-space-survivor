extends Node2D

@export var stats: PlayerStats

func apply_upgrade(upgrade: Upgrade):
	for modifier in upgrade.modifiers:
		self.apply_modifier(modifier)
		
func apply_modifier(modifier: Modifier):
	match modifier.stat:
		modifier.Stat.HEALTH:
			stats.HP += modifier.value if modifier.positive else -modifier.value
		modifier.Stat.SPEED:
			stats.SPEED += modifier.value if modifier.positive else -modifier.value
			print(stats.SPEED)
		modifier.Stat.DAMAGE:
			stats.DAMAGE += modifier.value if modifier.positive else -modifier.value
			print(stats.DAMAGE)
		modifier.Stat.CRIT_CHANCE:
			stats.CRIT_CHANCE += modifier.value if modifier.positive else -modifier.value
		modifier.Stat.CRIT_DAMAGE:
			stats.CRIT_DAMAGE += modifier.value if modifier.positive else -modifier.value
		modifier.Stat.RANGE:
			stats.RANGE += modifier.value if modifier.positive else -modifier.value
		modifier.Stat.RATE:
			stats.RATE += modifier.value if modifier.positive else -modifier.value
