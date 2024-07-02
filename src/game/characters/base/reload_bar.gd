extends TextureProgressBar

var reload_time = 0.0
var elapsed_time = 0.0
var is_reloading = false

func _ready():
	self.visible = false
	Events.weapon_reload_start.connect(start_reload)
	
func start_reload(time):
	reload_time = time
	elapsed_time = 0.0
	is_reloading = true
	self.visible = true
	self.value = 0.0 

func _process(delta):
	if is_reloading:
		elapsed_time += delta
		self.value = elapsed_time / reload_time * 100.0
		if elapsed_time >= reload_time:
			is_reloading = false
			self.visible = false
