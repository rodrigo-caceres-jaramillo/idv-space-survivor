extends PanelContainer

@onready var weapon_sprite = $HBoxContainer/WeaponSprite
@onready var weapon_name = $HBoxContainer/WeaponName
@onready var button = $HBoxContainer/Button
var weapon

func set_up(_weapon):
	self.weapon = _weapon
	weapon_sprite.texture = weapon.icon
	weapon_name.text = str(weapon.name)

func _on_equip_button_pressed():
	Global.player.equip_weapon(weapon)
