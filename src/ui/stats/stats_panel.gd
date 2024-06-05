extends PanelContainer

@export var stats_resource: Resource
@onready var stats = $StatsContainer/stats
@export var stat_container_scene: PackedScene
@onready var title = $StatsContainer/Title

func set_up(_title, _stats_resource):
	title.text = _title
	stats_resource = _stats_resource
	self.set_up_stats()

func set_up_stats():
	for stat in stats_resource.stats:
		var stat_container = stat_container_scene.instantiate()
		stats.add_child(stat_container)
		stat_container.set_up(stat)
		
