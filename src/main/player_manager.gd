extends Node2D

@export var player_resource: CharacterResource

func _ready():
	var player = player_resource.character_scene.instantiate()
	player.set_up(player_resource.stats, player_resource.initial_weapon)
	player.global_position(self.global_position)
	add_child(player)

