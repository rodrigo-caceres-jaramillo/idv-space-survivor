class_name SpawnProjectileComponent
extends Node

@export var projectile_scene: PackedScene

func spawn_projectile(damage, range, projectile_speed, critical, direction, global_spawn_position, parent: Node = get_tree().current_scene) -> Node:
	var projectile = projectile_scene.instantiate()
	parent.add_child(projectile)
	projectile.global_position = global_spawn_position
	projectile.initialize(damage, range, projectile_speed, critical, direction)
	
	return projectile
