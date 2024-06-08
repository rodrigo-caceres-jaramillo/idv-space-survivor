extends Node

var charater_resource = null
var player = null:
	set(value):
		player = value
		Events.player_ready.emit()
var money: int = 10:
	set(value):
		money = value
		money_changed.emit(value)
var store_option_selected:StoreResource :
	set(value):
		store_option_selected = value
		store_option_selected_changed.emit(value)
var wave_timer
var pick_up_container = Node.new()

signal money_changed(value)
signal store_option_selected_changed(value)
