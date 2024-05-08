extends KinematicBody2D

onready var stun_timer = $StunTimer

export (int) var SPEED = 150
var VELOCITY = Vector2()
var STUN = false
var HP = 4
var DAMAGE = 2

func _process(delta):
	if Global.player != null and STUN == false:
		VELOCITY = global_position.direction_to(Global.player.global_position)
		
	elif STUN:
		VELOCITY = lerp(VELOCITY, Vector2(0,0), 0.3)
	
	VELOCITY = VELOCITY.normalized()
	global_position += VELOCITY * SPEED * delta
	
	if HP <= 0:
		queue_free()

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager") and STUN == false:
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
