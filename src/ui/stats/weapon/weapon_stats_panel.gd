extends PanelContainer

@export var stats_resource: Resource
@onready var stats = $StatsContainer/ScrollContainer/stats
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
	var damage_instance = stat_container_scene.instantiate()
	stats.add_child(damage_instance)
	damage_instance.show_damage_stat(weapon.stats.DAMAGE_TYPE, weapon.stats.DAMAGE, weapon.stats.MULTISHOT)
	for stat_info in weapon.stats.get_property_list():
		if !["resource_path", "DAMAGE", "MULTISHOT"].has(stat_info.name) and stat_info.type == TYPE_FLOAT:
			var stat_value = weapon.stats.get(stat_info.name)
			if stat_value != 0:
				var stat_instance = stat_container_scene.instantiate()
				stats.add_child(stat_instance)
				stat_instance.show_stat(stat_info.name, stat_value)

func compare_stats(new_weapon):
	var current_weapon = Global.player.weapon_manager.get_weapon_resource(new_weapon.weapon_type)
	if current_weapon and (!current_weapon.name == new_weapon.name):
		self.clean_stats()
		title.text = current_weapon.name + " | " + new_weapon.name
		if current_weapon.stats.DAMAGE_TYPE == new_weapon.stats.DAMAGE_TYPE:
			var damage_instance = stat_container_scene.instantiate()
			stats.add_child(damage_instance)
			damage_instance.compare_damage_stat(current_weapon.stats.DAMAGE_TYPE, current_weapon.stats.DAMAGE, current_weapon.stats.MULTISHOT, new_weapon.stats.DAMAGE, new_weapon.stats.MULTISHOT)
		else:
			var damage_instance_current = stat_container_scene.instantiate()
			stats.add_child(damage_instance_current)
			damage_instance_current.compare_damage_stat(current_weapon.stats.DAMAGE_TYPE, current_weapon.stats.DAMAGE, current_weapon.stats.MULTISHOT, 0, 0)
			
			var damage_instance_new = stat_container_scene.instantiate()
			stats.add_child(damage_instance_new)
			damage_instance_new.compare_damage_stat(new_weapon.stats.DAMAGE_TYPE, 0, 0, new_weapon.stats.DAMAGE, new_weapon.stats.MULTISHOT)
		
		for stat_info in current_weapon.stats.get_property_list():
			if !["resource_path", "DAMAGE", "MULTISHOT"].has(stat_info.name) and stat_info.type == TYPE_FLOAT:
				var stat_instance = stat_container_scene.instantiate()
				stats.add_child(stat_instance)
				var current_value = current_weapon.stats.get(stat_info.name)
				var new_value = new_weapon.stats.get(stat_info.name)
				if current_value != 0 or new_value != 0:
					stat_instance.compare_stats(stat_info.name, current_value, new_value)
	else:
		show_weapon_stats(new_weapon)
