extends PanelContainer

@onready var select_button = $SelectButton
@onready var sell_button = $VBoxContainer/SellButton
@onready var weapon_icon = $VBoxContainer/PanelContainer/WeaponIcon
var weapon_manager
var weapon_index

func set_up(_weapon_index):
	self.weapon_manager = Global.player.weapon_manager
	self.weapon_index = _weapon_index
	if(weapon_manager.weapons[weapon_index]):
		var weapon = weapon_manager.weapons[weapon_index]
		weapon_icon.texture = weapon.texture
	Events.current_weapon_changed.connect(update_weapon)

func update_weapon(weapon):
	if(weapon.weapon_type == weapon_index):
		weapon_icon.texture = weapon.texture

func _on_select_button_pressed():
	weapon_manager.equip_weapon(weapon_index)
	update_weapon(weapon_manager.current_weapon)
