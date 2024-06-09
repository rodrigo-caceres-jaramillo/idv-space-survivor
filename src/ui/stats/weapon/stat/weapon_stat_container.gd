extends HBoxContainer
class_name StatContainer

@onready var stat = $Stat
@onready var base = $Base
var multi: int

func set_up(_stat):
	stat.text = _stat[0] + ":"
	multi = _stat[2]
	if (multi > 0):
		base.text = str(_stat[1] * multi) + "%"
	else:
		base.text = str(_stat[1])
	_stat[3].connect(update_stat)
	
func update_stat(new_amount):
	if (multi > 0):
		base.text = str(new_amount * multi) + "%"
	else:
		base.text = str(new_amount)
