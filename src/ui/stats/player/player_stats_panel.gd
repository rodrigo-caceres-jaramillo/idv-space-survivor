extends PanelContainer

@onready var title = $StatsContainer/Title
@onready var stats = $StatsContainer/stats
@export var stat_container_scene: PackedScene
var stats_resource: Resource

func _ready():
	Events.player_ready.connect(update_stats)
	
func update_stats():
	self.stats_resource = Global.player.stats
	title.text = "PLAYER"
	for stat in stats_resource.get_labels():
		var stat_container = stat_container_scene.instantiate()
		stats.add_child(stat_container)
		stat_container.set_up(stat)

	
