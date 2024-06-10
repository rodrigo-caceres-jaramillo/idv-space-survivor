extends Camera2D

var shake_amount: float = 0
var defauñt_offset: Vector2 = offset
var pos_x: int
var pos_y: int
@onready var shake_timer = $ShakeTimer
@onready var tween: Tween = create_tween()

func _ready():
	set_process(true)
	Global.camera = self
	randomize()

func _process(_delta):
	offset = Vector2(randf_range(-1, 1) * shake_amount, randf_range(-1, 1) * shake_amount)

func shake(time:float, amount: float):
	shake_timer.wait_time = time
	shake_amount = amount
	set_process(true)
	shake_timer.start()

func _on_shake_timer_timeout():
	set_process(false)
	tween.interpolate_value(self, "offset", 1, 1, tween.TRANS_LINEAR, tween.EASE_IN)
