extends PanelContainer

@onready var weapon_1 = $HBoxContainer/Weapon1
@onready var weapon_2 = $HBoxContainer/Weapon2

func _ready():
	weapon_1.set_up(1)
	weapon_2.set_up(2)
