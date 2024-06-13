extends PanelContainer

@onready var title = $StatsContainer/Title
@onready var damage = $StatsContainer/stats/Damage
@onready var crit_chance = $StatsContainer/stats/CritChance
@onready var crit_damage = $StatsContainer/stats/CritDamage
@onready var rate = $StatsContainer/stats/Rate
@onready var range = $StatsContainer/stats/Range
var stats: PlayerStats

func _ready():
	Events.player_ready.connect(update_stats)
	Global.upgrade_resource_selected.connect(show_upgrade_stats)
	Global.player.stats.stats_changed.connect(update_stats)
	
func update_stats():
	stats = Global.player.stats
	damage.set_up("Damage", stats.DAMAGE)
	crit_chance.set_up("Critical Chance", stats.CRIT_CHANCE)
	crit_damage.set_up("Critical Damage", stats.CRIT_DAMAGE)
	rate.set_up("Fire Rate", stats.RATE)
	range.set_up("Range", stats.RANGE)
	
func show_upgrade_stats(upgrade_resource):
	update_stats()
	for modifier in upgrade_resource.modifiers:
		if(modifier.stat == Modifier.Stat.DAMAGE):
			damage.show_upgrade(stats.DAMAGE, modifier.value)
		if(modifier.stat == Modifier.Stat.CRIT_CHANCE):
			crit_chance.show_upgrade(stats.CRIT_CHANCE, modifier.value)
		if(modifier.stat == Modifier.Stat.CRIT_DAMAGE):
			crit_damage.show_upgrade(stats.CRIT_DAMAGE, modifier.value)
		if(modifier.stat == Modifier.Stat.RATE):
			rate.show_upgrade(stats.RATE, modifier.value)
		if(modifier.stat == Modifier.Stat.RANGE):
			range.show_upgrade(stats.RANGE, modifier.value)
