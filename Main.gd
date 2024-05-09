extends Node

onready var player = $Player
onready var round_timer = $EnemySpawner/RoundTimer


func _ready():
	randomize()
	Global.timer = round_timer
	Global.main = self
	player.initialize(self)
