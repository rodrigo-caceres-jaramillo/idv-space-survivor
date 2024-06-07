extends PanelContainer

@export var current_pool: PoolResource
@onready var store_option_1 = $VBoxContainer/StoreOption1
@onready var store_option_2 = $VBoxContainer/StoreOption2
@onready var store_option_3 = $VBoxContainer/StoreOption3
@onready var store_option_4 = $VBoxContainer/StoreOption4
@onready var store_option_5 = $VBoxContainer/StoreOption5

@onready var roll_button = $VBoxContainer/RollButton

var store_options: Array[StoreOption]

func _ready():
	store_options.append_array([store_option_1, store_option_2, store_option_3, store_option_4, store_option_5])
	setup_store()
	
func setup_store():
	for option in store_options:
		option.store_option_buy.connect(restock_option)
	self.restock_store()

func restock_store():
	for option in store_options:
		var recurso = current_pool.pool.pick_random()
		option.set_option(recurso)
		
func restock_option(option):
	option.set_option(current_pool.pool.pick_random())
	
func _on_roll_button_pressed():
	if (Global.money >= 5):
		restock_store()
		Global.money = Global.money - 5
