class_name AutoTriggerType
extends TriggerType

var fire_rate_timer = Timer.new()

func _ready():
	add_child(fire_rate_timer)
	range_weapon.shoot_try.connect(shoot)
	fire_rate_timer.timeout.connect(func(): range_weapon.can_shoot = true)
	
func shoot():
	if not range_weapon.can_shoot: return
	var flash = range_weapon.muzzle_flash.instantiate()
	weapon_tip.add_child(flash)
	flash.global_rotation = self.weapon_tip.global_position.direction_to(get_global_mouse_position()).angle()
	flash.emitting = true
	Global.camera.shake(0.1, range_weapon.stats.KNOCKBACK*0.3)
	range_weapon.current_ammo -= 1
	Events.weapon_ammo_changed.emit(range_weapon.current_ammo)
	spawn_projectile()
	attack.emit()
	range_weapon.can_shoot = false
	fire_rate_timer.start(1.0/range_weapon.stats.FIRE_RATE)

func spawn_projectile():
	for i in range(range_weapon.stats.MULTISHOT):
		var angle = range_weapon.global_rotation - randf_range( -range_weapon.stats.SPREAD, range_weapon.stats.SPREAD)
		var spread_direction = Vector2(cos(angle), sin(angle)).normalized()
		var projectile = range_weapon.projectile.instantiate()
		get_tree().current_scene.add_child(projectile)
		projectile.initialize(range_weapon.stats, weapon_tip.global_position, spread_direction)

signal attack()
