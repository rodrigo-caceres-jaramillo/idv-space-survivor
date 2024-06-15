extends TextureProgressBar

var delay_time = 0.0
var elapsed_time = 0.0
var is_reloading = false

func _ready():
	Events.dash_finished.connect(start_reload)

func start_reload(time):
	delay_time = time
	elapsed_time = 0.0
	is_reloading = true
	self.value = 0.0 

func _process(delta):
	if is_reloading:
		elapsed_time += delta
		self.value = elapsed_time / delay_time * 100.0
		if elapsed_time >= delay_time:
			is_reloading = false
