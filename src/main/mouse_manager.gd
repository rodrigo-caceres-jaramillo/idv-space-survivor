extends Node2D


func _ready():
	Events.current_weapon_changed.connect(update_mouse)
	Events.wave_finished.connect(show_default_mouse)
	Input.set_custom_mouse_cursor(null)

func update_mouse(weapon):
	Input.set_custom_mouse_cursor(weapon.crosshair, Input.CURSOR_ARROW, Vector2(16,32))

func show_default_mouse():
	Input.set_custom_mouse_cursor(null)
