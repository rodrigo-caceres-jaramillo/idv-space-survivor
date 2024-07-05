extends Node2D

@export var actor: CharacterBody2D
@export var hand_sprite: Texture
@export var weapon_upgrades: Array[Upgrade]
@onready var hand_position = $HandPosition
var stats: PlayerStats
var weapons_resource =  {1:null, 2:null}
var weapons= {1:null, 2:null}
var current_weapon: Node2D
var current_weapon_type: int = 1

func _ready():
	self.stats = actor.stats
	self.load_weapon(actor.initial_weapon)
	self.current_weapon = weapons[actor.initial_weapon.weapon_type]
	self.current_weapon.change_active_state(true)
	self.current_weapon.visible = true
	Events.current_weapon_changed.emit(current_weapon)
	
func _process(_delta):
	if Input.is_action_just_pressed("primary_weapon"):
		equip_weapon(1)
	if Input.is_action_just_pressed("secondary_weapon"):
		equip_weapon(2)
	if Input.is_action_just_pressed("next_weapon"):
		equip_next_weapon()
	if Input.is_action_just_pressed("prev_weapon"):
		equip_prev_weapon()
	var mouse_position:Vector2 = get_global_mouse_position()
	if mouse_position.x > global_position.x: 
		current_weapon.scale.y = 1 
	else: 
		current_weapon.scale.y = -1
	current_weapon.look_at(mouse_position)
	hand_position.look_at(mouse_position)

func remove_weapon(weapon_type):
	var weapon = weapons[weapon_type]
	weapon.queue_free()
	weapons[weapon_type] = null
	weapons_resource[weapon_type] = null

func load_weapon(weapon_resource):
	weapons_resource[weapon_resource.weapon_type] = weapon_resource
	var weapon = weapon_resource.weapon_scene.instantiate()
	self.add_child(weapon)
	weapons[weapon_resource.weapon_type] = weapon
	weapon.set_up(weapon_resource.stats, weapon_upgrades, hand_sprite)
	weapon.position = hand_position.position
	weapon.visible = false
	if(current_weapon):
		self.current_weapon.change_active_state(false)
		self.current_weapon.visible = false
	self.current_weapon = weapon
	self.current_weapon.change_active_state(true)
	self.current_weapon.visible = true
	Events.current_weapon_changed.emit(current_weapon)
	
func add_weapon(weapon_resource):
	if(weapons[weapon_resource.weapon_type]):
		remove_weapon(weapon_resource.weapon_type)
	self.load_weapon(weapon_resource)
	Events.new_weapon_add.emit(weapon_resource)
	return true

func equip_weapon(weapon_type):
	if(weapons[weapon_type] and !(weapon_type == current_weapon_type)):
		self.current_weapon.change_active_state(false)
		self.current_weapon.visible = false
		self.current_weapon = weapons[weapon_type]
		self.current_weapon.change_active_state(true)
		self.current_weapon.visible = true
		self.current_weapon_type = weapon_type
		Events.current_weapon_changed.emit(current_weapon)
		
func equip_next_weapon():
	self.current_weapon.change_active_state(false)
	self.current_weapon.visible = false
	var next_weapon_type = 2 if (current_weapon_type == 1) else 1
	self.current_weapon = weapons[next_weapon_type]
	self.current_weapon.change_active_state(true)
	self.current_weapon.visible = true
	self.current_weapon_type = next_weapon_type
	Events.current_weapon_changed.emit(current_weapon)
		
func equip_prev_weapon():
	self.current_weapon.change_active_state(false)
	self.current_weapon.visible = false
	var prev_weapon_type = 1 if (current_weapon_type == 2) else 2
	self.current_weapon = weapons[prev_weapon_type]
	self.current_weapon.change_active_state(true)
	self.current_weapon.visible = true
	self.current_weapon_type = prev_weapon_type
	Events.current_weapon_changed.emit(current_weapon)
