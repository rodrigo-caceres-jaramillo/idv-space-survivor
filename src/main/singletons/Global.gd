extends Node

var charater_resource = null
var initial_stats = null
var camera
var player = null
var money: int = 1000:
	set(value):
		money = value
		money_changed.emit(value)
var weapon_selected: WeaponResource:
	set(value):
		weapon_selected = value
		weapon_selected_changed.emit(value)
var store_option_selected: StoreResource:
	set(value):
		store_option_selected = value
		if(value.type == StoreResource.ResourceTypes.WEAPON):
			weapon_resource_selected.emit(value)
		if(value.type == StoreResource.ResourceTypes.UPGRADE):
			upgrade_resource_selected.emit(value)
var wave_timer
var pick_up_container = Node.new()

func set_up():
	money = 1000
	pick_up_container = Node.new()
	if(!player == null): player.queue_free()
	var new_player = charater_resource.character_scene.instantiate()
	new_player.initial_weapon = charater_resource.initial_weapon
	player = new_player
	


signal money_changed(value)
signal selected_resource_changed(value)
signal weapon_selected_changed(value)
signal upgrade_resource_selected()
signal weapon_resource_selected()
