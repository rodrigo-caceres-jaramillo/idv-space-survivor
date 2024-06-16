extends Node2D

@export var projectile_impact: PackedScene
var damage_color = "#FFF"
var critical_color = Color.YELLOW

func _ready():
	Events.damage_take.connect(show_damage_numbers)
	Events.projectile_impacted.connect(emit_hit_particle)
	
func show_damage_numbers(_position, value, critical, effectiveness):
	var label = Label.new()
	add_child(label)
	label.global_position = _position
	if(effectiveness == 1):
		label.text = str(value) + "!"
	elif (effectiveness == -1):
		label.text = str(value) + "-"
	else:
		label.text = str(value)
	#label.z_index = 5
	label.label_settings = LabelSettings.new()
	label.label_settings.outline_color = Color.BLACK
	label.label_settings.outline_size = 1
	if(critical):
		label.label_settings.font_color = critical_color
	else:
		label.label_settings.font_color = damage_color
	
	await get_tree().create_timer(0.5).timeout
	label.queue_free()
	
func emit_hit_particle(_position, direction):
	var impact = projectile_impact.instantiate()
	add_child(impact)
	impact.global_position = _position
	impact.global_rotation = direction.angle()
	impact.emitting = true

