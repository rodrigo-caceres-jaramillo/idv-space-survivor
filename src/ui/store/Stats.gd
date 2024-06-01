extends VBoxContainer

@onready var health = $Health
@onready var damage = $Damage
@onready var rate = $Rate
@onready var range = $Range
@onready var speed = $Speed 

func _ready():
	update_stats()
	Global.wave_finished.connect(update_stats)
	Global.player.stats.stats_changed.connect(update_stats)

func update_stats():
	health.text = "Max Health: " + str(Global.player.stats.HEALTH)
	damage.text = "Damage: " + str(Global.player.stats.DAMAGE)
	#rate.text = "Rate: " + str(Global.player.stats.rate_mul)
	range.text = "Range: " + str(Global.player.stats.RANGE)
	speed.text = "Speed: " + str(Global.player.stats.SPEED)
