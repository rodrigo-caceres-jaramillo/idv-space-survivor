class_name SpawnProjectileComponent
extends Node

var projectile_scene: PackedScene

func spawn_projectile(stats, direction, rotation, global_spawn_position, parent: Node = get_tree().current_scene):
	for i in range(stats.MULTISHOT):
		var angle = rotation - randf_range( -stats.SPREAD, stats.SPREAD)
		var spread_direction = Vector2(cos(angle), sin(angle)).normalized()
		var projectile = projectile_scene.instantiate()
		parent.add_child(projectile)
		projectile.global_position = global_spawn_position
		projectile.initialize(stats, spread_direction)

	
