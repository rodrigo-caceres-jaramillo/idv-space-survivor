extends HBoxContainer

@onready var ammo_counter = $AmmoCounter
@onready var gun_icon = $Panel/GunIcon
var max_ammo

func _ready():
	Global.weapon_ammo_changed.connect(update_ammo)
	Global.current_weapon_changed.connect(update_gun_icon)
	
func update_ammo(ammo):
	self.ammo_counter.text = (str(ammo) + "/" + str(max_ammo))

func update_gun_icon(weapon):
	max_ammo = weapon.magazine_size
	update_ammo(weapon.current_ammo)
	self.gun_icon.texture = weapon.sprite.texture
