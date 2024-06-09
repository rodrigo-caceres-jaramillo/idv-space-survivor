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
	
func show_upgrade(new_amount):
	upgrade.show()
	print(new_amount)
	upgrade.text = str(amount + new_amount)
