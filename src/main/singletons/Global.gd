extends Node

var player = null
var weapon_selected
var wave_timer
var wave_container
var money: int = 0:
	set(value):
		money = value
		money_changed.emit(value)

signal money_changed(new_value)
signal start_wave()
signal wave_start(wave_number: int)
signal wave_finished()
signal projectile_impacted(position, direction)
