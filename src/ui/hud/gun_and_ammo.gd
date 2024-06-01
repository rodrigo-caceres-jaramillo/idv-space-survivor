extends HBoxContainer

@onready var ammo_counter = $AmmoCounter
@onready var gun_icon = $Panel/GunIcon

var max_ammo

func _ready():
	var weapon_container = Global.player.weapon_container
	weapon_container.weapon_change.connect(self.update_gun_icon)
	weapon_container.ammo_change.connect(self.update_ammo)
	
func update_ammo(ammo):
	self.ammo_counter.text = (str(ammo) + "/" + str(max_ammo))

func update_gun_icon(icon, magazine, ammo):
	max_ammo = magazine
	update_ammo(ammo)
	self.gun_icon.texture = icon
