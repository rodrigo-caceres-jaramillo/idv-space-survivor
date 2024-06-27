class_name Character
extends CharacterBody2D

@onready var hurt_component = $HurtComponent
@onready var collision_shape = $CollisionShape
@onready var hurtbox_component = $HurtboxComponent as HurtboxComponent
@onready var weapon_manager = $WeaponManager
@onready var upgrade_manager = $UpgradeManager
@onready var items_manager = $ItemsManager
@onready var dash_delay_timer = $DashDelayTimer
@onready var sprite = $Sprite
@onready var state_machine = $StateMachine
@export var stats: PlayerStats
@onready var health_bar_component = $HealthBarComponent
@export var playerSfx: AudioStreamPlayer
@export var dash_sfx: AudioStream 
@export var dash_notify_sfx: AudioStream 
var initial_weapon: WeaponResource
var dash_delay = 1
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
	Events.wave_finished.connect(health_to_max.unbind(1))

func _physics_process(_delta):
	if Input.is_action_just_pressed("primary_weapon"):
		weapon_manager.equip_weapon(0)
	if Input.is_action_just_pressed("secondary_weapon"):
		weapon_manager.equip_weapon(1)
	if Input.is_action_just_pressed("melee_weapon"):
		weapon_manager.equip_weapon(2)
	if(can_shoot):
		if Input.is_action_pressed("fire_weapon"):
			self.weapon_manager.shoot_weapon()
		if Input.is_action_just_pressed("reload"):
			self.weapon_manager.reload_weapon()
		
func health_to_max():
	stats.HEALTH = stats.MAX_HEALTH

func add_store_resource(resource: StoreResource):
	match resource.type:
		StoreResource.ResourceTypes.WEAPON:
			return weapon_manager.add_weapon(resource)
		StoreResource.ResourceTypes.ITEM:
			return items_manager.add_item(resource)
		StoreResource.ResourceTypes.UPGRADE:
			return upgrade_manager.apply_upgrade(resource)

func start_dash_delay():
	_audio_player(dash_sfx)
	dash_delay_timer.start(dash_delay)
	Events.dash_finished.emit(dash_delay)
	
func change_invencibility(state):
	hurtbox_component.is_invincible = state
	#collision_shape.disabled = state

func _on_dash_delay_timeout():
	_audio_player(dash_notify_sfx)
	can_dash = true
	
func _audio_player(audio:AudioStream):
	playerSfx.stream = audio
	playerSfx.play()
