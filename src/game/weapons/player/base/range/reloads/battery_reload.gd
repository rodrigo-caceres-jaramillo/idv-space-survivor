class_name BatteryReloadType
extends ReloadType

var recharge_timer= Timer.new()
var recharge_delay= Timer.new()

func _ready():
	add_child(recharge_timer)
	add_child(recharge_delay)
	range_weapon.shoot_try.connect(restart_delay)
	recharge_delay.timeout.connect(start_recharge)
	recharge_timer.timeout.connect(recharge)

func restart_delay():
	recharge_delay.one_shot = true
	recharge_delay.start(1)

func start_recharge():
	recharge_timer.start(0.5)

func recharge():
	if(range_weapon.current_ammo < range_weapon.magazine_size):
		range_weapon.current_ammo += 1
		Events.weapon_ammo_changed.emit(range_weapon.current_ammo)
	else:
		recharge_timer.stop()
