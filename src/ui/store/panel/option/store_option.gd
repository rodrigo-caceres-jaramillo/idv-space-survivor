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
	buy_button.text = str(_store_option.price)

func _on_buy_button_pressed():
	if (Global.money >= store_option_resource.price):
		if (store_option_resource.type == store_option_resource.Types.WEAPON):
			if (Global.player.weapon_manager.weapons.size() < 2):
				Global.money = Global.money - store_option_resource.price
				Global.player.add_store_resource(store_option_resource)
				store_option_buy.emit(self)
		if (store_option_resource.type == store_option_resource.Types.UPGRADE):
			Global.money = Global.money - store_option_resource.price
			Global.player.add_store_resource(store_option_resource)
			store_option_buy.emit(self)

func _on_select_button_pressed():
	if (store_option_resource.type == store_option_resource.Types.WEAPON):
		Global.weapon_selected_resource = store_option_resource
		
signal store_option_buy(option: StoreOption)
