class_name MagazineReloadType
extends ReloadType

var reload_timer= Timer.new()

func _ready():
	add_child(reload_timer)
	range_weapon.reload_try.connect(reload)
	reload_timer.timeout.connect(reload_finish)

func reload():
	if range_weapon.current_ammo <= range_weapon.stats.MAGAZINE and not range_weapon.reloading:
		reload_started.emit()
		range_weapon.reloading = true
		reload_timer.start(range_weapon.stats.RELOAD)
		Events.weapon_reload_start.emit(range_weapon.stats.RELOAD)

func reload_finish():
	reload_finished.emit()
	range_weapon.current_ammo = range_weapon.magazine_size
	range_weapon.reloading = false
	Events.weapon_ammo_changed.emit(range_weapon.current_ammo)
	reload_timer.stop()
	

