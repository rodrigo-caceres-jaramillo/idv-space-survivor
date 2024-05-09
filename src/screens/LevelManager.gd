extends Node

export (String) var main_menu_path: String

onready var current_level_container: Node = $CurrentLevelContainer

var level: int = 0



func _ready() -> void:
	call_deferred("_setup_level", level)


