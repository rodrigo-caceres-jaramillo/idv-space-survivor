extends Node

var player = null:
	set(value):
		player = value
		player_ready.emit(value)
var weapon_selected_resource:StoreWeapon :
	set(value):
		weapon_selected_resource = value
		weapon_selected_resource_changed.emit(value)
var wave_timer
var wave_container
var money: int = 50:
	set(value):
		money = value
		money_changed.emit(value)

signal player_ready()
signal weapon_selected_resource_changed(new_weapon)
signal money_changed(new_value)
#Wave Signals
signal start_wave()
signal wave_start(wave_number: int)
signal wave_finished()
#Weapons Signals
signal current_weapon_changed(weapon: PackedScene)
signal weapon_reload_start(reload_time: int)
signal weapon_ammo_changed(ammo_amount: int)
signal projectile_impacted(position, direction)
