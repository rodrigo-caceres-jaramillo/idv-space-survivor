extends Node2D

@onready var player = $Player

func _ready():
	Global.player = player

