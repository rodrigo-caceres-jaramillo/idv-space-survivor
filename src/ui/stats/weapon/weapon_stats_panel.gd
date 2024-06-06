extends PanelContainer

@export var stats_resource: Resource
@onready var stats = $StatsContainer/stats
@export var stat_container_scene: PackedScene
@onready var title = $StatsContainer/Title

func _ready():
	Global.weapon_selected_resource_changed.connect(update_stats)

func update_stats(weapon):
	title.text = weapon.name
	for n in stats.get_children():
		stats.remove_child(n)
		n.queue_free()
	for stat in weapon.stats.get_labels():
		#print(stat)
		var stat_container = stat_container_scene.instantiate()
		stats.add_child(stat_container)
		stat_container.set_up(stat)
		
