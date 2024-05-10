extends KinematicBody2D

onready var stun_timer = $StunTimer
var money = preload("res://src/game/entities/money/Money.tscn")

export (int) var SPEED = 150
var VELOCITY = Vector2()
var HP = 4
var DAMAGE = 2
var SPWANING = true
var STUN = false

func _ready():
	modulate= Color.black

func _process(delta):
	if Global.player != null and !STUN and !SPWANING:
		VELOCITY = global_position.direction_to(Global.player.global_position)
	elif STUN:
		VELOCITY = lerp(VELOCITY, Vector2(0,0), 0.3)
	
	VELOCITY = VELOCITY.normalized()
	global_position += VELOCITY * SPEED * delta
	self.check_hp()
	
func check_hp():
	if HP <= 0:
		Global.instance_wave_node(money, self.global_position)
		queue_free()

func attack():
	if (SPWANING):
		return 0
	else:
		return self.DAMAGE
		
func takeDamage(damager):
	STUN = true
	modulate = Color.black
	stun_timer.start()
	VELOCITY = -VELOCITY * 3
	var damage = damager.attack()
	HP -= damager.DAMAGE

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager") and !STUN and !SPWANING:
		var damager = area.get_parent()
		self.takeDamage(damager)

func _on_StunTimer_timeout():
	modulate = Color.white
	STUN = false

func _on_SpawningTimer_timeout():
	SPWANING = false
	modulate= Color.white
