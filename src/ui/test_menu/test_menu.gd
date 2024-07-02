extends CanvasLayer

@export var weapons: Array[WeaponResource]
@export var weapon_option: PackedScene
@onready var v_box_container = $PanelContainer/VBoxContainer/ScrollContainer/VBoxContainer

func _ready():
	for weapon in weapons:
		var weapon_op = weapon_option.instantiate()
		v_box_container.add_child(weapon_op)
		weapon_op.set_up(weapon)
