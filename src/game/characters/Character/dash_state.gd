class_name DashPlayerState
extends State

@onready var ghost_timer = $GhostTimer
@onready var dash_duration = $DashDuration
@export var ghost_scene: PackedScene
const FLASH_MATERIAL = preload("res://src/scripts/effects/white_flash_material.tres")
var dash_direction = Vector2()
var dash_speed = 2
var delay
var sprite

func enter(_data):
	actor.sprite.material = FLASH_MATERIAL
	actor.change_invencibility(true)
	self.sprite = actor.sprite
	actor.can_shoot = false
	actor.can_dash = false
	dash_duration.start(0.3)
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
	
func _on_dash_duration_timeout():
	actor.can_shoot = true
	actor.start_dash_delay()
	ghost_timer.stop()
	actor.sprite.material = null
	actor.change_invencibility(false)
	state_transition.emit(self, "idle")

func _on_ghost_timer_timeout():
	create_ghost()
