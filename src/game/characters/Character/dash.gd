extends Node2D

@onready var dash_duration = $StateMachine/Dash/DashDuration
@onready var dash_delay = $StateMachine/Dash/DashDelay
var character
var can_dash

func start_dash(duration):
	if(can_dash):
		duration_timer.wait_time = duration
		duration_timer.start()

func is_dashing():
	return !duration_timer.is_stopped()

func _on_duration_timer_timeout():
	can_dash = false

func _on_delay_timer_timeout():
	can_dash = true
