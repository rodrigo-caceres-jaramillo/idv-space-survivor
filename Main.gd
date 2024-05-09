extends Node

onready var player = $Player
onready var round_timer = $EnemySpawner/RoundTimer

export (PackedScene) var level_manager_scene: PackedScene

func _ready():
	randomize()
	Global.timer = round_timer
	Global.main = self
	player.initialize(self)


func _on_StartButton_pressed():
	get_tree().change_scene_to(level_manager_scene)
