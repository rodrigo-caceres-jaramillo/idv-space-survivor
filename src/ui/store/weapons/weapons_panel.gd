extends PanelContainer

@onready var weapon_1 = $HBoxContainer/Weapon1
@onready var weapon_2 = $HBoxContainer/Weapon2

func _ready():
	if(Global.player.weapon_manager.weapons_resource.size() > 1):
		weapon_1.set_up(1)
		weapon_2.set_up(2)
	else:
		weapon_1.set_up(1)
