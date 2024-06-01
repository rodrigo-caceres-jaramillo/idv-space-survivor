class_name StoreOption
extends PanelContainer

@export var store_option_resource: StoreResource
@onready var sprite_option = $HBoxContainer/SpriteOption
@onready var option_name = $HBoxContainer/VBoxContainer/OptionName
@onready var description = $HBoxContainer/VBoxContainer/Description
@onready var buy_button = $HBoxContainer/BuyButton

func set_option(_store_option: StoreResource):
	store_option_resource = _store_option
	sprite_option.texture = _store_option.icon
	option_name.text = str(_store_option.name)
	description.text = str(_store_option.description)
	buy_button.text = str(_store_option.price)

func _on_buy_button_pressed():
	Global.player.add_store_resource(store_option_resource)
	store_option_buy.emit(self)
	
signal store_option_buy(option: StoreOption)
