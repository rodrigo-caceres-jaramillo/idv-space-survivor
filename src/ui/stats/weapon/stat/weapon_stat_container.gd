extends HBoxContainer

@onready var stat = $Stat
@onready var base = $Base
@onready var new = $New

func compare_stats(stat_name, base_stat, new_stat):
	stat.text = format_stat_name(stat_name)
	base.text = str(base_stat)
	if new_stat > base_stat:
		var red = Color(0,1,0)
		new.set("theme_override_colors/font_color", red)
		new.text = str(new_stat)
	elif new_stat < base_stat:
		var green = Color(1,0,0)
		new.set("theme_override_colors/font_color", green)
		new.text = str(new_stat)
	else:
		new.hide()

func show_stat(stat_name, stat_value):
	stat.text = format_stat_name(stat_name)
	base.text = str(stat_value)
	new.hide()
	
func format_stat_name(stat_name: String) -> String:
	var words = stat_name.split("_")
	for i in range(words.size()):
		words[i] = words[i].capitalize()
	return " ".join(words)
