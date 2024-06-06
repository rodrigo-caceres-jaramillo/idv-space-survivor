extends PanelContainer

@onready var select_button = $VBoxContainer/PanelContainer/SelectButton
@onready var sell_button = $VBoxContainer/SellButton
@onready var weapon_icon = $VBoxContainer/PanelContainer/WeaponIcon
@onready var weapon_manager = Global.player.weapon_manager
var weapon_resource
var weapon_index

func set_up(_weapon_index):
	self.weapon_index = _weapon_index
	self.weapon_resource = weapon_manager.weapons_resource[weapon_index]
	weapon_icon.texture = weapon_resource.icon
	weapon_manager.new_weapon_add.connect(update_resource)

func update_resource():
	self.weapon_resource = weapon_manager.weapons_resource[weapon_index]
	weapon_icon.texture = weapon_resource.icon
	
func _on_sell_button_pressed():
	if (weapon_resource):
		weapon_resource = null
		weapon_icon.texture = null
		weapon_manager.remove_weapon(weapon_index)

func _on_select_button_pressed():
	if(weapon_resource):
		for stat in weapon_resource.stats.get_labels():
			print(stat)
		Global.weapon_selected_resource = weapon_resource
