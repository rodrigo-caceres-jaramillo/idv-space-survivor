extends TextureProgressBar

@onready var weapon_container = $"../WeaponContainer"
var reload_time = 0.0
var elapsed_time = 0.0
var is_reloading = false

func _ready():
	self.visible = false
	weapon_container.weapon_reload.connect(start_reload)

func start_reload(time):
	reload_time = time
	elapsed_time = 0.0
	is_reloading = true
	self.visible = true
	self.value = 0.0 

func _process(delta):
	if is_reloading:
		elapsed_time += delta
		self.value = elapsed_time / reload_time * 100.0  # Actualiza el valor de la barra de progreso

		if elapsed_time >= reload_time:
			is_reloading = false
			self.visible = false
