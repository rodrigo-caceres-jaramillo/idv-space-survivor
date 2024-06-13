extends HBoxContainer

@onready var stat = $Stat
@onready var base = $Base
@onready var upgrade = $Upgrade
var amount

func set_up(stat_name, _amount):
	amount = _amount
	stat.text = stat_name
	base.text = str(amount)
	upgrade.hide()
	
func show_upgrade(base_stat, new_amount):
	upgrade.show()
	if new_amount > base_stat:
		var green = Color(0, 1, 0)
		upgrade.set("theme_override_colors/font_color", green)
	elif new_amount < base_stat:
		var red = Color(1, 0, 0)
		upgrade.set("theme_override_colors/font_color", red)
	else:
		upgrade.set("theme_override_colors/font_color", Color(1, 1, 1))
	upgrade.text = str(amount + new_amount)
