extends PanelContainer

@export var stats_resource: Resource
@onready var stats = $StatsContainer/stats
@export var stat_container_scene: PackedScene
@onready var title = $StatsContainer/Title

func _ready():
	Global.weapon_selected_changed.connect(show_weapon_stats)
	Global.weapon_resource_selected.connect(compare_stats)

func clean_stats():
	for n in stats.get_children():
		stats.remove_child(n)
		n.queue_free()
	
func show_weapon_stats(weapon):
	title.text = weapon.name
	self.clean_stats()
	for stat in weapon.stats.get_labels():
		var stat_container = stat_container_scene.instantiate()
		stats.add_child(stat_container)
		stat_container.set_up(stat)
		
func compare_stats(new_weapon):
	var current_weapon = Global.player.weapon_manager.get_weapon(new_weapon.weapon_type)
	if (current_weapon):
		self.clean_stats()
		title.text = current_weapon.name + "->" + new_weapon.name
	else:
		show_weapon_stats(new_weapon)
		
