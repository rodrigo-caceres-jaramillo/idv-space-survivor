class_name EnemyKnockbackState
extends State

func enter(_data):
	var knockback = _data.knockback - actor.stats.KB_RESISTANCE
	actor.stun = true
	var direction = (actor.global_position - _data.global_position).normalized()
	actor.velocity = actor.stats.FINAL_SPEED * -direction * knockback
	get_tree().create_timer(0.05).timeout.connect(change_to_follow)

func exit():
	actor.stun= false

func physics_update(_delta):
	actor.move_and_slide()
	
func change_to_follow():
	state_transition.emit(self, "follow")
