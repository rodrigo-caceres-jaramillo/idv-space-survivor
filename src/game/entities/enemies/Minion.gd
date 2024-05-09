extends KinematicBody2D

onready var stun_timer = $StunTimer

export (int) var SPEED = 150
var VELOCITY = Vector2()
var STUN = false
var HP = 4
var DAMAGE = 2
var SPWANING = true

var money = preload("res://src/game/entities/money/Money.tscn")

func _ready():
	modulate= Color.black

func _process(delta):
	if Global.player != null and STUN == false:
		VELOCITY = global_position.direction_to(Global.player.global_position)
		
	elif STUN:
		VELOCITY = lerp(VELOCITY, Vector2(0,0), 0.3)
	
	VELOCITY = VELOCITY.normalized()
	global_position += VELOCITY * SPEED * delta
	self._hp_process()
	
func _hp_process():
	if HP <= 0:
		Global.instance_wave_node(money, self.global_position)
		queue_free()

func attackPlayer():
	if (SPWANING):
		return 0
	else:
		return self.DAMAGE

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager") and !STUN and !SPWANING:
		modulate = Color.black
		VELOCITY = -VELOCITY * 3
		STUN = true
		stun_timer.start()
		var proyectile = area.get_parent()
		HP -= proyectile.DAMAGE
		proyectile.queue_free()

func _on_StunTimer_timeout():
	modulate = Color.white
	STUN = false

func _on_SpawningTimer_timeout():
	SPWANING = false
	modulate= Color.white
