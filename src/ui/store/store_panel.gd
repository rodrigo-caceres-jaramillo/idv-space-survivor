extends Panel

@export var pools: Dictionary
var current_pool: PoolResource
var store_options: Array
@onready var store_option_1 = $VBoxContainer/StoreOption
@onready var store_option_2 = $VBoxContainer/StoreOption2
@onready var store_option_3 = $VBoxContainer/StoreOption3
@onready var store_option_4 = $VBoxContainer/StoreOption4
@onready var roll_button = $RollButton

func _ready():
	current_pool = pools[1]
	setup_store()

func get_store_options():
	store_options.clear()
	for option in 4:
		store_options.append(current_pool.pool.pick_random())

func set_store_options():
	store_option_1.set_option(store_options[0])
	store_option_2.set_option(store_options[1])
	store_option_3.set_option(store_options[2])
	store_option_4.set_option(store_options[3])
	
func setup_store():
	get_store_options()
	set_store_options()

func _on_roll_button_pressed():
	setup_store()
