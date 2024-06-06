extends Node2D

@export var stats: PlayerStats
@export var weapons_resource =  Dictionary()
var weapons =  Dictionary()
var current_weapon: Node2D
var current_weapon_index: int = 1

func set_up(_stats: PlayerStats):
	stats = _stats
	for key in weapons_resource.keys():
		self.load_weapon(key)
	self.equip_weapon(current_weapon_index)
	
func shoot_weapon():
	self.current_weapon.fire()

func reload_weapon():
	self.current_weapon.reload()
	
func remove_weapon(index: int):
	var weapon = weapons[index]
	weapons.erase(index)
	weapons_resource.erase(index)
	weapon.queue_free()
	if (index == 1):
		equip_weapon(2)
	else:
		equip_weapon(1)

func load_weapon(index: int):
	var weapon = weapons_resource[index].weapon_scene.instantiate()
	weapons[index] = weapon
	self.add_child(weapon)
	weapon.visible = false
	
func add_weapon(weapon_resource):
	if(weapons_resource[1]):
		weapons_resource[2] = weapon_resource
		load_weapon(2)
	else:
		weapons_resource[1] = weapon_resource
		load_weapon(1)
	new_weapon_add.emit()

func equip_weapon(index: int):
	self.current_weapon = weapons[index]
	self.current_weapon.visible = true
	self.current_weapon_index = index
	Global.current_weapon_changed.emit(current_weapon)
	
func switch_weapon():
	if(weapons.size() > 1):
		if (current_weapon_index == 1):
			self.current_weapon.visible = false
			equip_weapon(2)
		else:
			self.current_weapon.visible = false
			equip_weapon(1)

signal new_weapon_add()

