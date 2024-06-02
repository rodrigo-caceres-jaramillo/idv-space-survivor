extends Node2D

@export var stats: PlayerStats
@export var weapon_resource1: StoreWeapon
@export var weapon_resource2: StoreWeapon
@onready var weapon1: Node2D
@onready var weapon2: Node2D
var current_weapon: Node2D
var current_weapon_index: int = 0

func set_up(_stats: PlayerStats):
	stats = _stats
	stats.stats_changed.connect(update_stats)
	self.load_weapons()
	self.equip_weapon(0)
	self.update_stats()
	
func shoot_weapon():
	current_weapon.fire()

func reload_weapon():
	current_weapon.reload()

func update_stats():
	weapon1.set_player_stats(stats)
	weapon2.set_player_stats(stats)
	
func load_weapons():
	weapon1 = weapon_resource1.weapon_scene.instantiate()
	self.add_child(weapon1)
	weapon1.visible = false
	weapon1.ammo_change.connect(func(value): ammo_change.emit(value))
	weapon1.start_reload.connect(func(value): weapon_reload.emit(value))

	weapon2 = weapon_resource2.weapon_scene.instantiate()
	self.add_child(weapon2)
	weapon2.visible = false
	weapon2.ammo_change.connect(func(value): ammo_change.emit(value))
	weapon2.start_reload.connect(func(value): weapon_reload.emit(value))

func equip_weapon(index: int):
	if index == 0:
		current_weapon = weapon1
		weapon1.visible = true
		weapon2.visible = false
		weapon_change.emit(weapon_resource1.icon, weapon1.base_stats.magazine, weapon1.current_ammo)
	elif index == 1:
		current_weapon = weapon2
		weapon1.visible = false
		weapon2.visible = true
		weapon_change.emit(weapon_resource2.icon, weapon2.base_stats.magazine, weapon2.current_ammo)
	current_weapon_index = index

func switch_weapon():
	if current_weapon_index == 0:
		equip_weapon(1)
	else:
		equip_weapon(0)
		
signal weapon_change(icon: Texture, magazine: int)
signal ammo_change(new_value)
signal weapon_reload(reload_time)
	

