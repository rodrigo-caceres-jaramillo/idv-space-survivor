extends PanelContainer

@onready var weapon_sprite = $HBoxContainer/WeaponSprite
@onready var weapon_name = $HBoxContainer/WeaponName
@onready var button = $HBoxContainer/Button
var weapon_resource

func set_up(_weapon_resource):
	self.weapon_resource = _weapon_resource
	weapon_sprite.texture = weapon_resource.icon
	weapon_name.text = str(weapon_resource.name)

func _on_equip_button_pressed():
	Global.player.equip_weapon(weapon_resource)
