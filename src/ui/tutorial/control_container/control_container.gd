extends HBoxContainer


@export var action_text: String
@export var control_text: String
@onready var action = $Action
@onready var control = $Control

func _ready():
	action.text = action_text
	control.text = control_text
