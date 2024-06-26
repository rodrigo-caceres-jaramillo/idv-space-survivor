extends KinematicBody2D

onready var weapon = $Weapon
onready var invulnerability_timer = $InvulnerabilityTimer

export (int) var SPEED = 200
export (float) var DAMAGE_MUL:float = 1
export (float) var MAX_HP = 10
var HP = 10

var VELOCITY= Vector2()
var INVUNERABLE = false
var projectile_container

func _ready():
	Global.player = self
	self.HP = self.MAX_HP
	
func heal_to_max():
	self.HP = self.MAX_HP
	
func _exit_tree():
	Global.player = null

func _physics_process(delta):
	self.movement(delta)
	self.aim_and_shoot()
	if HP <= 0:
		queue_free()
	
func movement(delta):
	VELOCITY.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	VELOCITY.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	VELOCITY = VELOCITY.normalized()
	global_position += SPEED * VELOCITY * delta

func aim_and_shoot():
	var mouse_position:Vector2 = get_global_mouse_position()
	weapon.look_at(mouse_position)
	if Input.is_action_pressed("fire_cannon"):
		if projectile_container == null:
			projectile_container = Global.main
			weapon.projectile_container = projectile_container
		weapon.fire(DAMAGE_MUL)
		
func takeDamage(damager):
	var damage = damager.attack()
	if (damage):
		INVUNERABLE = true
		modulate = Color.red
		invulnerability_timer.start()
		HP -= damage
		
func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy") and INVUNERABLE == false:
		var enemy = area.get_parent()
		self.takeDamage(enemy)
		
func _on_InvulnerabilityTimer_timeout():
	modulate = Color.white
	INVUNERABLE = false
