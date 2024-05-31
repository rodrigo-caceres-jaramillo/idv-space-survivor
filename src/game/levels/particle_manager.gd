extends Node2D

@export var projectile_impact: PackedScene

func _ready():
	Global.projectile_impacted.connect(emit_hit_particle)
	
func emit_hit_particle(position, direction):
	var impact = projectile_impact.instantiate()
	add_child(impact)
	impact.global_position = position
	impact.global_rotation = direction.angle()
	impact.emitting = true

