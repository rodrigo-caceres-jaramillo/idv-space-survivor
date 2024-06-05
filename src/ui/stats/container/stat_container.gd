extends HBoxContainer
class_name StatContainer

@onready var stat_label = $StatLabel
@onready var amount_label = $AmountLabel
@export var stat: String

func set_up(_stat):
	stat_label.text = _stat[0] + ":"
	amount_label.text = str(_stat[1])
	_stat[2].connect(update_stat)
	
func update_stat(new_amount):
	amount_label.text = str(new_amount)
