class_name EnemyAttackState
extends State

@export var attack_manager: AttackManager
@export var attack_range: Area2D
@export var hurtbox: HurtboxComponent

func enter(_data):
	actor.velocity = Vector2.ZERO
	if(!hurtbox.is_connected("hurt", change_to_knockback)):
		hurtbox.hurt.connect(change_to_knockback)

func update(_delta):
	var direction = actor.global_position.direction_to(Global.player.global_position).normalized()
	update_animation(direction)
	if attack_range.has_overlapping_areas(): 
		attack_manager.attack()
	else:
		state_transition.emit(self, "follow")
		
func change_to_knockback(hitbox):
	var knockback = hitbox.knockback - actor.stats.KB_RESISTANCE
	if (knockback > 0 and !actor.stun): 
		state_transition.emit(self, "knockback", hitbox)

func update_animation(direction: Vector2):
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			animation_player.play("idle_right")
		else:
			animation_player.play("idle_left")
	else:
		if direction.y > 0:
			animation_player.play("idle_down")
		else:
			animation_player.play("idle_up")
