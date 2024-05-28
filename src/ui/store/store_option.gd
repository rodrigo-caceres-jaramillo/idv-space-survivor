extends PanelContainer

@export var store_option_resource: StoreResource
@onready var sprite_option = $HBoxContainer/SpriteOption
@onready var option_name = $HBoxContainer/VBoxContainer/OptionName
@onready var description = $HBoxContainer/VBoxContainer/Description
@onready var buy_button = $HBoxContainer/BuyButton

func set_option(_store_option: StoreResource):
	sprite_option.texture = _store_option.icon
	option_name.text = str(_store_option.name)
	description.text = str(_store_option.description)
	buy_button.text = str(_store_option.price)
