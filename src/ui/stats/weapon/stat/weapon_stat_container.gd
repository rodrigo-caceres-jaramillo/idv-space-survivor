extends HBoxContainer

@onready var stat = $Stat
@onready var base = $Base
@onready var new = $New
@onready var damage_icon = $DamageIcon

func show_stat(stat_name, stat_value):
	stat.text = format_stat_name(stat_name)
	base.text = str(stat_value)
	new.hide()
	
func compare_stats(stat_name, base_stat, new_stat):
	if base_stat == new_stat: 
		self.show_stat(stat_name, base_stat)
	else:
		stat.text = format_stat_name(stat_name)
		self.format_stats(base_stat, new_stat)
		new.show()
		
func show_damage_stat(damage_type, stat_value, multishot_value):
	damage_icon.show()
	damage_icon.texture = damage_type.icon
	stat.text = damage_type.name
	if (multishot_value > 1):
		base.text = str(stat_value) + "X" + str(multishot_value)
	else:
		base.text = str(stat_value)
	new.hide()

func compare_damage_stat(damage_type, base_stat, base_stat_multishot, new_stat, new_stat_multishot):
	if base_stat == new_stat and base_stat_multishot == new_stat_multishot:
		show_damage_stat(damage_type, base_stat, base_stat_multishot)
	else:
		damage_icon.show()
		damage_icon.texture = damage_type.icon
		stat.text = damage_type.name
		self.format_damge_stats(base_stat, base_stat_multishot, new_stat, new_stat_multishot)
		new.show()

func format_damge_stats(base_stat, base_stat_multishot, new_stat, new_stat_multishot):
	var total_base_damage = base_stat * base_stat_multishot
	var total_new_damage = new_stat * new_stat_multishot
	if base_stat == 0:
		base.text = "-"
	else:
		if (base_stat_multishot > 1):
			base.text = str(base_stat) + "X" + str(base_stat_multishot)
		else:
			base.text = str(base_stat)
	if new_stat == 0:
		new.text = "-"
	else:
		if (new_stat_multishot > 1):
			new.text = str(new_stat) + "X" + str(new_stat_multishot)
		else:
			new.text = str(new_stat)
	if total_base_damage > total_new_damage:
		new.set("theme_override_colors/font_color", Color.RED)
	elif total_base_damage < total_new_damage:
		new.set("theme_override_colors/font_color", Color.GREEN)
	
func format_stats(base_stat, new_stat):
	if base_stat == 0:
		base.text = "-"
	else:
		base.text = str(base_stat)
	if new_stat != 0:
		new.text = str(new_stat)
	else:
		new.text = "-"
	if new_stat > base_stat:
		new.set("theme_override_colors/font_color", Color.GREEN)
	elif new_stat < base_stat:
		new.set("theme_override_colors/font_color", Color.RED)
	else:
		new.set("theme_override_colors/font_color", Color(1, 1, 1))

func format_stat_name(stat_name: String) -> String:
	var words = stat_name.split("_")
	for i in range(words.size()):
		words[i] = words[i].capitalize()
	return " ".join(words)
