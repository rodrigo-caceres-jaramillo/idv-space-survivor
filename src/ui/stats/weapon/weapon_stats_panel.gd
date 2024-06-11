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
	for stat_info in weapon.stats.get_property_list():
		if stat_info.name != "resource_path" and stat_info.type == TYPE_FLOAT:
			var stat_instance = stat_container_scene.instantiate()
			stats.add_child(stat_instance)
			stat_instance.show_stat(stat_info.name, weapon.stats.get(stat_info.name))

func compare_stats(new_weapon):
	var current_weapon = Global.player.weapon_manager.get_weapon_resource(new_weapon.weapon_type)
	if current_weapon:
		self.clean_stats()
		title.text = current_weapon.name + " | " + new_weapon.name
		for stat_info in current_weapon.stats.get_property_list():
			if stat_info.name != "resource_path" and stat_info.type == TYPE_FLOAT:
				var stat_instance = stat_container_scene.instantiate()
				stats.add_child(stat_instance)
				stat_instance.compare_stats(stat_info.name, current_weapon.stats.get(stat_info.name), new_weapon.stats.get(stat_info.name))
	else:
		show_weapon_stats(new_weapon)
		
