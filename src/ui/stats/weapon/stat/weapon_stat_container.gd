extends HBoxContainer

@onready var stat = $Stat
@onready var base = $Base
@onready var new = $New
@onready var damage_icon = $DamageIcon

func compare_stats(stat_name, base_stat, new_stat):
	stat.text = format_stat_name(stat_name)
	if base_stat == new_stat: 
		show_stat(stat_name, base_stat)
	else:
		if base_stat == 0:
			base.text = "-"
		else:
			base.text = str(base_stat)
		if new_stat != 0:
			new.text = str(new_stat)
		else:
			new.text = "-"
	
		if new_stat > base_stat:
			var green = Color(0, 1, 0)
			new.set("theme_override_colors/font_color", green)
		elif new_stat < base_stat:
			var red = Color(1, 0, 0)
			new.set("theme_override_colors/font_color", red)
		else:
			new.set("theme_override_colors/font_color", Color(1, 1, 1))  # Blanco para igual
	
		new.show()

func show_damage_stat(damage_type, stat_value):
	damage_icon.show()
	damage_icon.texture = damage_type.icon
	stat.text = damage_type.name
	base.text = str(stat_value)
	new.hide()

func compare_damage_stat(damage_type, base_stat, new_stat):
	damage_icon.show()
	damage_icon.texture = damage_type.icon
	stat.text = damage_type.name
	if base_stat == new_stat: 
		base.text = str(base_stat)
	else:
		if base_stat == 0:
			base.text = "-"
		else:
			base.text = str(base_stat)
	
		if new_stat == 0:
			new.text = "-"
		else:
			new.text = str(new_stat)
	
		if new_stat > base_stat:
			var green = Color(0, 1, 0)
			new.set("theme_override_colors/font_color", green)
		elif new_stat < base_stat:
			var red = Color(1, 0, 0)
			new.set("theme_override_colors/font_color", red)
		else:
			new.set("theme_override_colors/font_color", Color(1, 1, 1))  # Blanco para igual
		new.show()

func show_stat(stat_name, stat_value):
	stat.text = format_stat_name(stat_name)
	base.text = str(stat_value)
	new.hide()

func format_stat_name(stat_name: String) -> String:
	var words = stat_name.split("_")
	for i in range(words.size()):
		words[i] = words[i].capitalize()
	return " ".join(words)
