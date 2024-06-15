class_name StoreOption
extends PanelContainer

@export var store_option_resource: StoreResource
@onready var sprite_option = $HBoxContainer/PanelContainer/SpriteOption
@onready var option_name = $HBoxContainer/VBoxContainer/OptionName
@onready var description = $HBoxContainer/VBoxContainer/Description
@onready var buy_button = $HBoxContainer/BuyButton
@onready var select_button = $SelectButton

func set_option(_store_option: StoreResource):
	store_option_resource = _store_option
	sprite_option.texture = _store_option.icon
	option_name.text = str(_store_option.name)
	description.text = str(_store_option.description)
	buy_button.show()
	buy_button.text = str(_store_option.price)

func _on_buy_button_pressed():
	if (Global.money >= store_option_resource.price):
		if(Global.player.add_store_resource(store_option_resource)):
			Global.money = Global.money - store_option_resource.price
			store_option_resource = null
			sprite_option.texture = null
			option_name.text = ""
			description.text = ""
			buy_button.hide()
			store_option_buy.emit(self)

func _on_select_button_pressed():
	if(!store_option_resource == null):
		Global.store_option_selected = store_option_resource
		
signal store_option_buy(option: StoreOption)
