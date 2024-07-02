extends Node2D

@export var projectile_impact: PackedScene
@export var damage_label: PackedScene
var damage_color = "#FFF"
var critical_color = Color.YELLOW

func _ready():
	Events.damage_take.connect(show_damage_numbers)
	Events.projectile_impacted.connect(emit_hit_particle)
	
func show_damage_numbers(_position, value, critical, effectiveness):
	var label = damage_label.instantiate()
	add_child(label)
	label.global_position = _position
	label.set_up(value, critical, effectiveness)
	
func emit_hit_particle(_position, direction):
	var impact = projectile_impact.instantiate()
	add_child(impact)
	impact.global_position = _position
	impact.global_rotation = direction.angle()
	impact.emitting = true

