extends CanvasLayer

@onready var duration = $Duration

func _ready():
	duration.start(5)

func _on_duration_timeout():
	Events.start_next_wave.emit()
	self.hide()
