extends Node2D

@export var upgrades: Array
@export var weapon: RangeWeapon

func apply_upgrades():
	weapon.stats = weapon.base_stats.duplicate()
	for upgrade in upgrades:
		for modifier in upgrade.modifiers:
			var factor = 1.0 + (modifier.value / 100.0) if modifier.positive else 1.0 - (modifier.value / 100.0)
			match modifier.stat:
				modifier.Stat.DAMAGE:
					weapon.stats.DAMAGE *= factor
				modifier.Stat.CRITICAL_CHANCE:
					weapon.stats.CRITICAL_CHANCE *= factor
				modifier.Stat.CRITICAL_DAMAGE:
					weapon.stats.CRITICAL_DAMAGE *= factor
				modifier.Stat.RANGE:
					weapon.stats.RANGE *= factor
				modifier.Stat.RATE:
					weapon.stats.FIRE_RATE *= factor

