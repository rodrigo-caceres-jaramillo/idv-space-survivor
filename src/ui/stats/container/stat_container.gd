extends HBoxContainer
class_name StatContainer

@onready var stat_label = $StatLabel
@onready var amount_label = $AmountLabel
var multi: int

func set_up(_stat):
	stat_label.text = _stat[0] + ":"
	multi = _stat[2]
	if (multi > 0):
		amount_label.text = str(_stat[1] * multi) + "%"
	else:
		amount_label.text = str(_stat[1])
	_stat[3].connect(update_stat)
	
func update_stat(new_amount):
	if (multi > 0):
		amount_label.text = str(new_amount * multi) + "%"
	else:
		amount_label.text = str(new_amount)
