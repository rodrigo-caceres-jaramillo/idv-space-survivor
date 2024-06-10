extends Node2D

@export var stats: PlayerStats
@export var weapons_resource =  {}
@export var weapons= {} #Primary=0, Secondary=1, Melee=2
var current_weapon: Node2D
var current_weapon_type: int = 0
var weapons_types = WeaponResource.WeaponTypes

func set_up(_stats: PlayerStats, _initial_weapon: WeaponResource):
	self.stats = _stats
	self.load_weapon(_initial_weapon)
	self.current_weapon = weapons[_initial_weapon.weapon_type]
	self.current_weapon.visible = true
	Events.current_weapon_changed.emit(current_weapon)

func get_weapon(weapon_type):
	return weapons_resource[weapon_type]
	
func shoot_weapon():
	self.current_weapon.fire()

func reload_weapon():
	self.current_weapon.reload()
	
func remove_weapon(weapon_type):
	var weapon = weapons[weapon_type]
	weapon.queue_free()
	weapons[weapon_type] = null
	weapons_resource[weapon_type] = null

func load_weapon(weapon_resource):
	weapons_resource[weapon_resource.weapon_type] = weapon_resource
	var weapon = weapon_resource.weapon_scene.instantiate()
	weapons[weapon_resource.weapon_type] = weapon
	weapon.set_up(weapon_resource.stats, stats)
	self.add_child(weapon)
	weapon.visible = false
	self.current_weapon = weapon
	
func add_weapon(weapon_resource):
	if(weapons[weapon_resource.weapon_type]):
		remove_weapon(weapon_resource.weapon_type)
	weapons_resource[weapon_resource.weapon_type] = weapon_resource
	self.load_weapon(weapon_resource)
	self.equip_weapon(weapon_resource.weapon_type)
	Events.new_weapon_add.emit(weapon_resource)
	return true

func equip_weapon(weapon_type):
	if(weapons[weapon_type] and !(weapon_type == current_weapon_type)):
		self.current_weapon.visible = false
		self.current_weapon = weapons[weapon_type]
		self.current_weapon.visible = true
		self.current_weapon_type = weapon_type
		Events.current_weapon_changed.emit(current_weapon)
