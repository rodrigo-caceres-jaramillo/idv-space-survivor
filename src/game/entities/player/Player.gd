extends CharacterBody2D

@onready var hurt_component = $HurtComponent
@export var stats: PlayerStats
@onready var hurtbox_component = $HurtboxComponent as HurtboxComponent
@onready var weapon_container = $WeaponContainer
@onready var upgrade_manager = $UpgradeManager
@onready var items_container = $ItemsContainer
@onready var move_input_component = $MoveInputComponent
@onready var player_camera = $Camera2D
var max_camera_offset: float = 40.0
var stun = false

func _ready():
	hurt_component.stats = stats
	upgrade_manager.stats = stats
	weapon_container.stats = stats
	move_input_component.stats = stats
	stats.no_health.connect(
		func():
		self.hide()
	)
	Global.player = self
	
func _process(_delta):
	var mouse_position:Vector2 = get_global_mouse_position()
	var direction = mouse_position - global_position
	var distance = direction.length()
	if distance > max_camera_offset:
		direction = direction.normalized() * max_camera_offset
	player_camera.position = direction
	weapon_container.look_at(mouse_position)
	if Input.is_action_pressed("fire_weapon"):
		weapon_container.shoot_weapon()
	if Input.is_action_just_pressed("reload"):
		weapon_container.reload_weapon()
	if Input.is_action_just_pressed("change_weapon"):
		weapon_container.switch_weapon()

func add_store_resource(resource: StoreResource):
	match resource.type:
		StoreResource.Types.WEAPON:
			weapon_container.add_weapon(resource)
		StoreResource.Types.ITEM:
			items_container.add_item(resource)
		StoreResource.Types.UPGRADE:
			print("upgrade comprado")
			upgrade_manager.apply_upgrade(resource)
	
