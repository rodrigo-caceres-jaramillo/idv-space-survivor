extends Node

var player = null
var timer = null
var wave_container: Node
var wave:int = 1
var money: int = 0:
	set(value):
		money = value
		money_changed.emit(value)

func next_wave():
	wave += 1
	wave_changed.emit(wave)

signal money_changed(new_value)
signal wave_changed(new_value)
signal projectile_impacted(position, direction)
