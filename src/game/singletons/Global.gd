extends Node

var wave_container = null
var player = null
var wave = 1
var timer = null
var money: int = 0:
	set(value):
		money = value
		money_changed.emit(value)

signal money_changed(new_value)
