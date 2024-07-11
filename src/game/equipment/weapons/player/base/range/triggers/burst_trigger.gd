class_name BurstTriggerType
extends TriggerType

var fire_rate_timer = Timer.new()
var burst_timer = Timer.new()
var shots_fired_in_burst = 0
var burst_shots = 3 # Number of shots in each burst
var burst_delay = 0.1 # Delay between each shot in the burst

func _ready():
	add_child(fire_rate_timer)
	add_child(burst_timer)
	range_weapon.change_state.connect(set_state)
	fire_rate_timer.timeout.connect(func(): range_weapon.can_shoot = true)
	burst_timer.timeout.connect(shoot_burst)

func _process(_delta):
	if Input.is_action_just_pressed("fire_weapon"):
		if range_weapon.reloading: return
		if range_weapon.current_ammo > 0: start_burst()
		else: range_weapon.reload_try.emit()

func start_burst():
	if not range_weapon.can_shoot: return
	shots_fired_in_burst = 0
	range_weapon.can_shoot = false
	burst_timer.start(burst_delay)

func shoot_burst():
	if shots_fired_in_burst < burst_shots and range_weapon.current_ammo > 0:
		shoot()
	else:
		burst_timer.stop()
		print("timer start")
		fire_rate_timer.start(1.0/range_weapon.stats.FIRE_RATE)

func shoot():
	shots_fired_in_burst += 1
	var flash = range_weapon.muzzle_flash.instantiate()
	weapon_tip.add_child(flash)
	flash.global_rotation = self.weapon_tip.global_position.direction_to(get_global_mouse_position()).angle()
	flash.emitting = true
	Global.camera.shake(0.1, range_weapon.stats.KNOCKBACK*0.3)
	range_weapon.current_ammo -= 1
	Events.weapon_ammo_changed.emit(range_weapon.current_ammo)
	spawn_projectile()
	fire_start.emit()
	burst_timer.start(burst_delay)

func spawn_projectile():
	for i in range(range_weapon.stats.MULTISHOT):
		var angle = range_weapon.global_rotation - randf_range(-range_weapon.stats.SPREAD, range_weapon.stats.SPREAD)
		var spread_direction = Vector2(cos(angle), sin(angle)).normalized()
		var projectile = range_weapon.projectile.instantiate()
		get_tree().current_scene.add_child(projectile)
		projectile.initialize(range_weapon.stats, weapon_tip.global_position, spread_direction)
