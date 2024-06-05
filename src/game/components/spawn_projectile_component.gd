class_name SpawnProjectileComponent
extends Node

@export var projectile_scene: PackedScene

func spawn_projectile(stats, direction, rotation, global_spawn_position, parent: Node = get_tree().current_scene):
	for i in range(stats.PROJECTILES):
		var angle = rotation - randf_range( -stats.SPREAD, stats.SPREAD)
		var spread_direction = Vector2(cos(angle), sin(angle)).normalized()
		var final_direction = lerp(spread_direction, direction, stats.PRESICION).normalized()
		var projectile = projectile_scene.instantiate()
		parent.add_child(projectile)
		projectile.global_position = global_spawn_position
		projectile.initialize(stats, final_direction)

	
