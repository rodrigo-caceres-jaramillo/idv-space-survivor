extends PanelContainer

@onready var primary_weapon = $HBoxContainer/PrimaryWeapon
@onready var secondary_weapon = $HBoxContainer/SecondaryWeapon
@onready var melee_weapon = $HBoxContainer/MeleeWeapon

func _ready():
	Events.player_ready.connect(set_up)
	
func set_up():
	primary_weapon.set_up(0)
	secondary_weapon.set_up(1)
	melee_weapon.set_up(2)
