class_name Character
extends CharacterBody2D

@onready var hurt_component = $HurtComponent
@onready var hurtbox_component = $HurtboxComponent as HurtboxComponent
@onready var weapon_manager = $WeaponManager
@onready var upgrade_manager = $UpgradeManager
@onready var items_container = $ItemsContainer
@onready var move_input_component = $MoveInputComponent
@onready var player_camera = $PlayerCamera
var max_camera_offset: float = 40.0
var initial_weapon: StoreWeapon
var stats: PlayerStats
var stun = false

func _ready():
	hurt_component.stats = stats
	upgrade_manager.stats = stats
	weapon_manager.set_up(stats, initial_weapon)
	move_input_component.stats = stats
	stats.no_health.connect(
		func():
		self.hide()
	)
	Events.player_ready.emit()
	Events.wave_started.connect(health_to_max)

func _process(_delta):
	var mouse_position:Vector2 = get_global_mouse_position()
	var direction = mouse_position - global_position
	var distance = direction.length()
	if distance > max_camera_offset:
		direction = direction.normalized() * max_camera_offset
	player_camera.position = direction
	weapon_manager.look_at(mouse_position)
	if mouse_position.x > global_position.x: 
		weapon_manager.scale.y = 1 
	else: 
		weapon_manager.scale.y = -1
	if Input.is_action_pressed("fire_weapon"):
		weapon_manager.shoot_weapon()
	if Input.is_action_just_pressed("reload"):
		weapon_manager.reload_weapon()
	if Input.is_action_just_pressed("change_weapon"):
		weapon_manager.switch_weapon()

func health_to_max():
	stats.HEALTH = stats.MAX_HEALTH
func add_store_resource(resource: StoreResource):
	match resource.type:
		StoreResource.Types.WEAPON:
			weapon_manager.add_weapon(resource)
		StoreResource.Types.ITEM:
			items_container.add_item(resource)
		StoreResource.Types.UPGRADE:
			print("upgrade comprado")
			upgrade_manager.apply_upgrade(resource)
