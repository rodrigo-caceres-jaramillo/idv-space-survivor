class_name Character
extends CharacterBody2D

@onready var hurt_component = $HurtComponent
@onready var weapon_manager = $WeaponManager
@onready var upgrade_manager = $UpgradeManager
@onready var sprite = $Sprite
@onready var state_machine = $StateMachine
@export var stats: PlayerStats
@onready var health_bar_component = $HealthBarComponent
var initial_weapon: Weapon
var stun = false
var can_dash = true
var can_shoot = true

func _ready():
	hurt_component.stats = stats
	upgrade_manager.stats = stats
	health_bar_component.stats = stats
	health_bar_component.start()
	stats.no_health.connect(
		func():
		self.hide()
	)
	Events.player_ready.emit()
	Events.wave_finished.connect(stats.health_to_max.unbind(1))
	Events.wave_started.connect(stats.health_to_max.unbind(1))

func equip_weapon(weapon: Weapon):
	weapon_manager.add_weapon(weapon)
	
func equip_upgrade(upgrade: Upgrade):
	if upgrade.upgrade_type == 1:
		upgrade_manager.add_upgrade(upgrade)
	elif upgrade.upgrade_type == 2:
		weapon_manager.add_upgrade(upgrade)
