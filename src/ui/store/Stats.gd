extends VBoxContainer

@onready var health = $Health
@onready var damage = $Damage
@onready var rate = $Rate
@onready var range = $Range
@onready var speed = $Speed 

func _ready():
	update_stats()
	Global.wave_finished.connect(update_stats)

func update_stats():
	health.text = "Max Health: " + str(Global.player.stats.health)
	damage.text = "Damage: " + str(Global.player.stats.damage_mul)
	#rate.text = "Rate: " + str(Global.player.stats.rate_mul)
	#range.text = "Range: " + str(Global.player.stats.range_mul)
	#speed.text = "Speed: " + str(Global.player.stats.speed_mul)
