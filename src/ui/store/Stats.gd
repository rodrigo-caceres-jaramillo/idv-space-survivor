extends VBoxContainer

@onready var health = $Health
@onready var damage = $Damage
@onready var rate = $Rate
@onready var range = $Range
@onready var speed = $Speed 
@onready var crit_chance = $CritChance
@onready var crit_damage = $CritDamage

func _ready():
	update_stats()
	Global.wave_finished.connect(update_stats)
	Global.player.stats.stats_changed.connect(update_stats)

func update_stats():
	health.text = "Max Health: " + str(Global.player.stats.MAX_HEALTH)
	damage.text = "Damage: " + str(Global.player.stats.DAMAGE*100) + "%"
	crit_chance.text = "Critical Chance: " + str(Global.player.stats.CRIT_CHANCE*100) + "%"
	crit_damage.text = "Critical Damage: " + str(Global.player.stats.CRIT_DAMAGE*100) + "%"
	rate.text = "Fire Rate: " + str(Global.player.stats.RATE*100) + "%"
	range.text = "Range: " + str(Global.player.stats.RANGE*100) + "%"
	speed.text = "Speed: " + str(Global.player.stats.SPEED*100) + "%"
