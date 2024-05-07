extends Sprite

onready var cannon = $Cannon

export (float) var ACCELERATION:float = 20.0
export (float) var SPEED_LIMIT:float = 600.0
export (float) var FRICTION_WEIGHT:float = 0.1

var velocity:Vector2 = Vector2.ZERO
var projectile_container

### PLAYER STATS
var HP = 10
var HP_MAX = 10

var DAMAGE_MUL = 1  
var RATE_OF_FIRE_MUL = 1
var RANGE_MUL = 1
###


func initialize(projectile_container):
	self.projectile_container = projectile_container
	cannon.projectile_container = projectile_container

func _physics_process(delta):
	
	# Cannon rotation
	var mouse_position:Vector2 = get_global_mouse_position()
	cannon.look_at(mouse_position)
	
	# Cannon fire
	if Input.is_action_pressed("fire_cannon"):
		if projectile_container == null:
			projectile_container = get_parent()
			cannon.projectile_container = projectile_container
		cannon.fire(DAMAGE_MUL)
	
	# Player movement
	var h_movement_direction:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	var v_movement_direction:int = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	if h_movement_direction != 0:
		velocity.x = clamp(velocity.x + (h_movement_direction * ACCELERATION), -SPEED_LIMIT, SPEED_LIMIT)
	else:
		velocity.x = lerp(velocity.x, 0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0
		
	if v_movement_direction != 0:
		velocity.y = clamp(velocity.y + (v_movement_direction * ACCELERATION), -SPEED_LIMIT, SPEED_LIMIT)
	else:
		velocity.y = lerp(velocity.y, 0, FRICTION_WEIGHT) if abs(velocity.y) > 1 else 0
	
	position += velocity * delta
