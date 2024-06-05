extends Node2D

@export var projectile_impact: PackedScene

func _ready():
	Global.projectile_impacted.connect(emit_hit_particle)
	
func emit_hit_particle(_position, direction):
	var impact = projectile_impact.instantiate()
	add_child(impact)
	impact.global_position = _position
	impact.global_rotation = direction.angle()
	impact.emitting = true

