extends Node2D

@onready var wave_container = $WaveContainer
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player = player
	Global.wave_container = wave_container

