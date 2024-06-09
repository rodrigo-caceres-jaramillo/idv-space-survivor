extends PanelContainer

@onready var select_button = $VBoxContainer/PanelContainer/SelectButton
@onready var sell_button = $VBoxContainer/SellButton
@onready var weapon_icon = $VBoxContainer/PanelContainer/WeaponIcon
var weapon_manager 
var weapon_resource
var weapon_index

func set_up(_weapon_index):
	self.weapon_manager = Global.player.weapon_manager
	self.weapon_index = _weapon_index
	if(weapon_manager.weapons_resource[weapon_index]):
		self.weapon_resource = weapon_manager.weapons_resource[weapon_index]
		weapon_icon.texture = weapon_resource.icon
	Events.new_weapon_add.connect(update_resource)

func update_resource(_weapon_resource):
	if(_weapon_resource.weapon_type == weapon_index):
		self.weapon_resource = _weapon_resource
		weapon_icon.texture = weapon_resource.icon

func _on_select_button_pressed():
	if(weapon_resource):
		Global.weapon_selected = weapon_resource
