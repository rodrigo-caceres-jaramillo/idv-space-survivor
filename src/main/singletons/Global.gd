extends Node

var charater_resource = null
var player = null:
	set(value):
		player = value
		Events.player_ready.emit()
var money: int = 100:
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
		if(value.type == StoreResource.Types.WEAPON):
			weapon_resource_selected.emit(value)
		if(value.type == StoreResource.Types.UPGRADE):
			upgrade_resource_selected.emit(value)
var wave_timer
var pick_up_container = Node.new()

signal money_changed(value)
signal selected_resource_changed(value)
signal weapon_selected_changed(value)
signal upgrade_resource_selected()
signal weapon_resource_selected()
