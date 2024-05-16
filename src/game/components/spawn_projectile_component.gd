class_name SpawnProjectileComponent
extends Node

@export var projectile_scene: PackedScene

func spawn_projectile(stats, direction, global_spawn_position, parent: Node = get_tree().current_scene):
	var projectile_count = stats.projectiles
	var projectile = projectile_scene.instantiate()
	parent.add_child(projectile)
	projectile.global_position = global_spawn_position
	projectile.initialize(stats, direction)
	
