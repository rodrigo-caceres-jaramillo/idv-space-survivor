class_name DashPlayerState
extends State

@export var hurtbox: HurtboxComponent
@export var ghost_scene: PackedScene
@export var dash_audio: AudioStream
@export var dash_ready_audio: AudioStream
@onready var delay_timer = Timer.new()
@onready var duration_timer = Timer.new()
@onready var ghost_timer = Timer.new()
const FLASH_MATERIAL = preload("res://src/scripts/effects/white_flash_material.tres")
var dash_direction = Vector2()
var dash_speed = 2
var dash_delay = 1
var delay
var sprite

func _ready():
	add_child(delay_timer)
	delay_timer.one_shot = true
	delay_timer.timeout.connect(dash_ready)
	add_child(duration_timer)
	duration_timer.one_shot = true
	duration_timer.timeout.connect(dash_finish)
	add_child(ghost_timer)
	ghost_timer.wait_time = 0.1
	ghost_timer.timeout.connect(func():create_ghost())

func enter(_data):
	actor.sprite.material = FLASH_MATERIAL
	hurtbox.is_invincible = true
	audio_manager.play_sound(dash_audio)
	self.sprite = actor.sprite
	actor.can_shoot = false
	actor.can_dash = false
	duration_timer.start(0.3)
	ghost_timer.start()
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction.normalized()
	actor.velocity = (direction * actor.stats.FINAL_SPEED * dash_speed)
	create_ghost()

func physics_update(_delta : float):
	actor.move_and_slide()

func create_ghost():
	var ghost = ghost_scene.instantiate()
	ghost.set_property(actor.global_position, sprite.scale)
	ghost.texture = sprite.texture
	ghost.vframes = sprite.vframes
	ghost.hframes = sprite.hframes
	ghost.frame = sprite.frame
	actor.add_child(ghost)
	
func dash_finish():
	actor.can_shoot = true
	start_dash_delay()
	ghost_timer.stop()
	actor.sprite.material = null
	hurtbox.is_invincible = false
	state_transition.emit(self, "idle")
	
func dash_ready():
	actor.can_dash = true
	audio_manager.play_sound(dash_ready_audio)
	
func start_dash_delay():
	delay_timer.start(dash_delay)
	Events.dash_finished.emit(dash_delay)
