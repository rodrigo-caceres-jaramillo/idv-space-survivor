class_name EnemyKnockbackState
extends State

@onready var stun_timer = $StunTimer

func enter(_data):
	print("enter knockback")
	var knockback = _data.knockback - actor.stats.KB_RESISTANCE
	if(!stun_timer.is_connected("timeout", change_to_follow)):
		stun_timer.timeout.connect(change_to_follow)
	actor.stun = true
	stun_timer.start(0.05)
	var direction = (actor.global_position - _data.global_position).normalized()
	actor.velocity = actor.stats.FINAL_SPEED * -direction * knockback

func exit():
	actor.stun= false

func physics_update(_delta):
	actor.move_and_slide()
	
func change_to_follow():
	state_transition.emit(self, "follow")
