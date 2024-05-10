extends Node

onready var player = $Player
onready var round_timer = $EnemySpawner/RoundTimer
onready var enemy_container = $EnemyContainer


func _ready():
	randomize()
	Global.timer = round_timer
	Global.main = self
	Global.wave_container = enemy_container
