class_name StoreOption
extends PanelContainer

@export var sale_option: Equipment
@export var buy_audio: AudioStream
@export var select_audio: AudioStream
@onready var sprite_option = $HBoxContainer/PanelContainer/SpriteOption
@onready var option_name = $HBoxContainer/VBoxContainer/ScrollContainer/OptionName
@onready var description = $HBoxContainer/VBoxContainer/Description
@onready var buy_button = $HBoxContainer/ButtonContainer/BuyButton
@onready var select_button = $SelectButton
@onready var audio_stream_player = $AudioStreamPlayer

func set_option(_sale_option: Equipment):
	sale_option = _sale_option
	sprite_option.texture = _sale_option.icon
	option_name.text = str(_sale_option.name)
	description.text = str(_sale_option.description)
	buy_button.show()
	buy_button.text = "Buy " + str(_sale_option.price)

func _on_buy_button_pressed():
	if (Global.money >= sale_option.price):
		audio_stream_player.stream = select_audio
		audio_stream_player.play()
		if(sale_option.type == 0):
			Global.player.equip_weapon(sale_option)
			empty_self()
		elif(sale_option.type == 1):
			print("buy upgrade")
			Global.player.equip_upgrade(sale_option)
			empty_self()


func empty_self():
	audio_stream_player.stream = buy_audio
	audio_stream_player.play()
	Global.money = Global.money - sale_option.price
	sale_option = null
	sprite_option.texture = null
	option_name.text = ""
	description.text = ""
	buy_button.hide()
	store_option_buy.emit(self)
	
func _on_select_button_pressed():
	audio_stream_player.stream = select_audio
	audio_stream_player.play()
	if(!sale_option == null):
		Global.sale_option_selected = sale_option
		
signal store_option_buy(option: StoreOption)
