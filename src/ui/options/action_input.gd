extends Node

@onready var input = %Input
@onready var action = %Action

@export var action_input :String
@export var action_name  :String



func _ready() -> void:
	input.text = action_input
	action.text = action_name
