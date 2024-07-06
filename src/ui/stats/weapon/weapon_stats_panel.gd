extends PanelContainer

@export var stats_resource: Resource
@onready var stats = $StatsContainer/ScrollContainer/stats
@export var stat_container_scene: PackedScene
@onready var title = $StatsContainer/Title

func _ready():
	Events.current_weapon_changed.connect(show_weapon_stats)
	Global.weapon_resource_selected.connect(show_new_weapon_stats)
	Global.upgrade_resource_selected.connect(show_upgrade_stats)

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
				
func show_new_weapon_stats(new_weapon):
	var current_weapon = Global.player.weapon_manager.weapons_resource[new_weapon.weapon_type]
	if current_weapon and (!current_weapon.name == new_weapon.name):
		title.text = current_weapon.name + " | " + new_weapon.name
		compare_stats(current_weapon.stats, new_weapon.stats)
	else:
		show_weapon_stats(new_weapon)
		
func compare_stats(base_stats, new_stats):
	self.clean_stats()
	if base_stats.DAMAGE_TYPE == new_stats.DAMAGE_TYPE:
		var damage_instance = stat_container_scene.instantiate()
		stats.add_child(damage_instance)
		damage_instance.compare_damage_stat(base_stats.DAMAGE_TYPE, base_stats.DAMAGE, base_stats.MULTISHOT, new_stats.DAMAGE, new_stats.MULTISHOT)
	else:
		var damage_instance_current = stat_container_scene.instantiate()
		stats.add_child(damage_instance_current)
		damage_instance_current.compare_damage_stat(base_stats.DAMAGE_TYPE, base_stats.DAMAGE, base_stats.MULTISHOT, 0, 0)
			
		var damage_instance_new = stat_container_scene.instantiate()
		stats.add_child(damage_instance_new)
		damage_instance_new.compare_damage_stat(new_stats.DAMAGE_TYPE, 0, 0, new_stats.DAMAGE, new_stats.MULTISHOT)
		
	for stat_info in base_stats.get_property_list():
		if !["resource_path", "DAMAGE", "MULTISHOT"].has(stat_info.name) and stat_info.type == TYPE_FLOAT:
			var stat_instance = stat_container_scene.instantiate()
			stats.add_child(stat_instance)
			var current_value = base_stats.get(stat_info.name)
			var new_value = new_stats.get(stat_info.name)
			if current_value != 0 or new_value != 0:
				stat_instance.compare_stats(stat_info.name, current_value, new_value)
		
func show_upgrade_stats(upgrade: Upgrade):
	if(upgrade.type == 1):
		var current_weapon = Global.player.weapon_manager.current_weapon
		title.text = current_weapon.weapon_name
		self.clean_stats()
		var modified_stats = current_weapon.stats.duplicate()
		for modifier in upgrade.modifiers:
			var factor = 1.0 + (modifier.value / 100.0) if modifier.positive else 1.0 - (modifier.value / 100.0)
			match modifier.stat:
				modifier.Stat.DAMAGE:
					modified_stats.DAMAGE *= factor
				modifier.Stat.CRITICAL_CHANCE:
					modified_stats.CRITICAL_CHANCE *= factor
				modifier.Stat.CRITICAL_DAMAGE:
					modified_stats.CRITICAL_DAMAGE *= factor
				modifier.Stat.RANGE:
					modified_stats.RANGE *= factor
				modifier.Stat.RATE:
					modified_stats.FIRE_RATE *= factor
		compare_stats(current_weapon.stats, modified_stats)
	
