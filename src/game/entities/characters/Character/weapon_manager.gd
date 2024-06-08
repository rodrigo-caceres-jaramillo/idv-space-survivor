extends Node2D

@export var stats: PlayerStats
var weapons_resource =  {}
var weapons =  Dictionary()
var current_weapon: Node2D
var current_weapon_index: int = 1

func set_up(_stats: PlayerStats, _initial_weapon):
	self.stats = _stats
	weapons_resource[1] = _initial_weapon
	self.load_weapon(1)
	self.equip_weapon(current_weapon_index)
	
func shoot_weapon():
	self.current_weapon.fire()

func reload_weapon():
	self.current_weapon.reload()
	
func remove_weapon(index: int):
	if(weapons.size() > 1):
		var weapon = weapons[index]
		weapons.erase(index)
		weapons_resource.erase(index)
		weapon.queue_free()
		if (index == 1):
			equip_weapon(2)
		else:
			equip_weapon(1)

func load_weapon(index: int):
	var weapon_resource = weapons_resource[index]
	var weapon = weapon_resource.weapon_scene.instantiate()
	weapons[index] = weapon
	weapon.set_up(weapon_resource.stats, stats)
	self.add_child(weapon)
	weapon.visible = false
	
func add_weapon(weapon_resource):
	if(weapons_resource.has(1)):
		weapons_resource[2] = weapon_resource
		load_weapon(2)
	elif(weapons_resource.has(2)):
		weapons_resource[1] = weapon_resource
		load_weapon(1)
	new_weapon_add.emit()

func equip_weapon(index: int):
	self.current_weapon = weapons[index]
	self.current_weapon.visible = true
	self.current_weapon_index = index
	Events.current_weapon_changed.emit(current_weapon)
	
func switch_weapon():
	if(weapons.size() > 1):
		if (current_weapon_index == 1):
			self.current_weapon.visible = false
			equip_weapon(2)
		else:
			self.current_weapon.visible = false
			equip_weapon(1)

signal new_weapon_add()

