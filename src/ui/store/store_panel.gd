extends PanelContainer

@export var current_pool: PoolResource 
@export var pools: Array[PoolResource]
@onready var store_option_1 = $VBoxContainer/StoreOption1
@onready var store_option_2 = $VBoxContainer/StoreOption2
@onready var store_option_3 = $VBoxContainer/StoreOption3
@onready var store_option_4 = $VBoxContainer/StoreOption4
@onready var roll_button = $VBoxContainer/HBoxContainer/PanelContainer/RollButton
@onready var audio_stream_player = $AudioStreamPlayer
@onready var update_button = $VBoxContainer/HBoxContainer/UpdateButton
@export var roll_audio: AudioStream
@export var upgrade_audio: AudioStream
var store_options: Array[StoreOption]
@onready var level_count = $VBoxContainer/HBoxContainer2/LevelCount
@onready var max_level = $VBoxContainer/HBoxContainer/MaxLevel

func _ready():
	store_options.append_array([store_option_1, store_option_2, store_option_3, store_option_4])
	Events.wave_finished.connect(restock_store.unbind(1))
	setup_store()
	level_count.text = "1"
	
func setup_store():
	for option in store_options:
		option.store_option_buy.connect(restock_option)
	self.restock_store()

func restock_store():
	for option in store_options:
		var recurso = current_pool.pool.pick_random()
		option.set_option(recurso)
		
func restock_option(_option):
	pass
	#option.set_option(current_pool.pool.pick_random())
	
func _on_roll_button_pressed():
	if (Global.money >= 5):
		restock_store()
		Global.money = Global.money - 5
		audio_stream_player.stream = roll_audio
		audio_stream_player.play()

func _on_update_button_pressed():
	if (Global.money >= 30 && current_pool.level < pools.size()):
		current_pool = pools[current_pool.level]
		level_count.text = str(current_pool.level)
		restock_store()
		Global.money = Global.money - 30
		audio_stream_player.stream = upgrade_audio
		audio_stream_player.play()
		if(current_pool.level == pools.size()):
			update_button.hide()
			max_level.show()
			level_count.text = "MAX"
