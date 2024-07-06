class_name TriggerType
extends Node2D

@export var range_weapon: RangeWeapon
@export var weapon_tip: Marker2D

func set_state(value):
	set_process(value)
	
signal fire_start()
