extends PanelContainer

@onready var money_label = $HBoxContainer/MoneyLabel

func _ready():
	self.money_label.text = str(Global.money)
	Global.money_changed.connect(self.update_money)

func update_money(new_value):
	self.money_label.text = str(new_value)
